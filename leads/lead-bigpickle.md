# LEADS bigpickle (seed)
- SEED: no model output yet; pipeline starts on first run.
## 2026-08-07 18:31:52 UTC [api] (model bigpickle)
[HYP] Unauthenticated /v1/ endpoint surface on API gateway
class: MISCONFIG
asset: api.sparelabs.com/v1/**
confidence: 55
reasoning: Live probe shows /v1/journeys returns explicit 401 InvalidTokenError with no Authorization header; bundles enumerate /v1/journeyNotifications/*. Single-header gate observed on one route only; enforcement may be inconsistent across the large v1 surface.
evidence_needed: a /v1/* route returning 2xx without auth, or 500/stacktrace instead of 401.
verify_steps: PASSIVE. GET (no Authorization) /v1/config, /v1/health, /v1/journeyNotifications + /v1/nonexistent (control); classify 401/200/404/500; ≤1 rps, 4 requests.
impact: unauthenticated read of operational/journey data if any route misses the guard; medium-high.
testability: PASSIVE
[HYP] MFE-manifest / dynamic org-host client-side XSS or config injection
class: XSS
asset: platform.sparelabs.com
confidence: 50
reasoning: index.html fetches "ALL MFE manifest URLs early (production, staging, localhost)" into window.__MFE_MANIFESTS__; org settings expose user-influenced fields (organizationApiHost, organizationRoutingHost). Dynamic remote-host selection + client bundle loading is a classic DOM-XSS/URL-injection surface. Affinity cookie lacks Secure (minor).
evidence_needed: manifest URL reaching a script/DOM sink without allowlist, or a postMessage handler injecting HTML.
verify_steps: PASSIVE static review of captured assets/index-DHUgT6Ph.js (6.0MB): __MFE_MANIFESTS__ consumer, message listeners, innerHTML/dangerouslySetInnerHTML sinks, host allowlist. No live payloads.
impact: client-side XSS in admin console, token theft; high.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: Engage portal is a public (auth-less shell) SPA calling the same /v1 Bearer API; portal routes typically embed journey/booking IDs in URLs. API guards per route; cross-tenant object access depends on ID authorization, not just authentication.
evidence_needed: an ID in a portal URL whose resource is returned for a token not owning it.
verify_steps: PASSIVE first (extract id-params + ID shape from forms bundle), then AUTH_HELPED: get a test token via program channel (no self-signup per rules) and test cross-tenant read on a low-risk endpoint.
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[NEXT] PROBE: bound no-auth GET sweep on api.sparelabs.com: /v1/config, /v1/health, /v1/journeyNotifications + /v1/nonexistent control, classify 401/200/404/500, ≤1 rps.
## 2026-08-07 18:47:54 UTC [api] (model bigpickle)
[HYP] API gateway reflects any Origin with credentials — CORS misconfig
class: MISCONFIG
asset: api.sparelabs.com/v1/journeys
confidence: 50
reasoning: Preflight with Origin https://evil.example.com returned 204 with access-control-allow-origin echoing the origin + allow-credentials true + authorization allowed in one hop (envoy/Google LB). This is classic reflect-any-origin CORS; needs checking whether it's gateway-wide (all /v1/*) and present on actual GET responses.
evidence_needed: a GET (not just preflight) on an existing /v1 route returning access-control-allow-origin echoing attacker origin with credentials true; or a route failing to reflect (showing inconsistent enforcement).
verify_steps: PASSIVE. GET (no Authorization) /v1/journeys with Origin: https://evil.example.com and check ACAO/ACAC; repeat Origin on /v1/organizations; repeat on a 404 path (gateway-wide?) — ≤3 requests, ≤1 rps.
impact: if any victim session can be made to carry credentials, cross-origin read of API responses (Bearer tokens are not auto-attached, so needs cookie/JWT-in-cookie auth on some route or client-side token holder); medium.
testability: PASSIVE
[HYP] Unauthenticated /v1/ route among large auth-gated surface (route oracle assist)
class: AUTH
asset: api.sparelabs.com/v1/**
confidence: 45
reasoning: Route oracle proves many real /v1 routes exist (journeys, users, organizations, vehicles) all behind one guard; a 9-path no-auth sweep found no 2xx, but the surface is far larger than sampled. Custom InvalidTokenError suggests hand-rolled guard that may be inconsistent across routes.
evidence_needed: any /v1/* route returning 200/2xx (or 500/stacktrace) without Authorization.
verify_steps: PASSIVE. Use 401-vs-404 oracle to enumerate a wider /v1 route set from bundle/OpenAPI hints, then single no-auth GET on each candidate — ≤1 rps, no payloads. No more than ~10 requests this cycle.
impact: unauthenticated read of journey/org/vehicle data if a route misses the guard; medium-high.
testability: PASSIVE
[HYP] MFE-manifest / dynamic org-host client-side config injection
class: XSS
asset: platform.sparelabs.com
confidence: 50
reasoning: index.html loads production/staging/localhost manifest URLs into window.__MFE_MANIFESTS__; org settings expose user-influenced host fields (organizationApiHost, organizationRoutingHost). Dynamic remote-host selection is a classic DOM-XSS/URL-injection surface (from prior bundle analysis).
evidence_needed: a manifest URL reaching a script/DOM sink without allowlist, or postMessage handler injecting HTML (static review of captured 6.0MB bundle).
verify_steps: PASSIVE static review of index-DHUgT6Ph.js: __MFE_MANIFESTS__ consumers, message listeners, innerHTML/dangerouslySetInnerHTML sinks, host allowlist. No live payloads.
impact: client-side XSS in admin console, token theft; high.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: Public auth-less Engage SPA calls the same /v1 Bearer API; portal routes embed journey/booking IDs; per-route guards exist (401 confirmed) but object-level authorization is unproven.
evidence_needed: an ID whose resource is returned for a token that doesn't own it.
verify_steps: PASSIVE first (extract id-params + ID shape from forms bundle), then AUTH_HELPED: obtain a test token via program channel (no self-signup per rules) and test cross-tenant read on a low-risk endpoint.
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
## 2026-08-07 19:13:57 UTC [api] (model bigpickle)
[HYP] API reflects any Origin with credentials on live auth-gated routes
class: MISCONFIG
asset: api.sparelabs.com/v1/journeys, /v1/organizations
confidence: 60
reasoning: GET (no auth) with `Origin: https://evil.example.com` on two real routes returns 401 but with `access-control-allow-origin: evil.example.com`, `access-control-allow-credentials: true`, `vary: Origin`. Same Origin on a 404 path returns no ACAO → reflection is applied to the real API surface only, consistent with a route-level CORS middleware misconfig.
evidence_needed: a cookie-based session on any /v1 route (Bearer-only observed, no Set-Cookie at edge), or `access-control-allow-methods/headers` preflight that would let a cross-origin page drive authenticated reads.
verify_steps: PASSIVE. OPTIONS /v1/journeys with `Origin: https://evil.example.com` + `Access-Control-Request-Headers: authorization` and capture ACAM/ACAH/ACAC (1 req). If a cookie session is ever found → AUTH_HELPED cross-origin read test.
impact: cross-origin read of API responses only if credentials can be auto-attached; with Bearer-only auth the standalone impact is limited → medium (reportable misconfig per OWASP A05:2021; escalates if any cookie-auth route appears).
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: Public auth-less Engage SPA calls the same /v1 Bearer API (hosts leaked in `main.6ed467ae.js`); per-route 401 guards confirmed, but object-level authorization on ID-keyed resources is unproven; portal routes typically embed journey/booking IDs in URLs.
evidence_needed: an ID in a portal URL whose resource returns data for a token that doesn't own it.
verify_steps: PASSIVE first (extract id params + UUID shape from forms bundle), then AUTH_HELPED: obtain test token via program channel (no self-signup) and test cross-tenant read on a low-risk endpoint.
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[HYP] MFE-manifest / dynamic org-host client-side config injection
class: XSS
asset: platform.sparelabs.com
confidence: 50
reasoning: index.html loads production/staging/localhost manifest URLs into `window.__MFE_MANIFESTS__`; org settings expose user-influenced hosts (organizationApiHost, organizationRoutingHost); dynamic remote-host selection is a classic DOM/URL-injection surface (prior bundle analysis).
evidence_needed: a manifest URL reaching a script/DOM sink without allowlist, or a postMessage handler injecting HTML (static review of captured 6.0MB `index-DHUgT6Ph.js`).
verify_steps: PASSIVE static review: `__MFE_MANIFESTS__` consumers, message listeners, innerHTML/dangerouslySetInnerHTML sinks, host allowlist. No live payloads.
impact: client-side XSS in admin console, token theft; high.
testability: PASSIVE
## 2026-08-07 20:01:47 UTC [api] (model bigpickle)
[HYP] CORS reflect-any-origin with credentials on entire /v1 API surface (confirmed) — escalate if any auto-attached credential exists
class: MISCONFIG
asset: api.sparelabs.com/v1/**
confidence: 80
reasoning: 4 live probes (2×401, 2×200) all echo attacker Origin with ACAC true; OPTIONS permits all methods + authorization/content-type; 404 paths don't reflect (API-scoped middleware). No Set-Cookie on any probe → Bearer-only today.
evidence_needed: any /v1 route issuing Set-Cookie/cookie session, or a client holding the token where the browser auto-attaches → cross-origin credentialed read/mutation becomes real.
verify_steps: PASSIVE. Continue watching for Set-Cookie across the wider /v1 enum; if a cookie session appears → AUTH_HELPED cross-origin read test from a test Origin.
impact: cross-origin read of journey/org data + mutation (PUT/PATCH/DELETE allowed) if credentials auto-attach; otherwise standalone A05:2021 misconfig that force-amplifies any future XSS; medium.
testability: PASSIVE
[HYP] MFE-manifest / dynamic org-host injection in platform SPA
class: XSS
asset: platform.sparelabs.com
confidence: 50
reasoning: index.html feeds production/staging/localhost manifest URLs into window.__MFE_MANIFESTS__; org settings expose user-influenced host fields (organizationApiHost, organizationRoutingHost); dynamic remote-host selection is a DOM/URL-injection surface. Consumer logic is in captured index-DHUgT6Ph.js.
evidence_needed: a manifest URL reaching a script/DOM sink without allowlist, or a postMessage handler injecting HTML.
verify_steps: PASSIVE static review of bundle: __MFE_MANIFESTS__ consumers, message listeners, innerHTML/dangerouslySetInnerHTML sinks, host allowlist. No live payloads.
impact: client-side XSS in admin console, token theft; high.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls the same /v1 Bearer API (hosts in main.6ed467ae.js); per-route 401 guards confirmed but object-level authorization on ID-keyed resources unproven; portal routes typically embed journey/booking IDs.
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: PASSIVE extract id params + UUID shape from forms bundle; then AUTH_HELPED cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[NEXT] PROBE: GET https://api.sparelabs.com/v1/public/terms?organizationId=00000000-0000-0000-0000-000000000000 and capture the response body — the new 200 contradicts the earlier 400/404-only note; body determines whether the unauth public surface returns org/legal PII or static text (1 request).
## 2026-08-07 20:53:07 UTC [api] (model bigpickle)
## 2026-08-07 21:47:17 UTC [api] (model bigpickle)
## 2026-08-07 22:08:11 UTC [api] (model bigpickle)
[HYP] Auth-gate flapping on /v1/global/organizations (and possibly siblings) — fail-open window for unauth data disclosure
class: AUTH
asset: api.sparelabs.com/v1/global/organizations (+ broader /v1)
confidence: 50
reasoning: Route returned 401 at 20:57 UTC but 200 with `{"data":[]}` at 21:30, 21:47 and 22:07 (3/4 samples data-bearing); other auth-gated routes (/v1/journeys/requests) consistently 401. Inconsistent gate suggests per-route middleware intermittently passes or a stub handler. No Set-Cookie on any probe → not a session artifact.
evidence_needed: an auth-gated route returning 200 with data-bearing body (not just empty `data:[]`) while unauthenticated, reproducibly.
verify_steps: PASSIVE. Interval sample GET /v1/global/organizations and /v1/journeys/requests 5× at 30s spacing, record status+body (≤1 rps). Then widen to other auth-gated /v1 routes the same way.
impact: unauthenticated read of org/journey data if a data-bearing 200 is caught; low-frequency so attacker-dependent; medium.
testability: PASSIVE
[HYP] MFE-manifest / dynamic org-host injection in platform SPA
class: XSS
asset: platform.sparelabs.com
confidence: 50
reasoning: index.html feeds production/staging/localhost manifest URLs into `window.__MFE_MANIFESTS__`; org settings expose user-influenced host fields (organizationApiHost, organizationRoutingHost); dynamic remote-host selection is a classic DOM/URL-injection surface. Consumer logic is in captured index-DHUgT6Ph.js.
evidence_needed: a manifest URL reaching a script/DOM sink without allowlist, or a postMessage handler injecting HTML.
verify_steps: PASSIVE static review of captured bundle: `__MFE_MANIFESTS__` consumers, message listeners, innerHTML/dangerouslySetInnerHTML sinks, host allowlist. No live payloads.
impact: client-side XSS in admin console, token theft; high.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls the same /v1 Bearer API (hosts in main.71d52314.js); per-route 401 guards confirmed but object-level authorization on ID-keyed resources unproven; portal routes typically embed journey/booking IDs.
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: PASSIVE first (extract id params + UUID shape from current forms bundle), then AUTH_HELPED: cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
## 2026-08-07 22:53:10 UTC [api] (model bigpickle)
[CHANGED] api.sparelabs.com /v1/global/organizations: auth fail-open is now STABLE not flapping — HTTP 200 `{"data":[]}` on all 6 samples across ~2h including ?limit=&offset= variants (params ignored, 11B hardcoded); control /v1/journeys/requests stays 401.
[NEW] api.sparelabs.com /v1/** error envelope leaks `metadata.correlationId` (UUID) on every 401/404 — request-tracking artifact, no independent value.
[NEW] forms.sparelabs.com/ now shows `x-frame-options: DENY` while api/platform show SAMEORIGIN — inconsistent clickjacking posture, low value.
[PRIO] api.sparelabs.com/v1/**: score 7.05 (attack 8, business 8, tech 8, gate 5, cloud 6, fresh 5)
[PRIO] platform.sparelabs.com: score 6.30 (attack 6, business 7, tech 8, gate 5, cloud 6, fresh 5)
[PRIO] forms.sparelabs.com: score 6.05 (attack 5, business 6, tech 6, gate 8, cloud 7, fresh 5)
[PRIO] spare.com apex: score 3.1 — Cloudflare marketing site only
[HYP] Route-level auth omission on /v1/global/* (confirmed fail-open, data-bearing unproven)
class: AUTH
asset: api.sparelabs.com/v1/global/organizations (+ /v1/global/* namespace)
confidence: 55
reasoning: 6 consecutive unauth 200s (~2h, incl ?limit=100&offset=0) with hardcoded 11B `{"data":[]}` while /v1/journeys/requests is a stable 401; no Set-Cookie → middleware gap on this route, not session artifact. Sits OUTSIDE /v1/public/*, so the 200 is inconsistent with the intended auth boundary.
evidence_needed: a non-empty 200 body from this route or a sibling /v1/global/* route unauth.
verify_steps: PASSIVE. Use 401-vs-200 differential vs /v1/journeys/requests control to probe likely siblings (GET /v1/global/settings, /v1/global/regions, spaced ≥1.2s); re-sample /v1/global/organizations weekly for a data-bearing body. No live payloads.
impact: unauth read of org/global config; currently empty payload caps severity at medium; A05 route misconfig that force-amplifies the confirmed reflect-any-origin CORS.
testability: PASSIVE
[HYP] MFE-manifest / dynamic org-host injection in platform SPA
class: XSS
asset: platform.sparelabs.com
confidence: 50
reasoning: index.html feeds prod/staging/localhost manifest URLs into window.__MFE_MANIFESTS__; org settings expose user-influenced host fields; dynamic remote-host selection is a DOM-injection surface. Consumer logic in index-DHUgT6Ph.js.
evidence_needed: a manifest URL reaching a script/DOM sink without allowlist, or a postMessage handler injecting HTML.
verify_steps: PASSIVE static review of captured bundle: __MFE_MANIFESTS__ consumers, message listeners, innerHTML/dangerouslySetInnerHTML sinks, host allowlist. No live payloads.
impact: client-side XSS in admin console, token theft; high.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls the same /v1 Bearer API; per-route 401 guards confirmed but object-level authorization on ID-keyed resources unproven. Bundle unchanged this round (main.71d52314.js) — ID params/route shape already extracted.
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: AUTH_HELPED: cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[FINAL] 1) api /v1/global/* route-auth omission (55, PASSIVE) 2) platform MFE-manifest XSS (50, PASSIVE) 3) forms /v1 IDOR (45, AUTH_HELPED)
[NEXT] PROBE: GET https://api.sparelabs.com/v1/global/settings and /v1/global/regions (2 req, spaced ≥1.2s, ≤1 rps) — 401-vs-200 differential against /v1/journeys/requests as auth-gated control; a 200 with non-empty body = data-bearing fail-open and immediately escalates the top hypothesis to ACCEPTED.
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: fail-open now STABLE — 200 ×6 across ~2h incl. pagination variants (params ignored, hardcoded `{"data":[]}`), control route stable 401 → route-level auth omission confirmed as pattern, not flapping; severity remains capped while payload empty.
[LEARN] REJECTED BUSLOGIC @ api.sparelabs.com: CORS reflect-any-origin+credentials re-confirmed on all /v1 (401, 404, and 200 paths) — uniformly applied API-scoped middleware, not path-conditional.
[RISK] api.sparelabs.com: 72 — reflect-any-origin CORS+creds on all /v1, unauth data-on-401 (public/terms), UUID enumeration oracle, stable route-level auth omission (/v1/global/organizations); all passive-confirmed.
[RISK] platform.sparelabs.com: 48 — MFE shell leaks staging admin apps + Metabase; DOM-injection surface unproven.
[RISK] routing.sparelabs.com: 12 — surface dead (all paths 404 behind envoy), gateway only.
[RISK] forms.sparelabs.com: 42 — bundle leaks staging API hosts + JIRA + ngrok tunnel; SPA catch-all; shares /v1 API (IDOR unproven).
[RISK] web (spare.com/sparelabs.com): 18 — Cloudflare-fronted marketing site, HSTS max-age=0, no exposed surface.
## 2026-08-07 23:26:24 UTC [api] (model bigpickle)
## 2026-08-07 23:58:51 UTC [api] (model bigpickle)
[HYP] Organizations controller-wide auth omission on /v1/global/organizations
class: AUTH
asset: api.sparelabs.com/v1/global/organizations (+ subroutes)
confidence: 75
reasoning: 6 live probes confirm no Authorization header required on list(200 empty), {uuid}(404), key/{key}(404), {uuid}/mobileApps(400), zones/centroid(400); siblings in the same namespace (users/mobileApps/settings/regions) correctly 401/400 — auth middleware omitted on the entire organizations controller, not one route.
evidence_needed: a data-bearing 200 body from any /v1/global/organizations subroute (org config, zones) without auth.
verify_steps: PASSIVE. Enumerate remaining subroutes from platform bundle (index-BIOrSDj1.js: `organizations/zones/centroid`, `organizations/key/`), probe each spaced ≥1.2s; retest list route weekly for non-empty body. No live payloads.
impact: unauth read/confirm of org registry (existence oracle by UUID+key), org config if any subroute returns data; force-amplified by reflect-any-origin CORS+credentials; currently data-light, medium.
testability: PASSIVE
[HYP] Org-settings host injection into platform API client
class: XSS
asset: platform.sparelabs.com
confidence: 35
reasoning: bundle shows `organizationApiHost`/`organizationRoutingHost` (from org settings via `global.getOrganization`) drive client-side fetch base URLs only; no sink found. Manifest list hardcoded.
evidence_needed: a settings host value reaching a script/DOM sink, or unvalidated host accepted by the org-settings API.
verify_steps: PASSIVE (sink scan of platform bundle complete — negative) then AUTH_HELPED: inspect org-settings write path for URL validation with an authorized token.
impact: credential confusion / token exfil if host is attacker-set; currently unproven.
testability: AUTH_HELPED
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls the same /v1 Bearer API; bundle now shows `/v1/journeyNotifications/*` POST push endpoints; object-level authorization on ID-keyed resources unproven.
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: AUTH_HELPED: cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
## 2026-08-08 01:01:31 UTC [api] (model bigpickle)
[HYP] Unauthenticated write exposure on /v1/global/organizations controller
class: AUTH
asset: api.sparelabs.com/v1/global/organizations (+ subroutes)
confidence: 70
reasoning: live differential proves list(200)+subroutes(400/404) answer without `InvalidTokenError` while settings(401)/regions(400)/journeys(401) enforce auth → omission is controller-scoped, persistent; preflight on the same auth-free controller advertises PUT/PATCH/POST/DELETE + allow-headers authorization with any-origin credential reflect.
evidence_needed: a write route (POST/PUT/PATCH/DELETE) on the controller that answers without Authorization (404/405/400 but no InvalidTokenError), or a data-bearing GET from any subroute.
verify_steps: PASSIVE — OPTIONS preflights (Origin: https://evil.example, ACRM: POST, ACRH: authorization) + GET differential on /v1/global/organizations/key/x, /{00000000-0000-0000-0000-000000000000}, /zones, spaced ≥1.2s vs InvalidTokenError control; AUTH_HELPED write validation only with authorized token.
impact: if any write route is auth-free, unauthenticated cross-origin org-data modification via reflected CORS+credentials; currently data-light, medium-high.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls the same /v1 Bearer API with ID-keyed paths; route-level auth 401s confirmed but object-level authorization on ID-keyed resources unproven; bundle unchanged (main.71d52314.js) so route shapes already extracted.
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: AUTH_HELPED: cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[NEXT] PROBE: OPTIONS preflight (Origin: https://evil.example, ACRM: POST, ACRH: authorization) on `https://api.sparelabs.com/v1/global/organizations/key/x` → then GET same path; repeat on `/zones`; each spaced ≥1.2s (≤1 rps). A 204-with-write-methods or a 400/404 that is NOT `InvalidTokenError` maps a write-enabled/behaving subroute inside the auth-free controller → escalate hypothesis 1.
## 2026-08-08 03:00:00 UTC [api] (model bigpickle)
[HYP] Organizations controller-wide auth omission confirmed via bracketed differential
class: AUTH
asset: api.sparelabs.com/v1/global/organizations (+ key/, {uuid}, zones, mobileApps subroutes)
confidence: 85
reasoning: 6 subroutes answer without Authorization (list 200 `{"data":[]}`, key/x 404, {uuid} 404, {uuid}/mobileApps 400, {uuid}/zones 400, zones 400) — zero InvalidTokenError; sibling /v1/global/settings (401) and /v1/global/regions (400 "Authorization header required") enforce → omission is controller-scoped, not flapping.
evidence_needed: a data-bearing 200 from any subroute (org config/zones payload) to lift the empty-payload cap; or a write route answering without auth.
verify_steps: PASSIVE — weekly retest list route for non-empty body; sweep `{uuid}/zones`, `key/{key}` variants with valid-format UUIDs spaced ≥1.2s; do NOT send POST until AUTH_HELPED token context.
impact: unauth read/confirm of org registry (UUID+key existence oracle) + any subroute data; amplified by reflect-any-origin CORS+credentials; currently data-light, medium.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls same /v1 Bearer API with ID-keyed paths; route-level 401s confirmed but object-level authorization on ID-keyed resources unproven.
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: AUTH_HELPED: cross-tenant read on a low-risk endpoint using program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
