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
## 2026-08-09 20:49:00 UTC [routing] (model longcat)
## 2026-08-09 21:18:07 UTC [routing] (model longcat)
## 2026-08-09 21:54:05 UTC [routing] (model longcat)
## 2026-08-09 22:27:17 UTC [routing] (model longcat)
## 2026-08-09 23:01:37 UTC [routing] (model longcat)
## 2026-08-09 23:41:12 UTC [routing] (model longcat)
## 2026-08-10 00:05:41 UTC [routing] (model longcat)
## 2026-08-10 02:31:14 UTC [routing] (model longcat)
## 2026-08-10 04:19:33 UTC [routing] (model longcat)
[CHANGED] platform.sparelabs.com: All 10 admin/API paths (/admin, /api, /graphql, /v1, /internal, /config, /env, /status, /health, /metrics) return 200 + `text/html` — confirmed SPA catch-all, NOT real API endpoints. Hypothesis resolved.
[CHANGED] forms.sparelabs.com: All 8 API paths (/api/health, /api/v1, /graphql, /webhooks, /export, /status, /config, /v1) return 200 + `text/html` (index.html, `content-disposition: inline; filename="index.html"`) — confirmed SPA catch-all, no real API endpoints. Hypothesis resolved.
[LEARN] routing.sparelabs.com: STABLE dead — envoy 404 on all paths (/, /v1/, /api/, /routing/), NO_DELTA since 2026-08-07.
[PRIO] api.sparelabs.com/v1/global/regions — 5.95 (attack:7 business:6 tech:6 gate:8 cloud:4 fresh:2)
[PRIO] api.sparelabs.com/v1/global/organizations — 5.65 (attack:7 business:6 tech:6 gate:10 cloud:2 fresh:2)
[PRIO] api.sparelabs.com/v1/public/organization — 5.40 (attack:6 business:5 tech:5 gate:10 cloud:2 fresh:2)
[PRIO] api.sparelabs.com/v1/public/terms — 4.95 (attack:5 business:4 tech:5 gate:10 cloud:2 fresh:2)
[PRIO] platform.sparelabs.com — 3.50 (attack:3 business:5 tech:4 gate:2 cloud:4 fresh:2)
[PRIO] forms.sparelabs.com — 2.50 (attack:2 business:3 tech:3 gate:2 cloud:2 fresh:2)
[HYP] api.sparelabs.com/v1/global/regions scheme-only bypass body stability — does the 725B region registry still leak internal OOS hostnames consistently?
class: AUTH
asset: api.sparelabs.com/v1/global/regions
confidence: 90
reasoning: KB documents scheme-only bypass (Bearer x → 200 + 725B). Live probe this session confirms 200 + full region registry with 6 OOS api/routing subdomains. Multi-version LB flapping means the 200 state is intermittent — need to confirm current replica state.
evidence_needed: 200 + JSON body with region registry (7 regions, 6 OOS hosts)
verify_steps: `curl -s -H "Authorization: Bearer x" -H "Origin: https://evil.example.com" https://api.sparelabs.com/v1/global/regions`
impact: full internal infra topology disclosure (6 OOS regional api/routing hosts) without valid auth
testability: PASSIVE
[HYP] api.sparelabs.com/v1/global/organizations write-method body processing — does POST/PUT actually process request bodies despite empty GET response?
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 55
reasoning: OPTIONS 204 confirms PUT/PATCH/POST/DELETE + ACAO+ACAC. GET returns 200+empty with zero auth. CORS chain confirmed. But write handlers may have separate auth middleware or may not process bodies — untested.
evidence_needed: 200/201/4xx-with-body on POST/PUT (not just OPTIONS 204)
verify_steps: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" https://api.sparelabs.com/v1/global/organizations` (passive re-confirm) ; active body test requires AUTH_HELPED
impact: cross-origin state modification (create/update/delete org records) without auth via victim browser
testability: PASSIVE (OPTIONS) / AUTH_HELPED (body send)
[HYP] platform.sparelabs.com MFE prefetch script new module enumeration — does the CSP or JS bundle expose additional staging/prod infra beyond known leak?
class: MISCONFIG
asset: platform.sparelabs.com
confidence: 40
reasoning: CSP leak confirmed stable (admin-eam-app + admin-fixed-route-app prod+staging + Metabase + full cloud infra). But JS bundle may reference additional internal modules not visible in CSP alone. Bundle hash unchanged (per KB) but content not re-fetched this session.
evidence_needed: new internal host or infra URL in JS bundle not in CSP
verify_steps: `curl -s https://platform.sparelabs.com/ | grep -oE 'https?://[a-z0-9.-]+\.vercel\.app'` ; compare against known CSP leak list
impact: additional staging/prod infra exposure beyond known CSP leak
testability: PASSIVE
[PARKED] platform.sparelabs.com MFE prefetch script new module enumeration: confidence 40 — bundle hash stable per KB (main.71d52314.js on forms, platform bundle unchanged 3+ sessions), CSP already fully enumerated. Low probability of new infra leak. Downgraded to informational.
[PARKED] api.sparelabs.com/v1/global/organizations write-method body processing: confidence 55 but passive verification only re-confirms already-documented OPTIONS surface; actual write processing requires active body send (non-passive). Downgraded to informational — CORS chain already accepted.
[FINAL] 1. api.sparelabs.com/v1/global/regions scheme-only bypass body stability (conf 90, PASSIVE-testable)
[NEXT] PROBE: `curl -s -H "Authorization: Bearer x" -H "Origin: https://evil.example.com" https://api.sparelabs.com/v1/global/regions | python3 -m json.tool` — re-confirm 200 + full region registry (7 regions, 6 OOS api/routing subdomains) on current envoy replica. If 400, retry ×3 to account for multi-version LB flapping.
[LEARN] REJECTED MISCONFIG @ platform.sparelabs.com: All 10 admin/API paths (/admin, /api, /graphql, /v1, /internal, /config, /env, /status, /health, /metrics) return 200 + `text/html` (SPA catch-all, index.html). No real API surface behind platform host — pure MFE shell. Hypothesis dead.
[LEARN] REJECTED MISCONFIG @ forms.sparelabs.com: All 8 API paths (/api/health, /api/v1, /graphql, /webhooks, /export, /status, /config, /v1) return 200 + `text/html` (index.html, `content-disposition: inline; filename="index.html"`). No real API endpoints behind forms host — pure SPA catch-all. Hypothesis dead.
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: Scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions, 6 OOS api/routing subdomains) + ACAO+ACAC (3ms fast replica). Verified live 2026-08-10 04:17 UTC.
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: Complete zero-header bypass STABLE — 200 + `{"data":[]}` (11B) + ACAO+ACAC (814ms slow replica). Verified live 2026-08-10 04:17 UTC.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:https://evil.example.com + ACAC:true on 200 (regions/organizations) + 401 (journeys control) paths. Verified live 2026-08-10 04:17 UTC.
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: STABLE dead — envoy 404 on all paths (/, /v1/, /api/, /routing/), NO_DELTA since 2026-08-07.
[RISK] api.sparelabs.com: 85 — multiple auth bypasses (zero-header + scheme-only), universal CORS credential reflection, UUID oracle, data disclosure, multi-version LB flapping; highest exposure in program
[RISK] platform.sparelabs.com: 55 — CSP leak exposes production admin Vercel apps + staging + Metabase + full cloud infra; admin surface reachable but OOS third-party hosts limit direct exploitation; SPA catch-all confirmed no direct API surface
[RISK] routing.sparelabs.com: 5 — envoy 404 on all paths, no discoverable surface, effectively dead
[RISK] forms.sparelabs.com: 35 — JS bundle leaks staging+prod+regional infra + inactive ngrok; SPA catch-all confirmed no direct attack surface
[RISK] web (spare.com/sparelabs.com): 10 — static Webflow marketing on Cloudflare, strict CSP, HSTS, no internal infra leaks; minimal surface
## 2026-08-10 05:50:23 UTC [routing] (model longcat)
[HYP] api.sparelabs.com/v1/global/regions replica convergence — is the 725B region registry disclosure now stable across LB replicas (was flapping 400↔200)?
class: AUTH
asset: api.sparelabs.com/v1/global/regions
confidence: 90
reasoning: Live probe THIS turn confirms 200 + 7 regions with `Bearer x` (no valid auth), 147ms upstream, full body matches sha256 fb9800acb…7585c3fe. Multi-version LB flapping documented over 3+ days — current state is 200 on the probed replica.
evidence_needed: 200 + 7-region JSON body with `Bearer x` (no valid token)
verify_steps: `curl -s -H "Authorization: Bearer x" https://api.sparelabs.com/v1/global/regions | python3 -c "import sys,json; d=json.load(sys.stdin); print(f'regions={len(d)}')"`
impact: Full internal infra topology disclosure (7 regions, 6 OOS api/routing subdomains) without valid auth — enables targeted recon against regional API hosts
testability: PASSIVE
[HYP] api.sparelabs.com/v1/global/organizations zero-header write CORS — does POST/PUT process bodies despite empty GET?
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 55
reasoning: OPTIONS 204 advertises PUT/PATCH/POST/DELETE + ACAO+ACAC on exact route. GET returns 200+`{"data":[]}` with zero Authorization header (complete route-level auth omission). Write handlers may have separate auth middleware — unverified.
evidence_needed: 200/201/4xx-with-body on POST/PUT (not just OPTIONS 204)
verify_steps: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" https://api.sparelabs.com/v1/global/organizations` (passive re-confirm)
impact: Cross-origin state modification (create/update/delete org records) without auth via victim admin browser session
testability: PASSIVE (OPTIONS only; body send = AUTH_HELPED)
[HYP] api.sparelabs.com/v1/public/organization 3-way UUID oracle — differential still intact after documented degradation flap?
class: AUTH
asset: api.sparelabs.com/v1/public/organization
confidence: 85
reasoning: KB documents nil-uuid → 404 NotFoundError (131B + correlationId), malformed → 400 ValidationError "must match format uuid" (285B). Prior inventory claimed degradation to 2-way (400/200) but live probes 2026-08-09 18:38 UTC contradicted — 3-way differential confirmed intact. Multi-version LB may re-flap.
evidence_needed: 3 distinct HTTP status codes for malformed vs nil-uuid vs valid-found UUID inputs
verify_steps: `curl -s -o /dev/null -w "%{http_code}" https://api.sparelabs.com/v1/public/organization?organizationId=not-a-uuid` AND `curl -s -o /dev/null -w "%{http_code}" https://api.sparelabs.com/v1/public/organization?organizationId=00000000-0000-0000-0000-000000000000`
impact: Organization enumeration oracle — attacker can discover valid org UUIDs via binary discrimination (404 vs 200), then pivot to authenticated endpoints
testability: PASSIVE
[NEXT] PROBE: `curl -s -w "\nHTTP:%{http_code}" -H "Authorization: Bearer x" -H "Origin: https://evil.example.com" https://api.sparelabs.com/v1/global/organizations` — re-confirm zero-header bypass still returns 200 + `{"data":[]}` (live turn check for LB flapping delta)
## 2026-08-10 07:03:05 UTC [routing] (model longcat)
[PRIO] api.sparelabs.com/v1/global/regions — 89 (attack:9, business:9, tech:8, gate:10, cloud:7, freshness:7) — auth-free infra topology disclosure, 7 regions, 6 OOS, body sha stable
[PRIO] api.sparelabs.com/v1/global/organizations — 84 (attack:8, business:9, tech:8, gate:10, cloud:7, freshness:7) — complete zero-header bypass + full write CORS chain on fail-open controller
[PRIO] api.sparelabs.com/v1/public/organization — 80 (attack:8, business:8, tech:7, gate:10, cloud:6, freshness:7) — 3-way UUID oracle, auth-free, enables org enumeration pivot
[PRIO] api.sparelabs.com/v1/public/terms — 72 (attack:7, business:7, tech:6, gate:10, cloud:6, freshness:6) — unauthenticated data disclosure, terms URLs leaked
[PRIO] api.sparelabs.com/v1/** (CORS) — 82 (attack:9, business:8, tech:8, gate:10, cloud:7, freshness:6) — universal reflect-any-origin+credentials, read→write escalation
[PRIO] platform.sparelabs.com/login — 62 (attack:6, business:8, tech:7, gate:6, cloud:8, freshness:5) — CSP infra leak, admin apps exposed, OOS third-party limits exploitation
[PRIO] routing.sparelabs.com — 5 (attack:0, business:2, tech:0, gate:0, cloud:0, freshness:2) — envoy 404 all paths, no surface
[HYP] api.sparelabs.com/v1/global/regions scheme-only auth bypass — region registry (7 regions, 6 OOS api/routing subdomains) disclosed without valid auth via `Bearer x` header presence-only gate
class: AUTH
asset: api.sparelabs.com/v1/global/regions
confidence: 90
reasoning: Live probe THIS turn confirms 200 + 7-region JSON with `Bearer x` (garbage token). Auth gate is scheme-only: no-Auth→400, `Authorization: x`→400 "scheme Bearer required", `Bearer x`→200. Token validity never checked. Body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe stable across 3+ days.
evidence_needed: 200 + 7-region JSON body with `Bearer x` (no valid token), OPTIONS confirms write methods + ACAO+ACAC on same route
verify_steps: `curl -s -w "\nHTTP:%{http_code}" -H "Authorization: Bearer x" -H "Origin: https://evil.example.com" https://api.sparelabs.com/v1/global/regions | python3 -m json.tool`
impact: Full internal infra topology disclosure without valid auth — 7 regions, 6 out-of-scope api/routing subdomains mapped, enabling targeted recon against all regional surfaces
testability: PASSIVE
[HYP] api.sparelabs.com/v1/global/organizations complete zero-header no-auth bypass — OPTIONS advertises PUT/PATCH/POST/DELETE with ACAO+ACAC, GET returns 200+empty with NO Authorization header at all
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 98
reasoning: Live probe THIS turn confirms 200 + `{"data":[]}` with NO Authorization header (complete route-level omission, NOT scheme-only). OPTIONS 204 advertises PUT,PATCH,POST,DELETE with ACAO:evil.example.com + ACAC:true. CORS chain closes read→write. Control /v1/journeys still returns 401. 14-sibling sweep confirms route-specific scope (12×401 + 2×200).
evidence_needed: 200 + 11B body with zero Authorization header, OPTIONS 204 with write methods + ACAO+ACAC
verify_steps: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" https://api.sparelabs.com/v1/global/organizations` AND `curl -s -w "\nHTTP:%{http_code}" -H "Origin: https://evil.example.com" https://api.sparelabs.com/v1/global/organizations`
impact: Complete auth omission on organization controller — read (empty payload currently) + full write CORS surface cross-origin. Empty payload caps current severity but write handler auth unverified.
testability: PASSIVE (OPTIONS + GET confirmed; body write requires AUTH_HELPED)
[HYP] api.sparelabs.com/v1/public/organization 3-way UUID enumeration oracle — malformed→400 ValidationError, nil-uuid→404 NotFoundError, valid-found→200
class: AUTH
asset: api.sparelabs.com/v1/public/organization
confidence: 85
reasoning: Live probe THIS turn confirms 3-way differential intact: `not-a-uuid`→400 ValidationError (285B + correlationId), nil-uuid→404 NotFoundError (131B + correlationId). Prior inventory claimed degradation to 2-way but live probes consistently contradict — 3-way confirmed 2026-08-10 this turn. Auth-free validation error disclosure + CORS persists.
evidence_needed: 3 distinct HTTP status codes for malformed vs nil-uuid vs valid-found UUID inputs
verify_steps: `curl -s -o /dev/null -w "%{http_code}" "https://api.sparelabs.com/v1/public/organization?organizationId=not-a-uuid"` AND `curl -s -o /dev/null -w "%{http_code}" "https://api.sparelabs.com/v1/public/organization?organizationId=00000000-0000-0000-0000-000000000000"`
impact: Organization enumeration oracle — attacker can discover valid org UUIDs via binary discrimination (404 vs 200), then pivot to authenticated endpoints that accept org UUID
testability: PASSIVE
[PARKED] api.sparelabs.com/v1/global/organizations write-method body processing — confidence 55, passive verification only re-confirms already-documented OPTIONS surface; actual write processing requires active body send (non-passive, AUTH_HELPED). CORS chain already accepted. Downgraded.
[PARKED] api.sparelabs.com/v1/global/regions controller-wide extension — sibling sweep already REJECTED (12×401 + 2×200). Auth omission is route-specific, not controller-wide. Contradicts facts.
[FINAL]
[NEXT] PROBE: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: DELETE" https://api.sparelabs.com/v1/global/organizations` — re-confirm write CORS chain convergence (DELETE method advertised with ACAO+ACAC on exact fail-open route), closing the read→write escalation gap via passive OPTIONS alone.
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: Scheme-only bypass confirmed STABLE live this turn — `Bearer x` → 200 + 725B region registry (7 regions, 6 OOS) + ACAO+ACAC; body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: Complete zero-header no-auth bypass STABLE live this turn — 200 + 11B `{"data":[]}` + ACAO+ACAC with NO Authorization header
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/public/organization: 3-way UUID oracle STABLE live this turn — malformed→400 ValidationError (285B), nil-uuid→404 NotFoundError (131B), 3-way differential intact
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Data disclosure STABLE live this turn — `?mobileAppId=nil-uuid` → 200 + 137B (termsOfUseUrl→sparelabs.com/terms-of-use/, privacyPolicyUrl→sparelabs.com/privacy-policy/) no-auth + CORS
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:evil.example.com + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE on OPTIONS 204 /v1/global/regions
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: STABLE dead — envoy 404 on ALL probed paths (/, /v1/, /api/, /routing/, /v2/, /graphql, /map, /directions, /router, /api/v1, /api/routing, /openapi.json, /swagger.json, /docs, /health, /status); no surface, NO_DELTA since 2026-08-07
[RISK] api.sparelabs.com: 90 — multiple confirmed auth bypasses (zero-header + scheme-only), universal CORS credential reflection across all /v1, UUID oracle, data disclosure, multi-version LB flapping; highest exposure in program with 3 distinct AUTH/MISCONFIG classes accepted stable
[RISK] platform.sparelabs.com: 55 — CSP infra leak exposes production admin Vercel apps + staging + Metabase + full cloud infra (Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit); admin surface reachable but OOS third-party hosts limit direct exploitation; SPA catch-all confirmed no direct API surface
[RISK] routing.sparelabs.com: 5 — envoy 404 on ALL paths, no discoverable surface, effectively dead across 3+ days of continuous probing
[RISK] forms.sparelabs.com: 35 — JS bundle main.71d52314.js leaks staging+prod+regional infra (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, atlassian.net, ngrok.io); SPA catch-all confirmed no direct API attack surface; infra-recon value only
[RISK] web (spare.com/sparelabs.com): 10 — static Webflow marketing on Cloudflare, strict CSP `frame-ancestors 'self'`, HSTS 31536000, no internal infra leaks; minimal static-only surface
## 2026-08-10 08:50:05 UTC [routing] (model longcat)
class: AUTH
asset: api.sparelabs.com/v1/global/regions
confidence: 90
reasoning: Live probe confirms `Bearer x` → 200 + 725B region registry. Auth gate is scheme-only: no-Auth→400, `Authorization: x`→400 "scheme Bearer required", `Bearer x`→200. Token validity never checked. Body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe stable across 3+ days.
evidence_needed: 200 + 7-region JSON body with `Bearer x` (no valid token), OPTIONS confirms write methods + ACAO+ACAC on same route
verify_steps: `curl -s -w "\nHTTP:%{http_code}" -H "Authorization: Bearer x" -H "Origin: https://evil.example.com" https://api.sparelabs.com/v1/global/regions`
impact: Full internal infra topology disclosure without valid auth — 7 regions, 6 out-of-scope api/routing subdomains mapped, enabling targeted recon against all regional surfaces
testability: PASSIVE
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 98
reasoning: Live probe confirms 200 + `{"data":[]}` with NO Authorization header (complete route-level omission, NOT scheme-only). OPTIONS 204 advertises PUT,PATCH,POST,DELETE with ACAO:evil.example.com + ACAC:true. CORS chain closes read→write. Control /v1/journeys still returns 401. 14-sibling sweep confirms route-specific scope.
evidence_needed: 200 + 11B body with zero Authorization header, OPTIONS 204 with write methods + ACAO+ACAC
verify_steps: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" https://api.sparelabs.com/v1/global/organizations` AND `curl -s -w "\nHTTP:%{http_code}" -H "Origin: https://evil.example.com" https://api.sparelabs.com/v1/global/organizations`
impact: Complete auth omission on organization controller — read (empty payload currently) + full write CORS surface cross-origin. Empty payload caps current severity but write handler auth unverified.
testability: PASSIVE (OPTIONS + GET confirmed; body write requires AUTH_HELPED)
class: AUTH
asset: api.sparelabs.com/v1/public/organization
confidence: 85
reasoning: Live probe confirms 3-way differential intact: `not-a-uuid`→400 ValidationError (285B + correlationId), nil-uuid→404 NotFoundError (131B + correlationId). Prior inventory claimed degradation to 2-way but live probes consistently contradict — 3-way confirmed this turn.
evidence_needed: 3 distinct HTTP status codes for malformed vs nil-uuid vs valid-found UUID inputs
verify_steps: `curl -s -o /dev/null -w "%{http_code}" "https://api.sparelabs.com/v1/public/organization?organizationId=not-a-uuid"` AND `curl -s -o /dev/null -w "%{http_code}" "https://api.sparelabs.com/v1/public/organization?organizationId=00000000-0000-0000-0000-000000000000"`
impact: Organization enumeration oracle — attacker can discover valid org UUIDs via binary discrimination (404 vs 200), then pivot to authenticated endpoints that accept org UUID
testability: PASSIVE
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: Scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions, 6 OOS) + ACAO+ACAC; body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: Complete zero-header no-auth bypass STABLE — 200 + 11B `{"data":[]}` + ACAO+ACAC with NO Authorization header
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/public/organization: 3-way UUID oracle STABLE — malformed→400 ValidationError (285B), nil-uuid→404 NotFoundError (131B), 3-way differential intact
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Data disclosure STABLE — `?mobileAppId=nil-uuid` → 200 + 137B (termsOfUseUrl→sparelabs.com/terms-of-use/, privacyPolicyUrl→sparelabs.com/privacy-policy/) no-auth + CORS
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:evil.example.com + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE on OPTIONS 204
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: STABLE dead — envoy 404 on ALL probed paths; no surface, NO_DELTA since 2026-08-07
[RISK] api.sparelabs.com: **90** — multiple confirmed auth bypasses (zero-header + scheme-only), universal CORS credential reflection across all /v1, UUID oracle, data disclosure, multi-version LB flapping; highest exposure in program with 3 distinct AUTH/MISCONFIG classes accepted stable
[RISK] platform.sparelabs.com: **55** — CSP infra leak exposes production admin Vercel apps + staging + Metabase + full cloud infra (Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit); admin surface reachable but OOS third-party hosts limit direct exploitation; SPA catch-all confirmed no direct API surface
[RISK] routing.sparelabs.com: **5** — envoy 404 on ALL paths, no discoverable surface, effectively dead across 3+ days of continuous probing
[RISK] forms.sparelabs.com: **35** — JS bundle main.71d52314.js leaks staging+prod+regional infra (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, atlassian.net, ngrok.io); SPA catch-all confirmed no direct API attack surface; infra-recon value only
[RISK] web (spare.com/sparelabs.com): **10** — static Webflow marketing on Cloudflare, strict CSP `frame-ancestors 'self'`, HSTS 31536000, no internal infra leaks; minimal static-only surface
## 2026-08-10 10:07:55 UTC [routing] (model longcat)
[PRIO] api.sparelabs.com/v1/global/organizations — 6.90 (attack:8 business:7 tech:7 gate:10 cloud:4 fresh:2)
[PRIO] api.sparelabs.com/v1/** (CORS reflection) — 6.10 (attack:9 business:5 tech:8 gate:6 cloud:3 fresh:2)
[PRIO] platform.sparelabs.com/login (CSP leak) — 6.05 (attack:6 business:7 tech:5 gate:9 cloud:5 fresh:2)
[PRIO] api.sparelabs.com/v1/global/regions — 5.95 (attack:7 business:6 tech:6 gate:8 cloud:4 fresh:2)
[PRIO] api.sparelabs.com/v1/public/organization — 5.40 (attack:6 business:5 tech:5 gate:10 cloud:2 fresh:2)
[HYP] Cross-origin write execution on complete zero-header bypass /v1/global/organizations
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 55
reasoning: OPTIONS 204 advertises PUT/PATCH/POST/DELETE with ACAO+ACAC on exact fail-open route. GET returns 200+11B with zero Authorization header. CORS chain (A1) + zero-header bypass (A4) both accepted. Write handler execution never tested — if POST/PUT process bodies without auth, cross-origin state mutation is possible via victim browser.
evidence_needed: OPTIONS 204 + ACAO+ACAC + write-methods on /v1/global/organizations (passive preflight chain); 2xx on POST requires AUTH_HELPED
verify_steps: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: DELETE" -H "Access-Control-Request-Headers: Authorization,Content-Type" https://api.sparelabs.com/v1/global/organizations` ; body write test requires AUTH_HELPED
impact: Cross-origin state modification (create/update/delete org records) without auth via victim admin browser; elevates accepted read bypass to write
testability: PASSIVE (OPTIONS re-confirm) / AUTH_HELPED (body send)
[HYP] /v1/public/mobileApps/{id} auth-free data-bearing branch
class: AUTH
asset: api.sparelabs.com/v1/public/mobileApps/{id}
confidence: 45
reasoning: New endpoint discovered 2026-08-10 — nil-uuid returns 404 (auth-free, route registered, real DB lookup) but 200-branch never observed. Parallel to org UUID oracle (A3) but for mobileApp namespace. No format discrimination observed yet.
evidence_needed: 200 response with real mobileApp UUID or UUID-format discrimination (400 vs 404)
verify_steps: `curl -s -o /dev/null -w "%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/not-a-uuid"` AND `curl -s -o /dev/null -w "%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/00000000-0000-0000-0000-000000000000"`
impact: mobileApp record disclosure or new UUID enumeration oracle; enables pivot to authenticated mobileApp-scoped endpoints
testability: PASSIVE (real-UUID branch needs HUMAN_ONLY)
[HYP] /v1/global/organizations/tenants data-bearing subroute on fail-open controller
class: AUTH
asset: api.sparelabs.com/v1/global/organizations/tenants
confidence: 40
reasoning: New subroute on already-vulnerable controller (A4). Returns 400 (route registered, requires params). May accept UUID param and return tenant records without auth — parallel to /v1/global/organizations/{id} which returned 404 auth-free.
evidence_needed: non-400 response (200/404-with-body) with valid org UUID param
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/global/organizations/tenants?organizationId=00000000-0000-0000-0000-000000000000"`
impact: Tenant-record disclosure without auth; expands A4 controller exposure
testability: PASSIVE (data-bearing branch needs AUTH_HELPED)
[PARKED] Cross-origin write execution on /v1/global/organizations: confidence 55 — passive verification only re-confirms already-documented OPTIONS surface (A1 CORS + A4 zero-header both accepted). Actual write processing requires active body send (non-passive, AUTH_HELPED). Downgraded to informational.
[PARKED] /v1/public/mobileApps/{id} auth-free data-bearing branch: confidence 45 — 404 alone not a vulnerability; no 200-branch observed; real-UUID branch needs HUMAN_ONLY. Downgraded to HOLD.
[PARKED] /v1/global/organizations/tenants data-bearing subroute: confidence 40 — 400 alone not a vulnerability; data-bearing unproven; parallel to already-documented A4 subroutes. Downgraded to HOLD.
[FINAL] No surviving hypotheses above confidence 40 with passive proof path. All 7 accepted findings (A1–A7) remain the complete valid surface. No new reportable findings this cycle.
[NEXT] PROBE: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: DELETE" -H "Access-Control-Request-Headers: Authorization,Content-Type" https://api.sparelabs.com/v1/global/organizations` — re-confirm write CORS chain convergence (DELETE method advertised with ACAO+ACAC on exact fail-open route). This closes the read→write escalation gap via passive OPTIONS alone, elevating A4 from "read-only empty payload" to "full read+write CORS surface" without requiring AUTH_HELPED body send. If ACAO+ACAC + DELETE confirmed, report as escalation note on A4.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:https://evil.example.com + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authorization,Content-Type on OPTIONS 204 + GET (200/401/400) uniformly across /v1 — re-confirmed 84h+ stable
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: Scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions, 6 OOS) + ACAO+ACAC; body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: Complete zero-header no-auth bypass STABLE — 200 + 11B `{"data":[]}` + ACAO+ACAC with NO Authorization header; OPTIONS 204 confirms PUT/PATCH/POST/DELETE advertised
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/public/organization: 3-way UUID oracle STABLE — malformed→400 ValidationError "must match format uuid" (285B + correlationId); nil-uuid→404 NotFoundError (131B + correlationId)
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Data disclosure STABLE — `?mobileAppId=<nil-uuid>` → 200 + 137B (termsOfUseUrl→sparelabs.com/terms-of-use/, privacyPolicyUrl→sparelabs.com/privacy-policy/) no-auth + CORS
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP infra leak STABLE — prod admin-eam-app.vercel.app + admin-fixed-route-app.vercel.app (both 200) + staging variants + Metabase prod+staging (200) + Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit in CSP
[LEARN] ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.sparelabs.com + forms.staging.us.sparelabs.com + atlassian.net + ngrok.io
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: STABLE dead — envoy 404 on ALL probed paths; no surface, NO_DELTA since 2026-08-07
[RISK] api.sparelabs.com: **90** — multiple confirmed auth bypasses (zero-header + scheme-only), universal CORS credential reflection across all /v1, UUID oracle, data disclosure, multi-version LB flapping; highest exposure in program with 3 distinct AUTH/MISCONFIG classes accepted stable 84h+; chain amplification (CORS + auth bypass + org enum) enables full cross-origin data exfil + potential state mutation
[RISK] platform.sparelabs.com: **55** — CSP infra leak exposes production admin Vercel apps + staging + Metabase + full cloud infra (Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit); admin surface reachable but OOS third-party hosts limit direct exploitation; SPA catch-all confirmed no direct API surface
[RISK] routing.sparelabs.com: **5** — envoy 404 on ALL paths, no discoverable surface, effectively dead across 3+ days of continuous probing
[RISK] forms.sparelabs.com: **35** — JS bundle main.71d52314.js leaks staging+prod+regional infra (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, atlassian.net, ngrok.io); SPA catch-all confirmed no direct API attack surface; infra-recon value only
[RISK] web (spare.com/sparelabs.com): **10** — static Webflow marketing on Cloudflare, strict CSP `frame-ancestors 'self'`, HSTS 31536000, no internal infra leaks; minimal static-only surface
## 2026-08-10 11:20:39 UTC [routing] (model longcat)
[PRIO] api.sparelabs.com/v1/global/organizations — 6.90 (attack:8 business:7 tech:7 gate:10 cloud:4 fresh:2)
[PRIO] api.sparelabs.com/v1/** (CORS reflection) — 6.10 (attack:9 business:5 tech:8 gate:6 cloud:3 fresh:2)
[PRIO] platform.sparelabs.com/login (CSP leak) — 6.05 (attack:6 business:7 tech:5 gate:9 cloud:5 fresh:2)
[PRIO] api.sparelabs.com/v1/global/regions — 5.95 (attack:7 business:6 tech:6 gate:8 cloud:4 fresh:2)
[PRIO] api.sparelabs.com/v1/public/organization — 5.40 (attack:6 business:5 tech:5 gate:10 cloud:2 fresh:2)
[HYP] Cross-origin write execution on complete zero-header bypass /v1/global/organizations
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 55
reasoning: OPTIONS 204 advertises PUT/PATCH/POST/DELETE with ACAO+ACAC on exact fail-open route. GET returns 200+11B with zero Authorization header. CORS chain (A1) + zero-header bypass (A4) both accepted. Write handler execution never tested — if POST/PUT process bodies without auth, cross-origin state mutation possible via victim browser.
evidence_needed: OPTIONS 204 + ACAO+ACAC + write-methods on /v1/global/organizations (passive preflight); 2xx on POST requires AUTH_HELPED
verify_steps: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" -H "Access-Control-Request-Headers: Authorization,Content-Type" https://api.sparelabs.com/v1/global/organizations`
impact: Cross-origin state modification (create/update/delete org records) without auth via victim admin browser; elevates accepted read bypass to write
testability: PASSIVE (OPTIONS re-confirm) / AUTH_HELPED (body send)
[HYP] /v1/public/mobileApps/{id} UUID enumeration oracle parallel to org oracle
class: AUTH
asset: api.sparelabs.com/v1/public/mobileApps/{id}
confidence: 45
reasoning: /v1/public/mobileApps/00000000-0000-0000-0000-000000000000 returns 404 auth-free (route registered, real DB lookup). /v1/public/organization has confirmed 3-way UUID oracle (400/404/200). If mobileApp namespace mirrors org, a parallel oracle exists. No 200-branch observed yet.
evidence_needed: 200 response with real mobileApp UUID or format discrimination (400 malformed vs 404 not-found)
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/00000000-0000-0000-0000-000000000000"`
impact: mobileApp record disclosure or new UUID enumeration oracle; enables pivot to authenticated mobileApp-scoped endpoints
testability: PASSIVE (real-UUID branch needs HUMAN_ONLY)
[HYP] routing.sparelabs.com deep-path re-check via alternate ingress
class: BUSLOGIC
asset: routing.sparelabs.com
confidence: 15
reasoning: routing.sparelabs.com has been envoy 404 on ALL paths for 3+ days. No alternate ingress (cdn, api-gateway, subdomain variant) has been tested. If the routing API lives behind a different host (e.g., via api.sparelabs.com/v1/routing/*), the asset may be reachable indirectly. Confidence low given 3+ days negative evidence.
evidence_needed: 2xx/3xx/401 (not 404) on any routing host/path variant
verify_steps: `curl -s -o /dev/null -w "%{http_code}" https://api.sparelabs.com/v1/routing/status` ; `curl -s -o /dev/null -w "%{http_code}" https://api.sparelabs.com/v1/directions`
impact: If routing API is reachable behind api host, full routing/auth surface opens (in-scope high-value target)
testability: PASSIVE
[PARKED] Cross-origin write execution on /v1/global/organizations: confidence 55 — passive verification only re-confirms already-documented OPTIONS surface (A1 CORS + A4 zero-header both accepted). Actual write processing requires active body send (non-passive, AUTH_HELPED). Downgraded to informational escalation note on A4 — not a new finding.
[PARKED] /v1/public/mobileApps/{id} UUID enumeration oracle: confidence 45 — 404 alone not a vulnerability; no 200-branch observed; real-UUID branch needs HUMAN_ONLY. Downgraded to HOLD.
[PARKED] routing.sparelabs.com deep-path re-check: confidence 15 — below threshold. Already rejected BUSLOGIC on routing since 2026-08-07 with 40+ negative probes. Downgraded to dead-asset confirmation.
[FINAL] No surviving hypotheses above confidence 40 with passive proof path. All 7 accepted findings (A1–A7) remain the complete valid surface. No new reportable findings this cycle.
[NEXT] PROBE: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" -H "Access-Control-Request-Headers: Authorization,Content-Type" https://api.sparelabs.com/v1/global/organizations` — re-confirm write CORS chain convergence (POST method advertised with ACAO+ACAC on exact fail-open route). If ACAO+ACAC + POST confirmed, add escalation note to A4 (read→write surface) without requiring AUTH_HELPED body send.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:https://evil.example.com + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authorization,Content-Type on OPTIONS 204 + GET (200/401/400) uniformly across /v1 — re-confirmed 84h+ stable
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: Scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions, 6 OOS) + ACAO+ACAC; body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: Complete zero-header no-auth bypass STABLE — 200 + 11B `{"data":[]}` + ACAO+ACAC with NO Authorization header; OPTIONS 204 confirms PUT/PATCH/POST/DELETE advertised
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/public/organization: 3-way UUID oracle STABLE — malformed→400 ValidationError "must match format uuid" (285B + correlationId); nil-uuid→404 NotFoundError (131B + correlationId)
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Data disclosure STABLE — `?mobileAppId=<nil-uuid>` → 200 + 137B (termsOfUseUrl→sparelabs.com/terms-of-use/, privacyPolicyUrl→sparelabs.com/privacy-policy/) no-auth + CORS
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP infra leak STABLE — prod admin-eam-app.vercel.app + admin-fixed-route-app.vercel.app (both 200) + staging variants + Metabase prod+staging (200) + Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit in CSP
[LEARN] ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.sparelabs.com + forms.staging.us.sparelabs.com + atlassian.net + ngrok.io
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: STABLE dead — envoy 404 on ALL probed paths; no surface, NO_DELTA since 2026-08-07
[RISK] api.sparelabs.com: **90** — multiple confirmed auth bypasses (zero-header + scheme-only), universal CORS credential reflection across all /v1, UUID oracle, data disclosure, multi-version LB flapping; highest exposure in program with 3 distinct AUTH/MISCONFIG classes accepted stable 84h+; chain amplification (CORS + auth bypass + org enum) enables full cross-origin data exfil + potential state mutation
[RISK] platform.sparelabs.com: **55** — CSP infra leak exposes production admin Vercel apps + staging + Metabase + full cloud infra (Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit); admin surface reachable but OOS third-party hosts limit direct exploitation; SPA catch-all confirmed no direct API surface
[RISK] routing.sparelabs.com: **5** — envoy 404 on ALL paths, no discoverable surface, effectively dead across 3+ days of continuous probing
[RISK] forms.sparelabs.com: **35** — JS bundle main.71d52314.js leaks staging+prod+regional infra (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, atlassian.net, ngrok.io); SPA catch-all confirmed no direct API attack surface; infra-recon value only
[RISK] web (spare.com/sparelabs.com): **10** — static Webflow marketing on Cloudflare, strict CSP `frame-ancestors 'self'`, HSTS 31536000, no internal infra leaks; minimal static-only surface
## 2026-08-10 12:06:12 UTC [routing] (model longcat)
[PRIO] api.sparelabs.com/v1/global/organizations — 6.90 (attack:8 business:7 tech:7 gate:10 cloud:4 fresh:2)
[PRIO] api.sparelabs.com/v1/** (CORS reflection) — 6.10 (attack:9 business:5 tech:8 gate:6 cloud:3 fresh:2)
[PRIO] platform.sparelabs.com/login (CSP leak) — 6.05 (attack:6 business:7 tech:5 gate:9 cloud:5 fresh:2)
[PRIO] api.sparelabs.com/v1/global/regions — 5.95 (attack:7 business:6 tech:6 gate:8 cloud:4 fresh:2)
[PRIO] api.sparelabs.com/v1/public/organization — 5.40 (attack:6 business:5 tech:5 gate:10 cloud:2 fresh:2)
[HYP] Cross-origin write execution on complete zero-header bypass /v1/global/organizations
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 55
reasoning: OPTIONS 204 advertises PUT/PATCH/POST/DELETE with ACAO+ACAC on exact fail-open route. GET returns 200+11B with zero Authorization header. CORS chain (A1) + zero-header bypass (A4) both accepted. Write handler execution never tested — if POST/PUT process bodies without auth, cross-origin state mutation possible via victim browser.
evidence_needed: OPTIONS 204 + ACAO+ACAC + write-methods on /v1/global/organizations (passive preflight); 2xx on POST requires AUTH_HELPED
verify_steps: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" -H "Access-Control-Request-Headers: Authorization,Content-Type" https://api.sparelabs.com/v1/global/organizations`
impact: Cross-origin state modification (create/update/delete org records) without auth via victim admin browser; elevates accepted read bypass to write
testability: PASSIVE (OPTIONS re-confirm) / AUTH_HELPED (body send)
[HYP] /v1/public/mobileApps/{id} UUID enumeration oracle parallel to org oracle
class: AUTH
asset: api.sparelabs.com/v1/public/mobileApps/{id}
confidence: 45
reasoning: /v1/public/mobileApps/00000000-0000-0000-0000-000000000000 returns 404 auth-free (route registered, real DB lookup). /v1/public/organization has confirmed 3-way UUID oracle (400/404/200). If mobileApp namespace mirrors org, a parallel oracle exists. No 200-branch observed yet.
evidence_needed: 200 response with real mobileApp UUID or format discrimination (400 malformed vs 404 not-found)
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/00000000-0000-0000-0000-000000000000"`
impact: mobileApp record disclosure or new UUID enumeration oracle; enables pivot to authenticated mobileApp-scoped endpoints
testability: PASSIVE (real-UUID branch needs HUMAN_ONLY)
[HYP] routing.sparelabs.com deep-path re-check via alternate ingress
class: BUSLOGIC
asset: routing.sparelabs.com
confidence: 15
reasoning: routing.sparelabs.com has been envoy 404 on ALL paths for 3+ days. No alternate ingress (cdn, api-gateway, subdomain variant) has been tested. If the routing API lives behind a different host (e.g., via api.sparelabs.com/v1/routing/*), the asset may be reachable indirectly. Confidence low given 3+ days negative evidence.
evidence_needed: 2xx/3xx/401 (not 404) on any routing host/path variant
verify_steps: `curl -s -o /dev/null -w "%{http_code}" https://api.sparelabs.com/v1/routing/status` ; `curl -s -o /dev/null -w "%{http_code}" https://api.sparelabs.com/v1/directions`
impact: If routing API is reachable behind api host, full routing/auth surface opens (in-scope high-value target)
testability: PASSIVE
[PARKED] Cross-origin write execution on /v1/global/organizations: confidence 55 — passive verification only re-confirms already-documented OPTIONS surface (A1 CORS + A4 zero-header both accepted). Actual write processing requires active body send (non-passive, AUTH_HELPED). Downgraded to informational escalation note on A4 — not a new finding.
[PARKED] /v1/public/mobileApps/{id} UUID enumeration oracle: confidence 45 — 404 alone not a vulnerability; no 200-branch observed; real-UUID branch needs HUMAN_ONLY. Downgraded to HOLD.
[PARKED] routing.sparelabs.com deep-path re-check: confidence 15 — below threshold. Already rejected BUSLOGIC on routing since 2026-08-07 with 40+ negative probes. Downgraded to dead-asset confirmation.
[FINAL] No surviving hypotheses above confidence 40 with passive proof path. All 7 accepted findings (A1–A7) remain the complete valid surface. No new reportable findings this cycle.
[NEXT] PROBE: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" -H "Access-Control-Request-Headers: Authorization,Content-Type" https://api.sparelabs.com/v1/global/organizations` — re-confirm write CORS chain convergence (POST method advertised with ACAO+ACAC on exact fail-open route). If ACAO+ACAC + POST confirmed, add escalation note to A4 (read→write surface) without requiring AUTH_HELPED body send.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:https://evil.example.com + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authorization,Content-Type on OPTIONS 204 + GET (200/401/400) uniformly across /v1 — re-confirmed 84h+ stable
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: Scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions, 6 OOS) + ACAO+ACAC; body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: Complete zero-header no-auth bypass STABLE — 200 + 11B `{"data":[]}` + ACAO+ACAC with NO Authorization header; OPTIONS 204 confirms PUT/PATCH/POST/DELETE advertised
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/public/organization: 3-way UUID oracle STABLE — malformed→400 ValidationError "must match format uuid" (285B + correlationId); nil-uuid→404 NotFoundError (131B + correlationId)
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Data disclosure STABLE — `?mobileAppId=<nil-uuid>` → 200 + 137B (termsOfUseUrl→sparelabs.com/terms-of-use/, privacyPolicyUrl→sparelabs.com/privacy-policy/) no-auth + CORS
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP infra leak STABLE — prod admin-eam-app.vercel.app + admin-fixed-route-app.vercel.app (both 200) + staging variants + Metabase prod+staging (200) + Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit in CSP
[LEARN] ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.sparelabs.com + forms.staging.us.sparelabs.com + atlassian.net + ngrok.io
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: STABLE dead — envoy 404 on ALL probed paths; no surface, NO_DELTA since 2026-08-07
[RISK] api.sparelabs.com: **90** — multiple confirmed auth bypasses (zero-header + scheme-only), universal CORS credential reflection across all /v1, UUID oracle, data disclosure, multi-version LB flapping; highest exposure in program with 3 distinct AUTH/MISCONFIG classes accepted stable 84h+; chain amplification (CORS + auth bypass + org enum) enables full cross-origin data exfil + potential state mutation
[RISK] platform.sparelabs.com: **55** — CSP infra leak exposes production admin Vercel apps + staging + Metabase + full cloud infra (Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit); admin surface reachable but OOS third-party hosts limit direct exploitation; SPA catch-all confirmed no direct API surface
[RISK] routing.sparelabs.com: **5** — envoy 404 on ALL paths, no discoverable surface, effectively dead across 3+ days of continuous probing
[RISK] forms.sparelabs.com: **35** — JS bundle main.71d52314.js leaks staging+prod+regional infra (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, atlassian.net, ngrok.io); SPA catch-all confirmed no direct API attack surface; infra-recon value only
[RISK] web (spare.com/sparelabs.com): **10** — static Webflow marketing on Cloudflare, strict CSP `frame-ancestors 'self'`, HSTS 31536000, no internal infra leaks; minimal static-only surface
## 2026-08-10 13:39:52 UTC [routing] (model longcat)
[PRIO] api.sparelabs.com/v1/global/organizations (zero-header bypass + write CORS) — 6.90 (attack:8 business:7 tech:7 gate:10 cloud:4 fresh:2)
[PRIO] api.sparelabs.com/v1/** (universal CORS credential reflection) — 6.10 (attack:9
## 2026-08-10 14:45:13 UTC [routing] (model longcat)
[HYP] Cross-origin write execution on complete zero-header bypass /v1/global/organizations
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 55
reasoning: OPTIONS 204 advertises PUT/PATCH/POST/DELETE with ACAO+ACAC on exact fail-open route. GET returns 200+11B with zero Authorization header. CORS chain (A1) + zero-header bypass (A4) both accepted. Write handler execution never tested — if POST/PUT process bodies without auth, cross-origin state mutation possible via victim browser.
evidence_needed: OPTIONS 204 + ACAO+ACAC + write-methods on /v1/global/organizations (passive preflight); 2xx on POST requires AUTH_HELPED
verify_steps: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" -H "Access-Control-Request-Headers: Authorization,Content-Type" https://api.sparelabs.com/v1/global/organizations`
impact: Cross-origin state modification (create/update/delete org records) without auth via victim admin browser; elevates accepted read bypass to write
testability: PASSIVE (OPTIONS re-confirm) / AUTH_HELPED (body send)
[HYP] /v1/public/mobileApps/{id} UUID enumeration oracle parallel to org oracle
class: AUTH
asset: api.sparelabs.com/v1/public/mobileApps/{id}
confidence: 45
reasoning: /v1/public/mobileApps/00000000-0000-0000-0000-000000000000 returns 404 auth-free (route registered, real DB lookup). /v1/public/organization has confirmed 3-way UUID oracle (400/404/200). If mobileApp namespace mirrors org, a parallel oracle exists. No 200-branch observed yet.
evidence_needed: 200 response with real mobileApp UUID or format discrimination (400 malformed vs 404 not-found)
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/00000000-0000-0000-0000-000000000000"`
impact: mobileApp record disclosure or new UUID enumeration oracle; enables pivot to authenticated mobileApp-scoped endpoints
testability: PASSIVE (real-UUID branch needs HUMAN_ONLY)
[HYP] routing API reachable behind api.sparelabs.com/v1/routing/*
class: BUSLOGIC
asset: api.sparelabs.com/v1/routing/*
confidence: 20
reasoning: routing.sparelabs.com has been envoy 404 on ALL paths for 3+ days. No alternate ingress tested on the in-scope api host. If the routing API lives behind api.sparelabs.com (e.g., /v1/routing/*), the asset may be reachable indirectly. Confidence low given 3+ days negative evidence on the dedicated host.
evidence_needed: 2xx/3xx/401 (not 404) on any routing path behind api host
verify_steps: `curl -s -o /dev/null -w "%{http_code}" https://api.sparelabs.com/v1/routing/status` ; `curl -s -o /dev/null -w "%{http_code}" https://api.sparelabs.com/v1/directions`
impact: If routing API is reachable behind api host, full routing/auth surface opens (in-scope high-value target)
testability: PASSIVE
[PARKED] Cross-origin write execution on /v1/global/organizations: confidence 55 — passive verification only re-confirms already-documented OPTIONS surface (A1 CORS + A4 zero-header both accepted). Actual write processing requires active body send (non-passive, AUTH_HELPED). Downgraded to informational escalation note on A4 — not a new finding.
[PARKED] /v1/public/mobileApps/{id} UUID enumeration oracle: confidence 45 — 404 alone not a vulnerability; no 200-branch observed; real-UUID branch needs HUMAN_ONLY. Downgraded to HOLD.
[PARKED] routing API reachable behind api host: confidence 20 — below threshold. routing.sparelabs.com rejected BUSLOGIC since 2026-08-07 with 40+ negative probes. Indirect reachability on api host is speculative with no supporting evidence. Downgraded to dead-asset confirmation.
[FINAL] No surviving hypotheses above confidence 40 with passive proof path. All 7 accepted findings (A1–A7) remain the complete valid surface. No new reportable findings this cycle.
[NEXT] PROBE: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" -H "Access-Control-Request-Headers: Authorization,Content-Type" https://api.sparelabs.com/v1/global/organizations` — re-confirm write CORS chain convergence (POST method advertised with ACAO+ACAC on exact fail-open route). If ACAO+ACAC + POST confirmed, add escalation note to A4 (read→write surface) without requiring AUTH_HELPED body send.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:https://evil.example.com + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authorization,Content-Type on OPTIONS 204 + GET (200/401/400) uniformly across /v1 — re-confirmed 84h+ stable
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: Scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions, 6 OOS) + ACAO+ACAC; body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: Complete zero-header no-auth bypass STABLE — 200 + 11B `{"data":[]}` + ACAO+ACAC with NO Authorization header; OPTIONS 204 confirms PUT/PATCH/POST/DELETE advertised
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/public/organization: 3-way UUID oracle STABLE — malformed→400 ValidationError "must match format uuid" (285B + correlationId); nil-uuid→404 NotFoundError (131B + correlationId)
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Data disclosure STABLE — `?mobileAppId=<nil-uuid>` → 200 + 137B (termsOfUseUrl→sparelabs.com/terms-of-use/, privacyPolicyUrl→sparelabs.com/privacy-policy/) no-auth + CORS
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP infra leak STABLE — prod admin-eam-app.vercel.app + admin-fixed-route-app.vercel.app (both 200) + staging variants + Metabase prod+staging (200) + Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit in CSP
[LEARN] ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.sparelabs.com + forms.staging.us.sparelabs.com + atlassian.net + ngrok.io
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: STABLE dead — envoy 404 on ALL probed paths; no surface, NO_DELTA since 2026-08-07
[RISK] api.sparelabs.com: **90** — multiple confirmed auth bypasses (zero-header + scheme-only), universal CORS credential reflection across all /v1, UUID oracle, data disclosure, multi-version LB flapping; highest exposure in program with 3 distinct AUTH/MISCONFIG classes accepted stable 84h+; chain amplification (CORS + auth bypass + org enum) enables full cross-origin data exfil + potential state mutation
[RISK] platform.sparelabs.com: **55** — CSP infra leak exposes production admin Vercel apps + staging + Metabase + full cloud infra (Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit); admin surface reachable but OOS third-party hosts limit direct exploitation; SPA catch-all confirmed no direct API surface
[RISK] routing.sparelabs.com: **5** — envoy 404 on ALL paths, no discoverable surface, effectively dead across 3+ days of continuous probing
[RISK] forms.sparelabs.com: **35** — JS bundle main.71d52314.js leaks staging+prod+regional infra (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, atlassian.net, ngrok.io); SPA catch-all confirmed no direct API attack surface; infra-recon value only
[RISK] web (spare.com/sparelabs.com): **10** — static Webflow marketing on Cloudflare, strict CSP `frame-ancestors 'self'`, HSTS 31536000, no internal infra leaks; minimal static-only surface
## 2026-08-10 15:43:39 UTC [routing] (model longcat)
[PRIO] api.sparelabs.com/v1/global/organizations (zero-header bypass + write CORS) — **6.90** (attack:8 business:7 tech:7 gate:10 cloud:4 fresh:2)
[PRIO] api.sparelabs.com/v1/** (universal CORS credential reflection) — **6.10** (attack:9 business:6 tech:5 gate:10 cloud:3 fresh:1)
[PRIO] api.sparelabs.com/v1/global/regions (scheme-only bypass + infra disclosure) — **5.85** (attack:7 business:8 tech:6 gate:6 cloud:5 fresh:2)
[PRIO] platform.sparelabs.com/login (CSP infra leak) — **4.55** (attack:4 business:6 tech:4 gate:10 cloud:6 fresh:1)
[PRIO] api.sparelabs.com/v1/public/organization (UUID oracle) — **4.40** (attack:6 business:5 tech:5 gate:10 cloud:1 fresh:1)
[HYP] Cross-origin write execution on complete zero-header bypass /v1/global/organizations
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 55
reasoning: OPTIONS 204 advertises PUT/PATCH/POST/DELETE with ACAO+ACAC on exact fail-open route (live re-confirmed this cycle). GET returns 200+11B with zero Authorization header. CORS chain (A1) + zero-header bypass (A4) both accepted. Write handler execution never tested — if POST/PUT process bodies without auth, cross-origin state mutation possible via victim browser.
evidence_needed: OPTIONS 204 + ACAO+ACAC + write-methods on /v1/global/organizations (passive preflight); 2xx on POST requires AUTH_HELPED
verify_steps: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" -H "Access-Control-Request-Headers: Authorization,Content-Type" https://api.sparelabs.com/v1/global/organizations`
impact: Cross-origin state modification (create/update/delete org records) without auth via victim admin browser; elevates accepted read bypass to write
testability: PASSIVE (OPTIONS re-confirm) / AUTH_HELPED (body send)
[HYP] /v1/public/mobileApps/{id} UUID enumeration oracle parallel to org oracle
class: AUTH
asset: api.sparelabs.com/v1/public/mobileApps/{id}
confidence: 45
reasoning: /v1/public/mobileApps/00000000-0000-0000-0000-000000000000 returns 404 auth-free (route registered, real DB lookup). /v1/public/organization has confirmed 3-way UUID oracle (400/404/200). If mobileApp namespace mirrors org, a parallel oracle exists. No 200-branch observed yet.
evidence_needed: 200 response with real mobileApp UUID or format discrimination (400 malformed vs 404 not-found)
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/00000000-0000-0000-0000-000000000000"`
impact: mobileApp record disclosure or new UUID enumeration oracle; enables pivot to authenticated mobileApp-scoped endpoints
testability: PASSIVE (real-UUID branch needs HUMAN_ONLY)
[HYP] routing API reachable behind api.sparelabs.com/v1/routing/*
class: BUSLOGIC
asset: api.sparelabs.com/v1/routing/*
confidence: 20
reasoning: routing.sparelabs.com has been envoy 404 on ALL paths for 3+ days. No alternate ingress tested on the in-scope api host. If the routing API lives behind api.sparelabs.com (e.g., /v1/routing/*), the asset may be reachable indirectly. Confidence low given 3+ days negative evidence on the dedicated host.
evidence_needed: 2xx/3xx/401 (not 404) on any routing path behind api host
verify_steps: `curl -s -o /dev/null -w "%{http_code}" https://api.sparelabs.com/v1/routing/status` ; `curl -s -o /dev/null -w "%{http_code}" https://api.sparelabs.com/v1/directions`
impact: If routing API is reachable behind api host, full routing/auth surface opens (in-scope high-value target)
testability: PASSIVE
[PARKED] Cross-origin write execution on /v1/global/organizations: confidence 55 — passive verification only re-confirms already-documented OPTIONS surface (A1 CORS + A4 zero-header both accepted). Actual write processing requires active body send (non-passive, AUTH_HELPED). Downgraded to informational escalation note on A4 — not a new finding.
[PARKED] /v1/public/mobileApps/{id} UUID enumeration oracle: confidence 45 — 404 alone not a vulnerability; no 200-branch observed; real-UUID branch needs HUMAN_ONLY. Downgraded to HOLD.
[PARKED] routing API reachable behind api host: confidence 20 — below threshold. routing.sparelabs.com rejected BUSLOGIC since 2026-08-07 with 40+ negative probes. Indirect reachability on api host is speculative with no supporting evidence. Downgraded to dead-asset confirmation.
[FINAL] No surviving hypotheses above confidence 40 with passive proof path. All 7 accepted findings (A1–A7) remain the complete valid surface. No new reportable findings this cycle.
[NEXT] PROBE: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" -H "Access-Control-Request-Headers: Authorization,Content-Type" https://api.sparelabs.com/v1/global/organizations` — re-confirm write CORS chain convergence (POST method advertised with ACAO+ACAC on exact fail-open route). If ACAO+ACAC + POST confirmed, add escalation note to A4 (read→write surface) without requiring AUTH_HELPED body send.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:https://evil.example.com + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authorization,Content-Type on OPTIONS 204 + GET (200/401/400) uniformly across /v1 — re-confirmed 84h+ stable
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: Scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions, 6 OOS) + ACAO+ACAC; body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: Complete zero-header no-auth bypass STABLE — 200 + 11B `{"data":[]}` + ACAO+ACAC with NO Authorization header; OPTIONS 204 confirms PUT/PATCH/POST/DELETE advertised
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/public/organization: 3-way UUID oracle STABLE — malformed→400 ValidationError "must match format uuid" (285B + correlationId); nil-uuid→404 NotFoundError (131B + correlationId)
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Data disclosure STABLE — `?mobileAppId=<nil-uuid>` → 200 + 137B (termsOfUseUrl→sparelabs.com/terms-of-use/, privacyPolicyUrl→sparelabs.com/privacy-policy/) no-auth + CORS
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP infra leak STABLE — prod admin-eam-app.vercel.app + admin-fixed-route-app.vercel.app (both 200) + staging variants + Metabase prod+staging (200) + Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit in CSP
[LEARN] ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.sparelabs.com + forms.staging.us.sparelabs.com + atlassian.net + ngrok.io
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: STABLE dead — envoy 404 on ALL probed paths; no surface, NO_DELTA since 2026-08-07
[RISK] api.sparelabs.com: **90** — multiple confirmed auth bypasses (zero-header + scheme-only), universal CORS credential reflection across all /v1, UUID oracle, data disclosure, multi-version LB flapping; highest exposure in program with 3 distinct AUTH/MISCONFIG classes accepted stable 84h+; chain amplification (CORS + auth bypass + org enum) enables full cross-origin data exfil + potential state mutation
[RISK] platform.sparelabs.com: **55** — CSP infra leak exposes production admin Vercel apps + staging + Metabase + full cloud infra (Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit); admin surface reachable but OOS third-party hosts limit direct exploitation; SPA catch-all confirmed no direct API surface
[RISK] routing.sparelabs.com: **5** — envoy 404 on ALL paths, no discoverable surface, effectively dead across 3+ days of continuous probing
[RISK] forms.sparelabs.com: **35** — JS bundle main.71d52314.js leaks staging+prod+regional infra (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, atlassian.net, ngrok.io); SPA catch-all confirmed no direct API attack surface; infra-recon value only
[RISK] web (spare.com/sparelabs.com): **10** — static Webflow marketing on Cloudflare, strict CSP `frame-ancestors 'self'`, HSTS 31536000, no internal infra leaks; minimal static-only surface
## 2026-08-10 16:36:06 UTC [routing] (model longcat)
[PRIO] api.sparelabs.com/v1/global/organizations (zero-header bypass + write CORS) — **6.90** (attack:8 business:7 tech:7 gate:10 cloud:4 fresh:1)
[PRIO] api.sparelabs.com/v1/** (universal CORS credential reflection) — **6.10** (attack:9 business:6 tech:5 gate:10 cloud:3 fresh:1)
[PRIO] api.sparelabs.com/v1/global/regions (scheme-only bypass + infra disclosure) — **5.85** (attack:7 business:8 tech:6 gate:6 cloud:5 fresh:1)
[PRIO] platform.sparelabs.com/login (CSP infra leak) — **4.55** (attack:4 business:6 tech:4 gate:10 cloud:6 fresh:1)
[PRIO] api.sparelabs.com/v1/public/organization (UUID oracle) — **4.40** (attack:6 business:5 tech:5 gate:10 cloud:1 fresh:1)
[HYP] /v1/public/mobileApps/{id} UUID enumeration oracle parallel to org oracle
class: AUTH
asset: api.sparelabs.com/v1/public/mobileApps/{id}
confidence: 48
reasoning: /v1/public/mobileApps/00000000-0000-0000-0000-000000000000 returns 404 auth-free (route registered, real DB lookup). /v1/public/organization has confirmed 3-way UUID oracle (400 malformed / 404 not-found / 200 found). If mobileApp namespace mirrors org, a parallel oracle exists with same auth-free validation-error disclosure + CORS. 404 alone not vuln; need format discrimination or 200-branch.
evidence_needed: 400 ValidationError on malformed input (proves format-checking like org oracle) OR 200 with real mobileApp UUID
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/00000000-0000-0000-0000-000000000000"`
impact: mobileApp record disclosure or new UUID enumeration oracle; enables pivot to authenticated mobileApp-scoped endpoints
testability: PASSIVE (format discrimination) / HUMAN_ONLY (real-UUID 200-branch)
[HYP] /v1/public/riders/{id} UUID enumeration oracle on rider namespace
class: AUTH
asset: api.sparelabs.com/v1/public/riders/{id}
confidence: 42
reasoning: /v1/public/organization has confirmed 3-way UUID oracle. /v1/public/* namespace has multiple unauthenticated endpoints (terms, organization). If riders subroute exists with same validation pattern, parallel oracle possible. No prior probing of this path in knowledge base.
evidence_needed: 400 ValidationError on malformed input OR 404 vs 200 discrimination on nil-uuid vs real UUID
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/riders/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/riders/00000000-0000-0000-0000-000000000000"`
impact: rider record disclosure or new UUID enumeration oracle; rider PII likely higher-value than org data
testability: PASSIVE (format discrimination) / HUMAN_ONLY (real-UUID 200-branch)
[HYP] /v1/public/vehicles/{id} UUID enumeration oracle on vehicle namespace
class: AUTH
asset: api.sparelabs.com/v1/public/vehicles/{id}
confidence: 40
reasoning: Same pattern as org oracle. Spare is a mobility platform — vehicles are core business objects. If /v1/public/vehicles/{id} mirrors the org oracle's validation pattern (400 malformed / 404 not-found / 200 found), a third parallel oracle exists. No prior probing in knowledge base.
evidence_needed: 400 ValidationError on malformed input OR 404 vs 200 discrimination
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/vehicles/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/vehicles/00000000-0000-0000-0000-000000000000"`
impact: vehicle record disclosure or new UUID enumeration oracle; fleet data exposure
testability: PASSIVE (format discrimination) / HUMAN_ONLY (real-UUID 200-branch)
[PARKED] Cross-origin write execution on /v1/global/organizations: confidence 55 but circular — passive verification only re-confirms already-documented OPTIONS surface (A1 CORS + A4 zero-header both accepted). Write handler execution requires AUTH_HELPED body send. Not a new finding, just an escalation note on existing A4.
[PARKED] routing API reachable behind api host: confidence 20 — below threshold. routing.sparelabs.com rejected BUSLOGIC since 2026-08-07 with 40+ negative probes. Speculative with no supporting evidence.
[FINAL] Surviving hypotheses (ranked):
[NEXT] PROBE: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/not-a-uuid"` && `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/00000000-0000-0000-0000-000000000000"` — test for format discrimination (400 vs 404) that would confirm parallel UUID enumeration oracle on mobileApp namespace. If malformed→400 + nil-uuid→404, oracle confirmed (mirrors org pattern exactly).
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:https://evil.example.com + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authorization,Content-Type on OPTIONS 204 + GET (200/401/400) uniformly across /v1 — 84h+ stable
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: Scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions, 6 OOS) + ACAO+ACAC; body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: Complete zero-header no-auth bypass STABLE — 200 + 11B `{"data":[]}` + ACAO+ACAC with NO Authorization header; OPTIONS 204 confirms PUT/PATCH/POST/DELETE advertised
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/public/organization: 3-way UUID oracle STABLE — malformed→400 ValidationError "must match format uuid" (285B + correlationId); nil-uuid→404 NotFoundError (131B + correlationId)
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Data disclosure STABLE — `?mobileAppId=<nil-uuid>` → 200 + 137B (termsOfUseUrl→sparelabs.com/terms-of-use/, privacyPolicyUrl→sparelabs.com/privacy-policy/) no-auth + CORS
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP infra leak STABLE — prod admin-eam-app.vercel.app + admin-fixed-route-app.vercel.app (both 200) + staging variants + Metabase prod+staging (200) + Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit in CSP
[LEARN] ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.sparelabs.com + forms.staging.us.sparelabs.com + atlassian.net + ngrok.io
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: STABLE dead — envoy 404 on ALL probed paths; no surface, NO_DELTA since 2026-08-07
[RISK] api.sparelabs.com: **90** — multiple confirmed auth bypasses (zero-header + scheme-only), universal CORS credential reflection across all /v1, UUID oracle, data disclosure, multi-version LB flapping; highest exposure in program with 3 distinct AUTH/MISCONFIG classes accepted stable 84h+; chain amplification (CORS + auth bypass + org enum) enables full cross-origin data exfil + potential state mutation
[RISK] platform.sparelabs.com: **55** — CSP infra leak exposes production admin Vercel apps + staging + Metabase + full cloud infra (Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit); admin surface reachable but OOS third-party hosts limit direct exploitation; SPA catch-all confirmed no direct API surface
[RISK] routing.sparelabs.com: **5** — envoy 404 on ALL paths, no discoverable surface, effectively dead across 3+ days of continuous probing
[RISK] forms.sparelabs.com: **35** — JS bundle main.71d52314.js leaks staging+prod+regional infra (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, atlassian.net, ngrok.io); SPA catch-all confirmed no direct API attack surface; infra-recon value only
[RISK] web (spare.com/sparelabs.com): **10** — static Webflow marketing on Cloudflare, strict CSP `frame-ancestors 'self'`, HSTS 31536000, no internal infra leaks; minimal static-only surface
## 2026-08-10 17:33:46 UTC [routing] (model longcat)
[PRIO] api.sparelabs.com/v1/global/organizations (zero-header bypass + write CORS) — **6.80** (attack:8 business:7 tech:7 gate:10 cloud:4 fresh:1)
[PRIO] api.sparelabs.com/v1/** (universal CORS credential reflection) — **6.10** (attack:9 business:6 tech:5 gate:10 cloud:3 fresh:1)
[PRIO] api.sparelabs.com/v1/global/regions (scheme-only bypass + infra topology disclosure) — **5.85** (attack:7 business:8 tech:6 gate:6 cloud:5 fresh:1)
[HYP] /v1/public/mobileApps/{id} UUID enumeration oracle parallel to org oracle
class: AUTH
asset: api.sparelabs.com/v1/public/mobileApps/{id}
confidence: 48
reasoning: /v1/public/organization has confirmed 3-way UUID oracle (400 malformed / 404 not-found / 200 found) + auth-free + CORS. /v1/public/* namespace has multiple unauthenticated endpoints (terms, organization). If mobileApp subroute mirrors org validation pattern, parallel oracle exists. Spare is mobility platform — mobileApp is core business object.
evidence_needed: 400 ValidationError on malformed input (proves format-checking like org oracle) OR 404 vs 200 discrimination
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/00000000-0000-0000-0000-000000000000"`
impact: mobileApp UUID enumeration oracle; enables discovery of valid mobileApp IDs for pivot to authenticated mobileApp-scoped endpoints or IDOR
testability: PASSIVE (format discrimination) / HUMAN_ONLY (real-UUID 200-branch)
[HYP] /v1/public/riders/{id} UUID enumeration oracle on rider namespace
class: AUTH
asset: api.sparelabs.com/v1/public/riders/{id}
confidence: 42
reasoning: /v1/public/organization confirmed 3-way UUID oracle. Rider namespace is higher-value PII target in mobility platform. No prior probing of this path in knowledge base. If route exists with same validation pattern, parallel oracle possible.
evidence_needed: 400 ValidationError on malformed input OR 404 vs 200 discrimination
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/riders/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/riders/00000000-0000-0000-0000-000000000000"`
impact: rider UUID enumeration oracle; rider PII likely higher-value than org data; enables pivot to authenticated rider endpoints
testability: PASSIVE (format discrimination) / HUMAN_ONLY (real-UUID 200-branch)
[HYP] /v1/public/vehicles/{id} UUID enumeration oracle on vehicle namespace
class: AUTH
asset: api.sparelabs.com/v1/public/vehicles/{id}
confidence: 40
reasoning: Same pattern as org oracle. Vehicles are core fleet business objects in mobility platform. No prior probing in knowledge base. If route exists with same validation pattern, third parallel oracle possible.
evidence_needed: 400 ValidationError on malformed input OR 404 vs 200 discrimination
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/vehicles/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/vehicles/00000000-0000-0000-0000-000000000000"`
impact: vehicle UUID enumeration oracle; fleet data exposure; enables pivot to vehicle-scoped endpoints
testability: PASSIVE (format discrimination) / HUMAN_ONLY (real-UUID 200-branch)
[PARKED] /v1/public/mobileApps/{id}: Confidence 48 is borderline — route existence unproven. 404 alone is not a vuln; only format discrimination (400 vs 404) or 200-branch confirms oracle. Keeping as lowest-priority probe since verify_steps are PASSIVE-safe.
[FINAL] Surviving hypotheses (ranked):
[NEXT] PROBE: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/not-a-uuid"` && `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/00000000-0000-0000-0000-000000000000"` — test for format discrimination (400 vs 404) that would confirm parallel UUID enumeration oracle on mobileApp namespace. If malformed→400 + nil-uuid→404, oracle confirmed (mirrors org pattern exactly).
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: Complete zero-header no-auth bypass STABLE — 200 + `{"data":[]}` + ACAO+ACAC with NO Authorization header; OPTIONS 204 confirms PUT/PATCH/POST/DELETE advertised — 84h+ stable
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: Scheme-only bypass + infra topology disclosure STABLE — `Bearer x` → 200 + 725B region registry (7 regions, 6 OOS api/routing subdomains) + ACAO+ACAC; body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:https://evil.example.com + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authorization,Content-Type on OPTIONS 204 + GET (200/401/400) uniformly across /v1 — non-path-conditional via 14-sibling sweep
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/public/organization: 3-way UUID oracle STABLE — malformed→400 ValidationError "must match format uuid" (285B + correlationId); nil-uuid→404 NotFoundError (131B + correlationId)
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Data disclosure STABLE — `?mobileAppId=<nil-uuid>` → 200 + 137B (termsOfUseUrl→sparelabs.com/terms-of-use/, privacyPolicyUrl→sparelabs.com/privacy-policy/) no-auth + CORS
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP infra leak STABLE — prod admin-eam-app.vercel.app + admin-fixed-route-app.vercel.app (both 200) + staging variants + Metabase prod+staging (200) + Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit in CSP
[LEARN] ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.sparelabs.com + forms.staging.us.sparelabs.com + atlassian.net + ngrok.io
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: STABLE dead — envoy 404 on ALL probed paths; no surface, NO_DELTA since 2026-08-07
[RISK] api.sparelabs.com: **90** — multiple confirmed auth bypasses (zero-header + scheme-only), universal CORS credential reflection across all /v1, UUID oracle, data disclosure, multi-version LB flapping; highest exposure in program with 3 distinct AUTH/MISCONFIG classes accepted stable 84h+; chain amplification (CORS + auth bypass + org enum) enables full cross-origin data exfil + potential state mutation
[RISK] platform.sparelabs.com: **55** — CSP infra leak exposes production admin Vercel apps + staging + Metabase + full cloud infra (Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit); admin surface reachable but OOS third-party hosts limit direct exploitation; SPA catch-all confirmed no direct API surface
[RISK] routing.sparelabs.com: **5** — envoy 404 on ALL paths, no discoverable surface, effectively dead across 3+ days of continuous probing
[RISK] forms.sparelabs.com: **35** — JS bundle main.71d52314.js leaks staging+prod+regional infra (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, atlassian.net, ngrok.io); SPA catch-all confirmed no direct API attack surface; infra-recon value only
[RISK] web (spare.com/sparelabs.com): **10** — static Webflow marketing on Cloudflare, strict CSP `frame-ancestors 'self'`, HSTS 31536000, no internal infra leaks; minimal static-only surface
## 2026-08-10 18:30:17 UTC [routing] (model longcat)
[PRIO] api.sparelabs.com/v1/public/mobileApps/{id} — **6.85** (attack:7 business:7 tech:6 gate:9 cloud:3 fresh:8)
[PRIO] api.sparelabs.com/v1/public/riders/{id} — **6.30** (attack:7 business:8 tech:6 gate:9 cloud:2 fresh:7)
[PRIO] api.sparelabs.com/v1/public/vehicles/{id} — **6.00** (attack:7 business:7 tech:6 gate:9 cloud:2 fresh:6)
[HYP] /v1/public/mobileApps/{id} UUID enumeration oracle parallel to org oracle
class: AUTH
asset: api.sparelabs.com/v1/public/mobileApps/{id}
confidence: 48
reasoning: /v1/public/organization confirmed 3-way UUID oracle (400 malformed / 404 not-found / 200 found) + auth-free + CORS. /v1/public/terms?mobileAppId=<uuid> proves mobileApp is a real entity with validated UUID param. If subroute mirrors org validation pattern, parallel oracle exists. Spare is mobility platform — mobileApp is core business object.
evidence_needed: 400 ValidationError on malformed input (proves format-checking like org oracle) OR 404 vs 200 discrimination
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/00000000-0000-0000-0000-000000000000"`
impact: mobileApp UUID enumeration oracle; enables discovery of valid mobileApp IDs for pivot to authenticated mobileApp-scoped endpoints or IDOR
testability: PASSIVE (format discrimination) / HUMAN_ONLY (real-UUID 200-branch)
[HYP] /v1/public/riders/{id} UUID enumeration oracle on rider namespace
class: AUTH
asset: api.sparelabs.com/v1/public/riders/{id}
confidence: 42
reasoning: /v1/public/organization confirmed 3-way UUID oracle. Rider namespace is higher-value PII target in mobility platform (rider accounts, trip history, payment methods). No prior probing of this path in knowledge base. If route exists with same validation pattern, parallel oracle possible.
evidence_needed: 400 ValidationError on malformed input OR 404 vs 200 discrimination
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/riders/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/riders/00000000-0000-0000-0000-000000000000"`
impact: rider UUID enumeration oracle; rider PII likely higher-value than org data; enables pivot to authenticated rider endpoints
testability: PASSIVE (format discrimination) / HUMAN_ONLY (real-UUID 200-branch)
[HYP] /v1/public/vehicles/{id} UUID enumeration oracle on vehicle namespace
class: AUTH
asset: api.sparelabs.com/v1/public/vehicles/{id}
confidence: 40
reasoning: Same pattern as org oracle. Vehicles are core fleet business objects in mobility platform. No prior probing in knowledge base. If route exists with same validation pattern, third parallel oracle possible.
evidence_needed: 400 ValidationError on malformed input OR 404 vs 200 discrimination
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/vehicles/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/vehicles/00000000-0000-0000-0000-000000000000"`
impact: vehicle UUID enumeration oracle; fleet data exposure; enables pivot to vehicle-scoped endpoints
testability: PASSIVE (format discrimination) / HUMAN_ONLY (real-UUID 200-branch)
[PARKED] (none dropped — all three meet threshold)
[FINAL] Surviving hypotheses (ranked):
[NEXT] PROBE: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/not-a-uuid"` && `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps/00000000-0000-0000-0000-000000000000"` — test for format discrimination (400 vs 404) that would confirm parallel UUID enumeration oracle on mobileApp namespace. If malformed→400 + nil-uuid→404, oracle confirmed (mirrors org pattern exactly).
[RISK] api.sparelabs.com: **90** — multiple confirmed auth bypasses (zero-header + scheme-only), universal CORS credential reflection across all /v1, UUID oracle, data disclosure, multi-version LB flapping; highest exposure in program with 3 distinct AUTH/MISCONFIG classes accepted stable 84h+; chain amplification (CORS + auth bypass + org enum) enables full cross-origin data exfil + potential state mutation
[RISK] platform.sparelabs.com: **55** — CSP infra leak exposes production admin Vercel apps + staging + Metabase + full cloud infra (Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit); admin surface reachable but OOS third-party hosts limit direct exploitation; SPA catch-all confirmed no direct API surface
[RISK] routing.sparelabs.com: **5** — envoy 404 on ALL paths, no discoverable surface, effectively dead across 3+ days of continuous probing
[RISK] forms.sparelabs.com: **35** — JS bundle main.71d52314.js leaks staging+prod+regional infra (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, atlassian.net, ngrok.io); SPA catch-all confirmed no direct API attack surface; infra-recon value only
[RISK] web (spare.com/sparelabs.com): **10** — static Webflow marketing on Cloudflare, strict CSP `frame-ancestors 'self'`, HSTS 31536000, no internal infra leaks; minimal static-only surface
## 2026-08-10 19:38:23 UTC [routing] (model longcat)
[CHANGED] api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError). 3-way (400/404/200) → 2-way (400/200). Malformed and nil-uuid now indistinguishable.
[NEW] api.sparelabs.com/v1/public/riders/{id}: Confirmed DEAD — 404 0B for both malformed and nil-uuid. Route does not exist.
[NEW] api.sparelabs.com/v1/public/vehicles/{id}: Confirmed DEAD — 404 0B for both malformed and nil-uuid. Route does not exist.
[NEW] api.sparelabs.com/v1/public/mobileApps/{id}: Confirmed DEAD — 404 NotFoundError (with body) for both malformed and nil-uuid. No format discrimination → not an oracle.
[PRIO] api.sparelabs.com/v1/public/organizations/{id} — 5.95 (attack:7 business:7 tech:6 gate:9 cloud:2 fresh:9)
[PRIO] api.sparelabs.com/v1/public/mobileApps — 4.30 (attack:5 business:6 tech:6 gate:9 cloud:2 fresh:7)
[PRIO] api.sparelabs.com/v1/public/terms (param expansion) — 3.90 (attack:4 business:5 tech:6 gate:9 cloud:2 fresh:6)
class: AUTH
asset: api.sparelabs.com/v1/public/organizations/{id}
confidence: 45
reasoning: Singular /v1/public/organization confirmed 3-way UUID oracle (400/404/200) + auth-free + CORS. Plural /v1/public/organizations (no param) confirmed auth-free route (400 "not found"). Path-param variant /v1/public/organizations/{id} UNTESTED — if it mirrors singular validation pattern, parallel oracle exists with potentially different data exposure (org details vs existence check).
evidence_needed: 400 ValidationError on malformed input OR 404 vs 200 discrimination on nil-uuid vs valid-UUID
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/organizations/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/organizations/00000000-0000-0000-0000-000000000000"`
impact: Parallel org UUID enumeration; potential org data disclosure on 200-branch; enables pivot to authenticated org endpoints
testability: PASSIVE (format discrimination) / HUMAN_ONLY (real-UUID 200-branch)
class: MISCONFIG
asset: api.sparelabs.com/v1/public/mobileApps
confidence: 30
reasoning: /v1/public/terms?mobileAppId=<uuid> proves mobileApp is real entity with validated UUID. /v1/public/mobileApps/{id} returns 404 for all inputs (dead). Collection endpoint /v1/public/mobileApps (no param) UNTESTED — could return mobileApp list without auth if route exists.
evidence_needed: 200 response with data (proves unauthenticated list disclosure)
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps"`
impact: Unauthenticated mobileApp enumeration; mobileApp IDs enable pivot to authenticated endpoints
testability: PASSIVE
class: MISCONFIG
asset: api.sparelabs.com/v1/public/terms
confidence: 25
reasoning: Endpoint currently returns termsOfUseUrl+privacyPolicyUrl with mobileAppId or organizationId params. Additional params (fields, expand, include, format) could return richer data (full org config, feature flags, internal URLs) without auth.
evidence_needed: 200 response with additional data fields beyond terms URLs
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/terms?mobileAppId=00000000-0000-0000-0000-000000000000&fields=all"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/terms?organizationId=00000000-0000-0000-0000-000000000000&expand=true"`
impact: Additional unauthenticated data disclosure beyond terms URLs
testability: PASSIVE
[PARKED] /v1/public/mobileApps collection endpoint: Confidence 30 < 40 threshold. Low prior — most collection endpoints auth-gated, and path-param variant already confirmed dead.
[PARKED] /v1/public/terms additional parameter data disclosure: Confidence 25 < 40 threshold. Speculative param-pollution with no evidence of additional accepted params.
[NEXT] PROBE: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/organizations/not-a-uuid"` && `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/organizations/00000000-0000-0000-0000-000000000000"` — test plural org path-param variant for format discrimination (400 vs 404) that would confirm parallel UUID enumeration oracle on plural namespace. If malformed→400 + nil-uuid→404, oracle confirmed.
[LEARN] CHANGED @ api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way. nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError). Malformed and nil-uuid now indistinguishable. Auth-free ValidationError disclosure + CORS persists, but enumeration precision reduced.
[LEARN] REJECTED AUTH @ api.sparelabs.com/v1/public/riders/{id}: 404 0B for both malformed and nil-uuid — route does not exist, no surface.
[LEARN] REJECTED AUTH @ api.sparelabs.com/v1/public/vehicles/{id}: 404 0B for both malformed and nil-uuid — route does not exist, no surface.
[LEARN] REJECTED AUTH @ api.sparelabs.com/v1/public/mobileApps/{id}: 404 NotFoundError (with body) for both malformed and nil-uuid — no format discrimination, not an oracle. Route exists but returns uniform 404.
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: Scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions, 6 OOS) + ACAO+ACAC (2ms fast replica). Re-confirmed live.
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: Complete zero-header bypass STABLE — 200 + 11B `{"data":[]}` + ACAO+ACAC (659ms slow replica). Re-confirmed live.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:evil.example.com + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE on OPTIONS 204. Re-confirmed live.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Data disclosure STABLE — ?mobileAppId=nil-uuid → 200 + 137B terms URLs no-auth + CORS. Re-confirmed live.
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: STABLE dead — envoy 404 on /v1/ (0B). NO_DELTA since 2026-08-07.
[RISK] api.sparelabs.com: 90 — Multiple confirmed auth bypasses (zero-header + scheme-only), universal CORS credential reflection across all /v1, UUID oracle (degraded but alive), data disclosure, multi-version LB flapping. Highest exposure in program with 3 distinct AUTH/MISCONFIG classes accepted stable 84h+. Chain amplification (CORS + auth bypass + org enum) enables cross-origin data exfil + potential state mutation.
[RISK] platform.sparelabs.com: 55 — CSP infra leak exposes production admin Vercel apps + staging + Metabase + full cloud infra (Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit). Admin surface reachable but OOS third-party hosts limit direct exploitation. SPA catch-all confirmed no direct API surface.
[RISK] routing.sparelabs.com: 5 — envoy 404 on ALL paths, no discoverable surface, effectively dead across 3+ days of continuous probing.
[RISK] forms.sparelabs.com: 35 — JS bundle main.71d52314.js leaks staging+prod+regional infra (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, atlassian.net, ngrok.io). SPA catch-all confirmed no direct API attack surface. Infra-recon value only.
[RISK] web (spare.com/sparelabs.com): 10 — Static Webflow marketing on Cloudflare, strict CSP `frame-ancestors 'self'`, HSTS 31536000, no internal infra leaks. Minimal static-only surface.
## 2026-08-10 20:20:57 UTC [routing] (model longcat)
[PRIO] api.sparelabs.com/v1/public/organizations/{id} — 5.95 (attack:7 business:7 tech:6 gate:9 cloud:2 fresh:9)
[PRIO] api.sparelabs.com/v1/public/mobileApps — 4.30 (attack:5 business:6 tech:6 gate:9 cloud:2 fresh:7)
[PRIO] api.sparelabs.com/v1/public/terms (param expansion) — 3.90 (attack:4 business:5 tech:6 gate:9 cloud:2 fresh:6)
[HYP] Plural org UUID enumeration oracle on /v1/public/organizations/{id}
class: AUTH
asset: api.sparelabs.com/v1/public/organizations/{id}
confidence: 45
reasoning: Singular /v1/public/organization confirmed 3-way UUID oracle (400/404/200) + auth-free + CORS. Plural /v1/public/organizations (no param) confirmed auth-free route (400 "not found"). Path-param variant /v1/public/organizations/{id} UNTESTED — if it mirrors singular validation pattern, parallel oracle exists with potentially different data exposure (org details vs existence check).
evidence_needed: 400 ValidationError on malformed input OR 404 vs 200 discrimination on nil-uuid vs valid-UUID
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/organizations/not-a-uuid"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/organizations/00000000-0000-0000-0000-000000000000"`
impact: Parallel org UUID enumeration; potential org data disclosure on 200-branch; enables pivot to authenticated org endpoints
testability: PASSIVE (format discrimination) / HUMAN_ONLY (real-UUID 200-branch)
[HYP] Unauthenticated mobileApp collection disclosure
class: MISCONFIG
asset: api.sparelabs.com/v1/public/mobileApps
confidence: 30
reasoning: /v1/public/terms?mobileAppId=<uuid> proves mobileApp is real entity with validated UUID. /v1/public/mobileApps/{id} returns 404 for all inputs (dead). Collection endpoint /v1/public/mobileApps (no param) UNTESTED — could return mobileApp list without auth if route exists.
evidence_needed: 200 response with data (proves unauthenticated list disclosure)
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/mobileApps"`
impact: Unauthenticated mobileApp enumeration; mobileApp IDs enable pivot to authenticated endpoints
testability: PASSIVE
[HYP] Terms endpoint parameter expansion data disclosure
class: MISCONFIG
asset: api.sparelabs.com/v1/public/terms
confidence: 25
reasoning: Endpoint currently returns termsOfUseUrl+privacyPolicyUrl with mobileAppId or organizationId params. Additional params (fields, expand, include, format) could return richer data (full org config, feature flags, internal URLs) without auth.
evidence_needed: 200 response with additional data fields beyond terms URLs
verify_steps: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/terms?mobileAppId=00000000-0000-0000-0000-000000000000&fields=all"` ; `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/terms?organizationId=00000000-0000-0000-0000-000000000000&expand=true"`
impact: Additional unauthenticated data disclosure beyond terms URLs
testability: PASSIVE
[PARKED] Unauthenticated mobileApp collection disclosure: Confidence 30 < 40 threshold. Low prior — most collection endpoints auth-gated, and path-param variant already confirmed dead.
[PARKED] Terms endpoint parameter expansion data disclosure: Confidence 25 < 40 threshold. Speculative param-pollution with no evidence of additional accepted params.
[FINAL] Surviving hypotheses (ranked):
[NEXT] PROBE: `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/organizations/not-a-uuid"` && `curl -s -w "\nHTTP:%{http_code}" "https://api.sparelabs.com/v1/public/organizations/00000000-0000-0000-0000-000000000000"` — test plural org path-param variant for format discrimination (400 vs 404) that would confirm parallel UUID enumeration oracle on plural namespace. If malformed→400 + nil-uuid→404, oracle confirmed.
[LEARN] CHANGED @ api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way. nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError). Malformed and nil-uuid now indistinguishable. Auth-free ValidationError disclosure + CORS persists, but enumeration precision reduced.
[LEARN] REJECTED AUTH @ api.sparelabs.com/v1/public/riders/{id}: 404 0B for both malformed and nil-uuid — route does not exist, no surface.
[LEARN] REJECTED AUTH @ api.sparelabs.com/v1/public/vehicles/{id}: 404 0B for both malformed and nil-uuid — route does not exist, no surface.
[LEARN] REJECTED AUTH @ api.sparelabs.com/v1/public/mobileApps/{id}: 404 NotFoundError (with body) for both malformed and nil-uuid — no format discrimination, not an oracle. Route exists but returns uniform 404.
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: Scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions, 6 OOS) + ACAO+ACAC (2ms fast replica). Re-confirmed live.
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: Complete zero-header bypass STABLE — 200 + 11B `{"data":[]}` + ACAO+ACAC (659ms slow replica). Re-confirmed live.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:evil.example.com + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE on OPTIONS 204. Re-confirmed live.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Data disclosure STABLE — ?mobileAppId=nil-uuid → 200 + 137B terms URLs no-auth + CORS. Re-confirmed live.
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: STABLE dead — envoy 404 on /v1/ (0B). NO_DELTA since 2026-08-07.
[RISK] api.sparelabs.com: 90 — Multiple confirmed auth bypasses (zero-header + scheme-only), universal CORS credential reflection across all /v1, UUID oracle (degraded but alive), data disclosure, multi-version LB flapping. Highest exposure in program with 3 distinct AUTH/MISCONFIG classes accepted stable 84h+. Chain amplification (CORS + auth bypass + org enum) enables cross-origin data exfil + potential state mutation.
[RISK] platform.sparelabs.com: 55 — CSP infra leak exposes production admin Vercel apps + staging + Metabase + full cloud infra (Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox/Pusher/Twilio/LiveKit). Admin surface reachable but OOS third-party hosts limit direct exploitation. SPA catch-all confirmed no direct API surface.
[RISK] routing.sparelabs.com: 5 — envoy 404 on ALL paths, no discoverable surface, effectively dead across 3+ days of continuous probing.
[RISK] forms.sparelabs.com: 35 — JS bundle main.71d52314.js leaks staging+prod+regional infra (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, atlassian.net, ngrok.io). SPA catch-all confirmed no direct API attack surface. Infra-recon value only.
[RISK] web (spare.com/sparelabs.com): 10 — Static Webflow marketing on Cloudflare, strict CSP `frame-ancestors 'self'`, HSTS 31536000, no internal infra leaks. Minimal static-only surface.
## 2026-08-10 21:07:59 UTC [routing] (model longcat)
## 2026-08-10 21:57:40 UTC [routing] (model longcat)
