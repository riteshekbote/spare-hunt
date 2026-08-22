## 2026-08-22 STATUS: REPORTED BY HUMAN — AWAITING VENDOR RESPONSE

- SUBMITTED: 2026-08-22 -> security@sparelabs.com + website contact form (same subject line)
- PACKAGE: WorkOS SSO tenant oracle + org-key inventory + regions gate flaw + CORS/fail-open context; attachment sparelabs-poc.sh
- NO CREDENTIALS INVOLVED: all findings unauthenticated/read-only; nothing to rotate
- FOLLOW-UP DUE: 2026-08-29 (7 days, one polite nudge only)
- DO-NOT-REDO: bots must not re-probe reported endpoints or re-draft; this file is the single source of truth

## 2026-08-22 HUMAN-VERIFIED LEADS (independent live re-check, ox-alpha-free)

All three top hypotheses REPRODUCED live on 2026-08-22. Patch-regression context confirmed: fleet had a fix cycle then FULLY REVERTED (bots tracked 7+ byte-stable intervals).


NEXT-ACTIONS: (1) channel discovery — no security.txt/H1/Bugcrowd/SECURITY.md found; try security@sparelabs.com + site contact form in parallel. (2) enumerate more org keys (dictionary of agency names) ONLY after channel confirmed + rules OK. (3) test whether organizationKey/UUID chains into /v1/public/organizations/{uuid} oracle or rider-facing flows.


---
# SUBMISSION UPDATE (2026-08-22, final form)

Published policy DISCOVERED (researcher found it; contains 'Account/email enumeration OOS' +
'no automated scanners' exclusions + 'Authentication issues' accepted category).
Final submission reframed accordingly — 3 scored findings, all under Authentication issues:
  1. HIGH — Bearer presence-only validation on /v1/global/regions (lead finding)
  2. MED-HIGH — WorkOS client_id/connection_id disclosed pre-auth (/v1/identity/workos/auth)
  3. MED — internal org records (UUID/orgKey/auth feature flags) unauthenticated
CORS reflector + fail-open submitted as CONTEXT ONLY (not scored) — correct discipline.
PoC script attached. Manual/read-only/<=1rps attestation included.
ACTION: locate + archive the exact published-policy URL into scope.yml when researcher shares it.
Nudge due 2026-08-29.
