# [DRAFT] Unauthenticated Tenant Disclosure Oracle & Auth Bypass on api.sparelabs.com

> STATUS: All findings reproduced live 2026-08-22 by researcher. Reporting channel NOT yet confirmed (no security.txt / H1 / Bugcrowd / SECURITY.md). Do not send until channel identified. Rules honored: passive-first, <=1 rps, GET only, no account creation.

## Affected Assets (per program scope: In)
- api.sparelabs.com (primary)
- Same fleet per bot telemetry: api.us/us2/us3/jp/eu/uat.sparelabs.com

## Finding 1 - HIGH - Tenant-Disclosure Enumeration Oracle
Endpoint: GET /v1/public/organizations/key/{organizationKey}
Auth: NONE required.
Verified: key=spare -> 200, 351 bytes: {"id":"<org-uuid>","name":"Spare","logoUrl":"https://storage.googleapis.com/spare-production-ca-photos/....jpg","isMaintenanceEnabled":false,"organizationKey":"spare","enabledPublicFeatureFlags":["callForVerificationCode","multimodal","riderEmailAuthentication","riderPhonePin","riderLoginless"]}
Negative control: nonexistent key -> 404 (clean enumeration oracle).
Known-valid keys observed by pipeline: spare, grt, dallas, winnipeg, hsr.
Impact: platform-wide tenant inventory (UUIDs are chaining material for /v1/public/organizations/{uuid}, internal codenames, feature-flag posture incl. auth-related flags riderPhonePin/riderLoginless, GCS bucket paths revealing infra naming).
CVSS 3.1: AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N = 5.3 Medium standalone; High when chained with uuid-oracle/CORS.

## Finding 2 - HIGH - Authentication Bypass (scheme-only validation)
Endpoint: GET /v1/global/regions
Verified: `Authorization: Bearer x` -> 200, 751 bytes listing 7 regions x {apiUrl, routingHost} INCLUDING UAT environment (api.uat.sparelabs.com, routing.uat.sparelabs.com, simulationsEnabled:true). No-auth -> 400.
Root cause: gate checks header presence/scheme only; token value never validated.
Impact: authentication bypass class; full backend topology incl non-prod environments; hands attackers the targeting map for every regional API.
CVSS 3.1: AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N = 7.5 High.

## Finding 3 - MEDIUM (chain primitive) - Universal CORS Reflector
Verified: HEAD request -> 401 BUT still reflects access-control-allow-origin: <attacker origin> + access-control-allow-credentials: true.
Impact: any attacker page can issue credentialed cross-origin requests and READ responses across api.sparelabs.com session-bearing endpoints (journeys OPTIONS preflight also reflects + ACAC). Enables silent data theft from logged-in agency staff browsers.
Note: pipeline logs show inconsistent reflection across replicas (patch partially applied then reverted) - include replica variance table at submission time.

## Finding 4 - LOW (chain) - Fail-open endpoint
GET /v1/global/organizations with zero auth -> 200 {"data":[]}. Currently empty; demonstrates fail-open default worth fixing alongside.

## Context: Patch-Revert Regression
Pipeline telemetry: fixes were applied then FULLY REVERTED (byte-stable re-verification across 7+ intervals: org-key oracle 351B sha256-stable, regions bypass consistent, WorkOS SSO oracle never patched). Frame respectfully in report: regression likely from deploy rollback; include interval evidence.

## Business Impact
Spare Labs operates paratransit/microtransit for PUBLIC TRANSIT AGENCIES (AC Transit, CapMETRO, LA-area services) - riders include elderly and disabled passengers. Tenant UUIDs + feature flags + environment topology materially assist targeted attacks against agency operations (trip booking, eligibility data, dispatch). Cross-origin chain threatens agency staff sessions.

## Remediation
1. Require authenticated + authorized context for /v1/public/* org lookups OR return minimal public fields (name/logo only), never UUID/flags/key.
2. Validate Bearer token cryptographically; reject unknown tokens 401 (not presence check).
3. Restrict CORS reflection to allowlisted origins; never reflect + ACAC on error responses.
4. Fix fail-open defaults; add authz regression tests across ALL /v1/global/* and /v1/public/* handlers.

## Reproduction (copy-paste)
```
curl -s "https://api.sparelabs.com/v1/public/organizations/key/spare"          # 200 tenant record
curl -s -o /dev/null -w '%{http_code}' "https://api.sparelabs.com/v1/public/organizations/key/nope123"   # 404
curl -s -H "Authorization: Bearer x" "https://api.sparelabs.com/v1/global/regions"                        # 200 topology
curl -s -o /dev/null -w '%{http_code}' "https://api.sparelabs.com/v1/global/regions"                      # 400
curl -I -H "Origin: https://attacker.example" "https://api.sparelabs.com/v1/public/organizations/key/spare" | grep -i access-control
```


---

# TRIAGER'S FINAL VERDICT (2026-08-22 deep-dive pass)

## Severity corrections (bot rank vs reality)
| Finding | Bot rank | Post-dig verdict | Why |
|---|---|---|---|
| Org-key oracle | 98 | **REPORTABLE — Medium 5.3** (High only if chained) | Sweep of 20 agency-name keys: ONLY the 5 known keys resolve (spare/grt/dallas/winnipeg/hsr). Not platform-wide; key namespace not naive-guessable. UUID path /v1/public/organizations/{uuid} mirrors same record — same finding, not two. |
| Bearer scheme bypass | 95 | **REPORTABLE — Medium** (downgraded from High) | Battery of 11 sensitive endpoints (users/journeys/riders/vehicles/organizations...) with `Bearer x`: ALL properly 401. Gate flaw is SINGLE-ENDPOINT, not systemic. Topology values are DNS-discoverable public hosts; UAT inclusion is the strongest remaining argument. |
| CORS reflector | - | **DO NOT SUBMIT standalone** (never-submit list) | No credentialed cross-origin read demonstrated; no cookie-authenticated sensitive endpoint identified behind reflection. Mention only as amplifier inside Finding 1 narrative. |
| Fail-open organizations | - | One-liner in same report | {"data":[]} empty; zero standalone value |

## What survives as THE reportable package (one submission)
Combined Medium-High report: unauthenticated tenant inventory of REAL transit agencies
(DART GoLink City of Dallas, Winnipeg Transit, Hamilton Street Railway, GRT) exposing
per-tenant authentication-posture flags (riderPhonePin, riderLoginless,
callForVerificationCode) + GCS bucket naming + UAT environment topology behind a
broken token gate — ON A PLATFORM THAT PATCHED AND REVERTED THESE FIXES.
That regression story is the strongest severity lever; lead with it.

## Escalation leads NOT yet exhausted (would raise severity)
1. organizationKey usage in rider-facing flows (booking/phone-pin) — could turn flags into auth-bypass material. UNTESTED.
2. WorkOS SSO oracle (/v1/identity/workos/auth) — bots claim alive fleet-parity. UNVERIFIED by human.
3. Cookie-authenticated endpoint hunt for the CORS chain. BLOCKED on having an agency/staff session.
