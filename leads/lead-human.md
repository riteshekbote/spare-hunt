## 2026-08-22 HUMAN-VERIFIED LEADS (independent live re-check, ox-alpha-free)

All three top hypotheses REPRODUCED live on 2026-08-22. Patch-regression context confirmed: fleet had a fix cycle then FULLY REVERTED (bots tracked 7+ byte-stable intervals).

[UNVALIDATED] api.sparelabs.com/v1/public/organizations/key/{key}: unauthenticated tenant-disclosure oracle — GET key=spare returns 200+351B full org record (UUID d736519f-f384-4771-a2d2-4f95e884d790, name, GCS logoUrl, organizationKey, enabledPublicFeatureFlags incl riderPhonePin/riderLoginless); invalid key -> 404 (enumeration oracle). Keys known: spare/grt/dallas/winnipeg/hsr. Prod-residency only. | HIGH | PASSIVE
[UNVALIDATED] api.sparelabs.com/v1/global/regions: authentication bypass — gate validates Bearer scheme only; Authorization: Bearer x (garbage token) returns 200+751B full infra topology: 7 regions x {apiUrl,routingHost} INCL UAT api.uat.sparelabs.com simulationsEnabled:true; no-auth control = 400. Fleet-parity per bots. | HIGH | PASSIVE
[UNVALIDATED] api.sparelabs.com CORS reflector: ACAO=attacker-origin + ACAC:true reflected EVEN ON 401 (verified via HEAD). Chain primitive: cross-origin reads of session-bearing endpoints from attacker pages. | MED-CHAIN | PASSIVE
[UNVALIDATED] api.sparelabs.com/v1/global/organizations: fail-open no-auth -> 200 {"data":[]}. Low alone; chain material. | LOW | PASSIVE

NEXT-ACTIONS: (1) channel discovery — no security.txt/H1/Bugcrowd/SECURITY.md found; try security@sparelabs.com + site contact form in parallel. (2) enumerate more org keys (dictionary of agency names) ONLY after channel confirmed + rules OK. (3) test whether organizationKey/UUID chains into /v1/public/organizations/{uuid} oracle or rider-facing flows.
