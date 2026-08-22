## 2026-08-22 STATUS: REPORTED BY HUMAN — AWAITING VENDOR RESPONSE

- SUBMITTED: 2026-08-22 -> security@sparelabs.com + website contact form (same subject line)
- PACKAGE: WorkOS SSO tenant oracle + org-key inventory + regions gate flaw + CORS/fail-open context; attachment sparelabs-poc.sh
- NO CREDENTIALS INVOLVED: all findings unauthenticated/read-only; nothing to rotate
- FOLLOW-UP DUE: 2026-08-29 (7 days, one polite nudge only)
- DO-NOT-REDO: bots must not re-probe reported endpoints or re-draft; this file is the single source of truth

## 2026-08-22 HUMAN-VERIFIED LEADS (independent live re-check, ox-alpha-free)

All three top hypotheses REPRODUCED live on 2026-08-22. Patch-regression context confirmed: fleet had a fix cycle then FULLY REVERTED (bots tracked 7+ byte-stable intervals).


NEXT-ACTIONS: (1) channel discovery — no security.txt/H1/Bugcrowd/SECURITY.md found; try security@sparelabs.com + site contact form in parallel. (2) enumerate more org keys (dictionary of agency names) ONLY after channel confirmed + rules OK. (3) test whether organizationKey/UUID chains into /v1/public/organizations/{uuid} oracle or rider-facing flows.
