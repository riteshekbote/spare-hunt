# LEADS longcat (seed)
- SEED: no model output yet; pipeline starts on first run.
## 2026-08-07 18:28:55 UTC [routing] (model longcat)
## 2026-08-07 18:46:52 UTC [routing] (model longcat)
## 2026-08-07 19:12:01 UTC [routing] (model longcat)
## 2026-08-07 20:00:43 UTC [routing] (model longcat)
## 2026-08-07 20:53:16 UTC [routing] (model longcat)
## 2026-08-07 21:29:34 UTC [routing] (model longcat)
## 2026-08-07 22:06:58 UTC [routing] (model longcat)
## 2026-08-07 22:51:35 UTC [routing] (model longcat)
## 2026-08-07 23:25:27 UTC [routing] (model longcat)
## 2026-08-07 23:55:45 UTC [routing] (model longcat)
## 2026-08-08 01:00:02 UTC [routing] (model longcat)
## 2026-08-08 02:56:03 UTC [routing] (model longcat)
## 2026-08-08 04:06:54 UTC [routing] (model longcat)
## 2026-08-08 05:07:35 UTC [routing] (model longcat)
## 2026-08-08 05:53:13 UTC [routing] (model longcat)
## 2026-08-08 06:35:25 UTC [routing] (model longcat)
## 2026-08-08 07:32:35 UTC [routing] (model longcat)
## 2026-08-08 08:10:09 UTC [routing] (model longcat)
## 2026-08-08 08:57:40 UTC [routing] (model longcat)
## 2026-08-08 09:34:18 UTC [routing] (model longcat)
## 2026-08-08 10:05:11 UTC [routing] (model longcat)
## 2026-08-08 10:45:39 UTC [routing] (model longcat)
## 2026-08-08 11:11:42 UTC [routing] (model longcat)
## 2026-08-08 11:44:50 UTC [routing] (model longcat)
## 2026-08-08 12:03:23 UTC [routing] (model longcat)
## 2026-08-08 13:07:40 UTC [routing] (model longcat)
## 2026-08-08 13:53:45 UTC [routing] (model longcat)
## 2026-08-08 14:23:23 UTC [routing] (model longcat)
## 2026-08-08 14:56:12 UTC [routing] (model longcat)
## 2026-08-08 15:22:05 UTC [routing] (model longcat)
## 2026-08-08 15:54:12 UTC [routing] (model longcat)
## 2026-08-08 16:21:19 UTC [routing] (model longcat)
## 2026-08-08 17:02:11 UTC [routing] (model longcat)
## 2026-08-08 17:41:02 UTC [routing] (model longcat)
## 2026-08-08 18:04:11 UTC [routing] (model longcat)
## 2026-08-08 18:54:28 UTC [routing] (model longcat)
## 2026-08-08 19:27:38 UTC [routing] (model longcat)
## 2026-08-08 19:56:05 UTC [routing] (model longcat)
## 2026-08-08 20:32:41 UTC [routing] (model longcat)
## 2026-08-08 21:02:47 UTC [routing] (model longcat)
## 2026-08-08 21:41:10 UTC [routing] (model longcat)
## 2026-08-08 22:03:29 UTC [routing] (model longcat)
## 2026-08-08 22:42:59 UTC [routing] (model longcat)
## 2026-08-08 23:11:36 UTC [routing] (model longcat)
## 2026-08-08 23:46:25 UTC [routing] (model longcat)
## 2026-08-09 00:37:06 UTC [routing] (model longcat)
## 2026-08-09 02:50:22 UTC [routing] (model longcat)
## 2026-08-09 04:07:11 UTC [routing] (model longcat)
## 2026-08-09 05:17:08 UTC [routing] (model longcat)
## 2026-08-09 06:03:42 UTC [routing] (model longcat)
## 2026-08-09 07:11:36 UTC [routing] (model longcat)
## 2026-08-09 08:02:56 UTC [routing] (model longcat)
## 2026-08-09 08:57:12 UTC [routing] (model longcat)
## 2026-08-09 09:45:34 UTC [routing] (model longcat)
## 2026-08-09 10:17:15 UTC [routing] (model longcat)
## 2026-08-09 10:57:21 UTC [routing] (model longcat)
## 2026-08-09 11:34:41 UTC [routing] (model longcat)
## 2026-08-09 12:00:15 UTC [routing] (model longcat)
## 2026-08-09 13:11:27 UTC [routing] (model longcat)
[PRIO] api.sparelabs.com/v1/global/organizations — 6.90 (attack:8 business:7 tech:7 gate:10 cloud:4 fresh:2)
[PRIO] api.sparelabs.com/v1/** (CORS reflection) — 6.10 (attack:9 business:5 tech:8 gate:6 cloud:3 fresh:2)
[PRIO] platform.sparelabs.com/login (CSP leak) — 6.05 (attack:6 business:7 tech:5 gate:9 cloud:5 fresh:2)
[PRIO] api.sparelabs.com/v1/global/regions — 5.95 (attack:7 business:6 tech:6 gate:8 cloud:4 fresh:2)
[PRIO] api.sparelabs.com/v1/public/organization — 5.40 (attack:6 business:5 tech:5 gate:10 cloud:2 fresh:2)
[HYP] platform.sparelabs.com own admin/API route exposure
class: MISCONFIG
asset: platform.sparelabs.com
confidence: 50
reasoning: CSP leak on /login confirms platform is an MFE shell loading admin Vercel apps. Platform's own /admin, /api, /v1, or /internal routes are untested — may proxy or expose admin functionality directly on the in-scope host.
evidence_needed: 200/301/405 (not 404) on platform-owned admin/API paths
verify_steps: `curl -s -o /dev/null -w "%{http_code}" https://platform.sparelabs.com/admin` ; same for /api, /v1, /internal, /graphql, /config, /env, /status, /health, /metrics
impact: direct admin access or data exposure on in-scope platform host; severity depends on route
testability: PASSIVE
[HYP] forms.sparelabs.com data-bearing API endpoints behind SPA catch-all
class: MISCONFIG
asset: forms.sparelabs.com
confidence: 45
reasoning: forms.sparelabs.com is an SPA catch-all returning index.html for arbitrary paths, but specific API routes (/api/*, /v1/*, /graphql, /export, /webhook) may return structured data. JS bundle leak confirms staging+prod infra but forms' own API surface is unexplored.
evidence_needed: non-HTML JSON/XML response on a specific path
verify_steps: `curl -s -H "Accept: application/json" https://forms.sparelabs.com/api/health` ; same for /api/v1, /graphql, /webhooks, /export, /status, /config
impact: unauthenticated data disclosure or API access on in-scope forms host
testability: PASSIVE
[HYP] api.sparelabs.com/v1/global/organizations write methods process bodies without auth
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 55
reasoning: OPTIONS 204 confirms PUT/PATCH/POST/DELETE + ACAO+ACAC on the fail-open route. GET returns 200+empty with zero auth. Knowledge base confirms CORS chain but never tested whether write handlers actually process request bodies — if they do, cross-origin state modification is possible via victim browser.
evidence_needed: 200/201/4xx-with-body on POST/PUT (not just OPTIONS 204)
verify_steps: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" https://api.sparelabs.com/v1/global/organizations` (passive re-confirm) ; active body test requires AUTH_HELPED
impact: cross-origin write (create/update/delete org records) without auth via victim browser; high if confirmed
testability: PASSIVE (OPTIONS re-confirm) / AUTH_HELPED (body test)
[PARKED] api.sparelabs.com/v1/global/organizations write methods process bodies without auth: confidence 55 but passive verification only re-confirms already-documented OPTIONS surface; actual write processing requires active body send (non-passive). Downgraded to informational — CORS chain already accepted.
[FINAL] 1. platform.sparelabs.com own admin/API route exposure (conf 50, PASSIVE-testable)
[FINAL] 2. forms.sparelabs.com data-bearing API endpoints behind SPA catch-all (conf 45, PASSIVE-testable)
[NEXT] PROBE: `curl -s -o /dev/null -w "%{http_code} %{redirect_url}" https://platform.sparelabs.com/admin && echo && curl -s -o /dev/null -w "%{http_code}" https://platform.sparelabs.com/api && echo && curl -s -o /dev/null -w "%{http_code}" https://platform.sparelabs.com/graphql && echo && curl -s -o /dev/null -w "%{http_code}" https://forms.sparelabs.com/api/health && echo && curl -s -o /dev/null -w "%{http_code}" https://forms.sparelabs.com/graphql`
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: STABLE dead — envoy 404 on all paths, NO_DELTA since 2026-08-07, confirmed again this session.
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: zero-header no-auth bypass STABLE — 200+11B+ACAO+ACAC with NO Authorization, confirmed live 12:01 UTC.
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only bypass STABLE — Bearer x → 200+725B+ACAO+ACAC, confirmed live 12:01 UTC.
[RISK] api.sparelabs.com: 85 — multiple auth bypasses (zero-header + scheme-only), universal CORS credential reflection, UUID oracle, data disclosure, multi-version LB flapping; highest exposure in program
[RISK] platform.sparelabs.com: 60 — CSP leak exposes production admin Vercel apps + staging + Metabase + full cloud infra; admin surface reachable but OOS third-party hosts limit direct exploitation
[RISK] routing.sparelabs.com: 5 — envoy 404 on all paths, no discoverable surface, effectively dead
[RISK] forms.sparelabs.com: 40 — JS bundle leaks staging+prod+regional infra + inactive ngrok; SPA catch-all limits direct attack surface
[RISK] web (spare.com/sparelabs.com): 10 — static Webflow marketing on Cloudflare, strict CSP, HSTS, no internal infra leaks; minimal surface
## 2026-08-09 13:58:31 UTC [routing] (model longcat)
## 2026-08-09 14:42:52 UTC [routing] (model longcat)
## 2026-08-09 15:14:20 UTC [routing] (model longcat)
## 2026-08-09 15:49:55 UTC [routing] (model longcat)
## 2026-08-09 16:17:22 UTC [routing] (model longcat)
## 2026-08-09 17:00:29 UTC [routing] (model longcat)
## 2026-08-09 17:40:27 UTC [routing] (model longcat)
## 2026-08-09 18:05:21 UTC [routing] (model longcat)
## 2026-08-09 18:58:39 UTC [routing] (model longcat)
## 2026-08-09 19:39:48 UTC [routing] (model longcat)
## 2026-08-09 20:04:02 UTC [routing] (model longcat)
