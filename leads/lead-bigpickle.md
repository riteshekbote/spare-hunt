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
## 2026-08-08 04:08:26 UTC [api] (model bigpickle)
[NEW] api.sparelabs.com/v1/global/organizations/key/{anything} → 404 NotFoundError "Organization was not found" WITHOUT auth, no format validation (probed: `not-a-uuid`, `x`, all-zero UUID → byte-identical 404) — key subroute wired into the auth-free org resolver, but NO oracle discrimination
[NEW] api.sparelabs.com/v1/global/organizations/zones/centroid (platform-bundle-derived) → 400 ValidationError "not found" WITHOUT auth — not a live route, yet bypasses the auth gate → omission is controller-scoped, extends to bundle-derived subroutes
[CHANGED] /v1/global/organizations list still 200 hardcoded `{"data":[]}` (params ignored) — empty-payload cap persists; no data-bearing 200 found
[CHANGED] Control /v1/global/settings → 401 InvalidTokenError stable; Origin-reflect + credentials + envoy re-confirmed on all 8 probes this session
[PRIO] api.sparelabs.com/v1/global/organizations: 6.65 (attack7 business7 tech5 gate10 cloud4 fresh5)
[PRIO] forms.sparelabs.com: 6.10 (attack5 business8 tech6 gate7 cloud4 fresh5)
[PRIO] platform.sparelabs.com: 6.05 (attack5 business7 tech7 gate6 cloud5 fresh6)
[HYP] Write-method exposure on auth-free organizations controller
class: AUTH
asset: api.sparelabs.com/v1/global/organizations (+ key/, zones/ subroutes)
confidence: 60
reasoning: controller answers GET (200/400/404) with zero InvalidTokenError while /v1/global/settings and /v1/generic/regions enforce; path-specific OPTIONS 204 this session advertises PUT,PATCH,POST,DELETE + allow-headers authorization on the SAME auth-free controller.
evidence_needed: a write route (PUT/PATCH/POST) responding with body-validation/404 error — NOT InvalidTokenError — proving auth-free write handling without mutation; or data-bearing 200 from any subroute.
verify_steps: AUTH_HELPED: with authorized token, PUT/PATCH invalid body to /v1/global/organizations/{00000000-0000-0000-0000-000000000000} and /key/{x} expecting 400 ValidationError vs 401; PASSIVE weekly: retest list route for non-empty body.
impact: unauth cross-origin org registry/config modification via reflect-any-origin CORS+credentials if any write route is auth-free; currently data-light, medium.
testability: AUTH_HELPED
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls same /v1 Bearer API with ID-keyed paths; route-level 401s confirmed but object-level authorization on ID-keyed resources unproven; bundle unchanged (main.71d52314.js).
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: AUTH_HELPED: cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[HYP] Org-settings host injection into platform API client
class: XSS
asset: platform.sparelabs.com
confidence: 35
reasoning: bundle shows organizationApiHost/organizationRoutingHost (org settings) drive client-side fetch base URLs only; sink scan negative; manifest list hardcoded.
evidence_needed: a settings host value reaching a script/DOM sink, or unvalidated host accepted by org-settings API.
verify_steps: PASSIVE (sink scan complete — negative) then AUTH_HELPED inspect org-settings write path URL validation.
impact: credential confusion / token exfil if host attacker-set; currently unproven.
testability: AUTH_HELPED
[PARKED] Org-settings host injection: confidence 35 < 40 and sink scan negative — no new evidence this session.
[FINAL] 1) Write-method exposure on auth-free organizations controller (AUTH, 60) 2) Engage portal IDOR (IDOR, 45)
[NEXT] HUMAN: With an authorized Bearer token, PUT invalid-body JSON to `https://api.sparelabs.com/v1/global/organizations/00000000-0000-0000-0000-000000000000` and `/key/x`; 400 ValidationError (vs 401 InvalidTokenError) proves auth-free write handling on the controller — discriminative, no mutation possible with invalid body. Passive weekly retest of list route for non-empty body remains in parallel.
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: controller-scoped auth omission re-confirmed live — list 200 `{"data":[]}`, key/{any} 404, zones/centroid 400, all without InvalidTokenError; /v1/global/settings control 401 stable; path-specific OPTIONS 204 advertises PUT/PATCH/POST/DELETE.
[LEARN] REJECTED BUSLOGIC @ api.sparelabs.com/v1/global/organizations/key/: NOT an enumeration oracle — every key string returns identical 404 NotFoundError (no format discrimination), only the /v1/public/organization UUID oracle discriminates.
[LEARN] REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/zones/centroid: bundle-derived path is not a live route (400 "not found") — its auth-free 400 still evidences controller-wide omission.
[RISK] api.sparelabs.com: 62 — org-registry controller-scoped auth omission with any-origin credential-reflecting CORS, but payloads empty, no write path proven, stable over 24h
[RISK] platform.sparelabs.com: 45 — CSP + /login MFE manifest leak prod+staging admin Vercel apps + Metabase; host-injection sink unproven
[RISK] routing.sparelabs.com: 5 — envoy 404 across all surfaces, no delta
[RISK] forms.sparelabs.com: 35 — bundle leaks staging/prod API hosts + JIRA/ngrok; SPA catch-all; x-frame-options DENY; IDOR unproven
[RISK] web (spare.com/sparelabs.com): 20 — apex 200, www 301 (excluded); minimal first-party surface
## 2026-08-08 05:07:41 UTC [api] (model bigpickle)
## 2026-08-08 05:53:15 UTC [api] (model bigpickle)
## 2026-08-08 06:38:18 UTC [api] (model bigpickle)
[HYP] Data-bearing auth-free routes on /v1/global controller beyond /regions
class: AUTH
asset: api.sparelabs.com/v1/global/*
confidence: 70
reasoning: /v1/global/regions returns 200+725B live data with garbage Bearer (presence-only gate, validity never checked); siblings settings/routes/zones/vehicles enforce 401; regions/{id}, organizations/* all auth-free. Controller-scoped omission now proven data-capable. Note: regions may be intended as a public bootstrap (pre-auth region→API discovery) — but then requiring the header at all is itself the misconfig; either reading, the gate is broken, not validated.
evidence_needed: another /v1/global/* (or regions/{valid id} / org-scoped param) returning 200 with non-static payload under header-presence auth.
verify_steps: PASSIVE — GET /v1/global/{countries,currencies,fares,tariffs,settings/regions} with `Authorization: Bearer x` + Origin, spaced ≥1.2s; log status vs body-size; then re-run /v1/global/regions with org-scoped params for filtering behavior.
impact: unauthenticated cross-origin read of platform config/org data via reflect-any-origin CORS+credentials; region list itself low-sensitivity, but class now data-capable — medium.
testability: PASSIVE
[HYP] Module-federation manifest enumeration → new first-party MFE bundles → new /v1 routes
class: MISCONFIG
asset: platform.sparelabs.com/login
confidence: 50
reasoning: /login HTML loads MFE remote manifests already leaking prod+staging admin Vercel apps + Metabase + 20 infra hosts; same mechanism embeds more entrypoints; prior manifest-derived path (zones/centroid) proved bundle→/v1 mapping.
evidence_needed: a manifest-derived /v1 path on in-scope api that is live (non-404) or data-bearing auth-free.
verify_steps: PASSIVE — GET /login + each remote manifest URL (≤1rps), extract entrypoints, fetch chunks, grep /v1/ + host literals; cross-check hits against api.sparelabs.com with GET.
impact: expands in-scope API surface; may expose new auth-free/data-bearing routes; medium.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls same /v1 Bearer API with ID-keyed paths; route-level 401s confirmed but object-level authorization on ID-keyed resources unproven; bundle unchanged (main.71d52314.js).
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: AUTH_HELPED: cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[NEXT] PROBE: GET `/v1/global/{countries,currencies,fares,tariffs,zones,settings/regions}` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced ≥1.2s, record status + body size; any 200 with non-empty body beyond 725B-region baseline = new data-bearing auth-free route; also re-run `/v1/global/regions` with valid-format `organizationId` to test filtering.
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: auth-free DATA-BEARING — 200 + 725B region registry (CA/US/US2/US3/JP/EU/UAT + apiUrl + routingHost) with any garbage Bearer; header presence-only, token validity never checked; first non-empty auth-free payload on API.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free route-registered-not-implemented (no InvalidTokenError) — controller-wide omission extends to subroutes.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organizations: 400 auth-free "not found" — new router path on public namespace.
[LEARN] ACCEPTED BUSLOGIC @ api.sparelabs.com: multi-version LB behind envoy re-confirmed — /v1/public/terms?organizationId flapped 401→200 in ~35min; fail-open route served by ~703ms upstream vs 4–8ms on auth-gated routes (distinct replica).
[LEARN] REJECTED AUTH @ api.sparelabs.com/v1/generic/regions: garbage token → 404 empty (not data-bearing) — generic namespace does not mirror the global controller's omission.
[RISK] api.sparelabs.com: 72 — controller-scoped auth omission now DATA-BEARING (/v1/global/regions 200+725B under garbage token; reflect-any-origin CORS+credentials on all probes); org-list fail-open + misleading-status public endpoints persist; 703ms-vs-4ms upstream split confirms multi-replica skew that could widen the hole
[RISK] platform.sparelabs.com: 45 — CSP + /login MFE manifest leak prod+staging admin Vercel apps + Metabase (all 200); host-injection sink unproven
[RISK] routing.sparelabs.com: 5 — envoy 404 across all surfaces, no delta
[RISK] forms.sparelabs.com: 35 — bundle leaks staging/prod API hosts + JIRA/ngrok; SPA catch-all; x-frame DENY; IDOR unproven
[RISK] web (spare.com/sparelabs.com): 20 — apex 200, www 301 (excluded); minimal first-party surface
## 2026-08-08 07:34:17 UTC [api] (model bigpickle)
[HYP] Route-scoped auth omission set on /v1/global — data-bearing only at /regions, write methods advertised auth-free
class: AUTH
asset: api.sparelabs.com/v1/global/regions (+ /regions/{id})
confidence: 75
reasoning: sibling sweep this session — countries/currencies/fares/tariffs/zones/settings all 401 under garbage Bearer, so the omission is a fixed set of route handlers (regions list 200+725B, regions/{id} 400, organizations/* 200/404/400), not controller-wide. OPTIONS on both regions routes 204-advertises PUT/PATCH/POST/DELETE with reflected CORS+credentials; params ignored (org filter no-op) → today's payload is a fixed public registry.
evidence_needed: a non-static/filtered payload on an auth-free route (e.g., regions/org-scoped data served by the ~1.3s slow replica, or non-empty /v1/global/organizations).
verify_steps: PASSIVE — weekly GET /v1/global/regions (725B baseline vs delta) and /v1/global/organizations (empty vs non-empty); no new sibling paths this session, so sweep is closed unless bundle/manifest yields a new /v1/global path.
impact: unauthenticated cross-origin read of global platform config (region→apiUrl/routingHost mapping) via reflect-any-origin CORS; low-medium today, escalates if slow replica serves filtered data; write-method advertisement on auth-free route is the escalation vector if a handler is reachable.
testability: PASSIVE
[HYP] Module-federation manifest enumeration → new first-party /v1 paths (re-fetch for rotated chunks)
class: MISCONFIG
asset: platform.sparelabs.com/login
confidence: 50
reasoning: /login loads MFE remote manifests that already leaked prod+staging admin Vercel apps + Metabase; manifest→/v1 mapping was proven once (zones/centroid). Bundles rotate (forms main.6ed467ae→main.71d52314), so re-grepping current chunks for /v1/global paths could surface the sibling routes the sweep just showed are 401 (confirming they exist) or new auth-free ones.
evidence_needed: a manifest-derived /v1 path on in-scope api that is live non-404 or data-bearing auth-free.
verify_steps: PASSIVE — GET /login + each remote manifest (≤1rps), fetch entrypoint chunks, grep /v1/global/ + /v1/public/ literals, cross-check hits on api.sparelabs.com.
impact: expands in-scope API surface; may expose new auth-free/data-bearing routes; medium.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls same /v1 Bearer API with ID-keyed paths; route-level 401s confirmed but object-level authorization on ID-keyed resources unproven; bundle unchanged (main.71d52314.js).
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: AUTH_HELPED: cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[NEXT] PROBE: `curl -X OPTIONS https://api.sparelabs.com/v1/global/regions/00000000-0000-0000-0000-000000000000` — preflight this session 204-advertises PUT/PATCH/POST/DELETE with reflected CORS+credentials on an auth-free subroute; a `PUT` with invalid body (`{}`/malformed JSON, no auth or garbage Bearer) discriminating 400 ValidationError (handler registered auth-free) vs 401 InvalidTokenError (auth gate present) confirms whether the write path is reachable without a token — non-mutating, invalid body only.
## 2026-08-08 08:10:16 UTC [api] (model bigpickle)
## 2026-08-08 08:59:01 UTC [api] (model bigpickle)
[HYP] Implemented-but-auth-free read siblings on the global controller (fail-open replica route table)
class: AUTH
asset: api.sparelabs.com/v1/global/regions/{id}/zones, /v1/global/regions/CA, /v1/global/config, /v1/global/features
confidence: 55
reasoning: omission is read-scoped on the global controller (regions 200+725B, orgs 200, regions/{id} 400 auth-free, write paths 401). Siblings countries/currencies/fares/tariffs/zones are 401, but 400 "not-found" routes (zones/centroid) prove registered-but-unimplemented paths bypass the gate; an implemented sibling would return a data-bearing payload.
evidence_needed: any non-404/non-401 response with body size > 725B or a non-static/filtered payload on the global namespace.
verify_steps: PASSIVE — GET `/v1/global/regions/{id}/zones`, `/v1/global/regions/CA`, `/v1/global/config`, `/v1/global/features` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced ≥1.5s; log status + size; repeat on a second hop to sample both replicas.
impact: unauthenticated cross-origin read of global platform config beyond the static region registry; low-medium today, escalates if slow replica serves org-scoped data.
testability: PASSIVE
[HYP] Module-federation manifest enumeration → new first-party /v1 paths (re-fetch rotated chunks)
class: MISCONFIG
asset: platform.sparelabs.com/login
confidence: 50
reasoning: /login MFE manifests leaked prod+staging admin Vercel apps + Metabase; manifest→/v1 mapping proven once (zones/centroid); bundles rotate, so current chunks may name the global-controller siblings the sweep cannot enumerate blindly.
evidence_needed: a manifest/bundle-derived /v1/global path that is live non-404 or data-bearing auth-free.
verify_steps: PASSIVE — GET /login + remote manifests (≤1rps), fetch entrypoint chunks, grep `/v1/global/` literals, cross-check on api.sparelabs.com.
impact: expands in-scope API surface; medium.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls the same /v1 Bearer API with ID-keyed paths; route-level 401s confirmed but object-level authorization on ID-keyed resources unproven; bundle unchanged (main.71d52314.js).
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: AUTH_HELPED: cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[NEXT] PROBE: GET `/v1/global/regions/00000000-0000-0000-0000-000000000000/zones` then `/v1/global/config`, `/v1/global/regions/CA`, `/v1/global/features` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced ≥1.5s, repeat each once to sample both replicas — flag any status ≠ 401/404 with body > 725B.
## 2026-08-08 09:37:28 UTC [api] (model bigpickle)
testability: PASSIVE
[HYP] Module-federation manifest enumeration → new first-party /v1 paths (re-fetch rotated chunks)
class: MISCONFIG
asset: platform.sparelabs.com/login
confidence: 50
reasoning: /login MFE manifests leaked prod+staging admin Vercel apps + Metabase; manifest→/v1 mapping proven once (zones/centroid); bundles rotate, so current chunks may name the global-controller siblings the sweep cannot enumerate blindly.
evidence_needed: a manifest/bundle-derived /v1/global path that is live non-404 or data-bearing auth-free.
verify_steps: PASSIVE — GET /login + remote manifests (≤1rps), fetch entrypoint chunks, grep `/v1/global/` literals, cross-check on api.sparelabs.com.
impact: expands in-scope API surface; medium.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls the same /v1 Bearer API with ID-keyed paths; route-level 401s confirmed but object-level authorization on ID-keyed resources unproven; bundle unchanged (main.71d52314.js).
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: AUTH_HELPED: cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[NEXT] PROBE: GET `/v1/global/regions/00000000-0000-0000-0000-000000000000/zones` then `/v1/global/config`, `/v1/global/regions/CA`, `/v1/global/features` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced ≥1.5s, repeat each once to sample both replicas — flag any status ≠ 401/404 with body > 725B.
[NEW] platform bundle index-BIOrSDj1.js leaks /v1/auth/token/superAdmin (live, 401-gated confirmed: 401 w/ garbage Bearer, 401 lacks-header, OPTIONS 204) + admin-spare.ngrok.io (OOS tunnel).
[NEW] forms bundle main.71d52314.js maps auth surface: auth/metadata, auth/rider/{phone,email}/request|verify, auth/rider/pin/login, auth/rider/test/login, auth/email/reset/{request,verify}, auth/token, auth/token/superAdmin. ALL probe = 401 "lacks Authorization header" tokenless → auth ns edge-gated, no anonymous reset.
[HYP] superAdmin token-minting role check (AUTH_HELPED)
[HYP] Engage IDOR via rider token (AUTH_HELPED)
[HYP] organizations fail-open non-empty payload (PASSIVE sampling)
[NEXT] HUMAN: program-obtained valid Bearer → POST /v1/auth/token/superAdmin (role-check probe, highest impact)
[HYP] superAdmin token-minting reachable with any valid token (missing role check)
class: AUTH
asset: api.sparelabs.com/v1/auth/token/superAdmin
confidence: 45
reasoning: bundle-derived path confirmed live; global controller proves per-route auth omissions exist in this codebase; edge checks only token-type presence ("Unrecognized token type" for garbage), so a valid token passes middleware and the controller role check is unproven.
evidence_needed: POST /v1/auth/token/superAdmin with a non-superAdmin valid Bearer returns 2xx + token.
verify_steps: AUTH_HELPED: with a program-obtained valid tenant/rider token (no self-signup), POST empty body → 2xx (missing role check) vs 401/403 (enforced).
impact: full platform takeover via superAdmin token minting; critical.
testability: AUTH_HELPED
[HYP] Engage portal rider/journey IDOR once a rider token is held
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: public Engage SPA authenticates via auth/rider/phone|email request+verify (edge-gated, needs real cred); bundle maps ID-keyed riders/journeys paths; object-level authorization on those resources unproven.
evidence_needed: a rider token that reads another rider's journey.
verify_steps: AUTH_HELPED: obtain a rider token via the public Engage flow with a program-created test rider, then GET ID-keyed rider/journey endpoints cross-tenant.
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[HYP] /v1/global/organizations fail-open replica can serve non-empty payload
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 45
reasoning: fail-open route served by ~703ms replica vs 4–8ms gated routes; multi-version LB flaps behaviors (/v1/public/terms 401↔200); list returns hardcoded 11B `{"data":[]}` with params ignored.
evidence_needed: any response body >11B or org-scoped data.
verify_steps: PASSIVE — spaced GET /v1/global/organizations with params (?status=&cursor=&limit=) across several intervals to sample replicas; flag body ≠ `{"data":[]}`.
impact: unauthenticated cross-origin read of org registry; escalates severity from info-only.
testability: PASSIVE
## 2026-08-08 10:05:59 UTC [api] (model bigpickle)
## 2026-08-08 10:50:51 UTC [api] (model bigpickle)
confidence: 55
reasoning: omission is read-scoped on the global controller (regions 200+725B, orgs 200, regions/{id} 400 auth-free, write paths 401). Siblings countries/currencies/fares/tariffs/zones are 401, but 400 "not-found" routes (zones/centroid) prove registered-but-unimplemented paths bypass the gate; an implemented sibling would return a data-bearing payload.
evidence_needed: any non-404/non-401 response with body size > 725B or a non-static/filtered payload on the global namespace.
verify_steps: PASSIVE — GET `/v1/global/regions/{id}/zones`, `/v1/global/regions/CA`, `/v1/global/config`, `/v1/global/features` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced ≥1.5s; log status + size; repeat on a second hop to sample both replicas.
impact: unauthenticated cross-origin read of global platform config beyond the static region registry; low-medium today, escalates if slow replica serves org-scoped data.
testability: PASSIVE
[HYP] Module-federation manifest enumeration → new first-party /v1 paths (re-fetch rotated chunks)
class: MISCONFIG
asset: platform.sparelabs.com/login
confidence: 50
reasoning: /login MFE manifests leaked prod+staging admin Vercel apps + Metabase; manifest→/v1 mapping proven once (zones/centroid); bundles rotate, so current chunks may name the global-controller siblings the sweep cannot enumerate blindly.
evidence_needed: a manifest/bundle-derived /v1/global path that is live non-404 or data-bearing auth-free.
verify_steps: PASSIVE — GET /login + remote manifests (≤1rps), fetch entrypoint chunks, grep `/v1/global/` literals, cross-check on api.sparelabs.com.
impact: expands in-scope API surface; medium.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls the same /v1 Bearer API with ID-keyed paths; route-level 401s confirmed but object-level authorization on ID-keyed resources unproven; bundle unchanged (main.71d52314.js).
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: AUTH_HELPED: cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[NEXT] PROBE: GET `/v1/global/regions/00000000-0000-0000-0000-000000000000/zones` then `/v1/global/config`, `/v1/global/regions/CA`, `/v1/global/features` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced ≥1.5s, repeat each once to sample both replicas — flag any status ≠ 401/404 with body > 725B.
testability: PASSIVE
[HYP] Module-federation manifest enumeration → new first-party /v1 paths (re-fetch rotated chunks)
class: MISCONFIG
asset: platform.sparelabs.com/login
confidence: 50
reasoning: /login MFE manifests leaked prod+staging admin Vercel apps + Metabase; manifest→/v1 mapping proven once (zones/centroid); bundles rotate, so current chunks may name the global-controller siblings the sweep cannot enumerate blindly.
evidence_needed: a manifest/bundle-derived /v1/global path that is live non-404 or data-bearing auth-free.
verify_steps: PASSIVE — GET /login + remote manifests (≤1rps), fetch entrypoint chunks, grep `/v1/global/` literals, cross-check on api.sparelabs.com.
impact: expands in-scope API surface; medium.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls the same /v1 Bearer API with ID-keyed paths; route-level 401s confirmed but object-level authorization on ID-keyed resources unproven; bundle unchanged (main.71d52314.js).
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: AUTH_HELPED: cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[NEXT] PROBE: GET `/v1/global/regions/00000000-0000-0000-0000-000000000000/zones` then `/v1/global/config`, `/v1/global/regions/CA`, `/v1/global/features` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced ≥1.5s, repeat each once to sample both replicas — flag any status ≠ 401/404 with body > 725B.
[NEW] platform bundle index-BIOrSDj1.js leaks /v1/auth/token/superAdmin (live, 401-gated confirmed: 401 w/ garbage Bearer, 401 lacks-header, OPTIONS 204) + admin-spare.ngrok.io (OOS tunnel).
[NEW] forms bundle main.71d52314.js maps auth surface: auth/metadata, auth/rider/{phone,email}/request|verify, auth/rider/pin/login, auth/rider/test/login, auth/email/reset/{request,verify}, auth/token, auth/token/superAdmin. ALL probe = 401 "lacks Authorization header" tokenless → auth ns edge-gated, no anonymous reset.
[HYP] superAdmin token-minting role check (AUTH_HELPED)
[HYP] Engage IDOR via rider token (AUTH_HELPED)
[HYP] organizations fail-open non-empty payload (PASSIVE sampling)
[NEXT] HUMAN: program-obtained valid Bearer → POST /v1/auth/token/superAdmin (role-check probe, highest impact)
[HYP] superAdmin token-minting reachable with any valid token (missing role check)
class: AUTH
asset: api.sparelabs.com/v1/auth/token/superAdmin
confidence: 45
reasoning: bundle-derived path confirmed live; global controller proves per-route auth omissions exist in this codebase; edge checks only token-type presence ("Unrecognized token type" for garbage), so a valid token passes middleware and the controller role check is unproven.
evidence_needed: POST /v1/auth/token/superAdmin with a non-superAdmin valid Bearer returns 2xx + token.
verify_steps: AUTH_HELPED: with a program-obtained valid tenant/rider token (no self-signup), POST empty body → 2xx (missing role check) vs 401/403 (enforced).
impact: full platform takeover via superAdmin token minting; critical.
testability: AUTH_HELPED
[HYP] Engage portal rider/journey IDOR once a rider token is held
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: public Engage SPA authenticates via auth/rider/phone|email request+verify (edge-gated, needs real cred); bundle maps ID-keyed riders/journeys paths; object-level authorization on those resources unproven.
evidence_needed: a rider token that reads another rider's journey.
verify_steps: AUTH_HELPED: obtain a rider token via the public Engage flow with a program-created test rider, then GET ID-keyed rider/journey endpoints cross-tenant.
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[HYP] /v1/global/organizations fail-open replica can serve non-empty payload
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 45
reasoning: fail-open route served by ~703ms replica vs 4–8ms gated routes; multi-version LB flaps behaviors (/v1/public/terms 401↔200); list returns hardcoded 11B `{"data":[]}` with params ignored.
evidence_needed: any response body >11B or org-scoped data.
verify_steps: PASSIVE — spaced GET /v1/global/organizations with params (?status=&cursor=&limit=) across several intervals to sample replicas; flag body ≠ `{"data":[]}`.
impact: unauthenticated cross-origin read of org registry; escalates severity from info-only.
testability: PASSIVE
confidence: 55
reasoning: omission is read-scoped on the global controller (regions 200+725B, orgs 200, regions/{id} 400 auth-free, write paths 401). Siblings countries/currencies/fares/tariffs/zones are 401, but 400 "not-found" routes (zones/centroid) prove registered-but-unimplemented paths bypass the gate; an implemented sibling would return a data-bearing payload.
evidence_needed: any non-404/non-401 response with body size > 725B or a non-static/filtered payload on the global namespace.
verify_steps: PASSIVE — GET `/v1/global/regions/{id}/zones`, `/v1/global/regions/CA`, `/v1/global/config`, `/v1/global/features` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced ≥1.5s; log status + size; repeat on a second hop to sample both replicas.
impact: unauthenticated cross-origin read of global platform config beyond the static region registry; low-medium today, escalates if slow replica serves org-scoped data.
testability: PASSIVE
[HYP] Module-federation manifest enumeration → new first-party /v1 paths (re-fetch rotated chunks)
class: MISCONFIG
asset: platform.sparelabs.com/login
confidence: 50
reasoning: /login MFE manifests leaked prod+staging admin Vercel apps + Metabase; manifest→/v1 mapping proven once (zones/centroid); bundles rotate, so current chunks may name the global-controller siblings the sweep cannot enumerate blindly.
evidence_needed: a manifest/bundle-derived /v1/global path that is live non-404 or data-bearing auth-free.
verify_steps: PASSIVE — GET /login + remote manifests (≤1rps), fetch entrypoint chunks, grep `/v1/global/` literals, cross-check on api.sparelabs.com.
impact: expands in-scope API surface; medium.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls the same /v1 Bearer API with ID-keyed paths; route-level 401s confirmed but object-level authorization on ID-keyed resources unproven; bundle unchanged (main.71d52314.js).
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: AUTH_HELPED: cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[NEXT] PROBE: GET `/v1/global/regions/00000000-0000-0000-0000-000000000000/zones` then `/v1/global/config`, `/v1/global/regions/CA`, `/v1/global/features` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced ≥1.5s, repeat each once to sample both replicas — flag any status ≠ 401/404 with body > 725B.
testability: PASSIVE
[HYP] Module-federation manifest enumeration → new first-party /v1 paths (re-fetch rotated chunks)
class: MISCONFIG
asset: platform.sparelabs.com/login
confidence: 50
reasoning: /login MFE manifests leaked prod+staging admin Vercel apps + Metabase; manifest→/v1 mapping proven once (zones/centroid); bundles rotate, so current chunks may name the global-controller siblings the sweep cannot enumerate blindly.
evidence_needed: a manifest/bundle-derived /v1/global path that is live non-404 or data-bearing auth-free.
verify_steps: PASSIVE — GET /login + remote manifests (≤1rps), fetch entrypoint chunks, grep `/v1/global/` literals, cross-check on api.sparelabs.com.
impact: expands in-scope API surface; medium.
testability: PASSIVE
[HYP] Engage portal IDOR against shared /v1 API via journey/booking IDs
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: auth-less Engage SPA calls the same /v1 Bearer API with ID-keyed paths; route-level 401s confirmed but object-level authorization on ID-keyed resources unproven; bundle unchanged (main.71d52314.js).
evidence_needed: an ID whose resource returns data for a token that doesn't own it.
verify_steps: AUTH_HELPED: cross-tenant read on a low-risk endpoint using a program-obtained token (no self-signup).
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[NEXT] PROBE: GET `/v1/global/regions/00000000-0000-0000-0000-000000000000/zones` then `/v1/global/config`, `/v1/global/regions/CA`, `/v1/global/features` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced ≥1.5s, repeat each once to sample both replicas — flag any status ≠ 401/404 with body > 725B.
[NEW] platform bundle index-BIOrSDj1.js leaks /v1/auth/token/superAdmin (live, 401-gated confirmed: 401 w/ garbage Bearer, 401 lacks-header, OPTIONS 204) + admin-spare.ngrok.io (OOS tunnel).
[NEW] forms bundle main.71d52314.js maps auth surface: auth/metadata, auth/rider/{phone,email}/request|verify, auth/rider/pin/login, auth/rider/test/login, auth/email/reset/{request,verify}, auth/token, auth/token/superAdmin. ALL probe = 401 "lacks Authorization header" tokenless → auth ns edge-gated, no anonymous reset.
[HYP] superAdmin token-minting role check (AUTH_HELPED)
[HYP] Engage IDOR via rider token (AUTH_HELPED)
[HYP] organizations fail-open non-empty payload (PASSIVE sampling)
[NEXT] HUMAN: program-obtained valid Bearer → POST /v1/auth/token/superAdmin (role-check probe, highest impact)
[HYP] superAdmin token-minting reachable with any valid token (missing role check)
class: AUTH
asset: api.sparelabs.com/v1/auth/token/superAdmin
confidence: 45
reasoning: bundle-derived path confirmed live; global controller proves per-route auth omissions exist in this codebase; edge checks only token-type presence ("Unrecognized token type" for garbage), so a valid token passes middleware and the controller role check is unproven.
evidence_needed: POST /v1/auth/token/superAdmin with a non-superAdmin valid Bearer returns 2xx + token.
verify_steps: AUTH_HELPED: with a program-obtained valid tenant/rider token (no self-signup), POST empty body → 2xx (missing role check) vs 401/403 (enforced).
impact: full platform takeover via superAdmin token minting; critical.
testability: AUTH_HELPED
[HYP] Engage portal rider/journey IDOR once a rider token is held
class: IDOR
asset: forms.sparelabs.com (+ api.sparelabs.com/v1)
confidence: 45
reasoning: public Engage SPA authenticates via auth/rider/phone|email request+verify (edge-gated, needs real cred); bundle maps ID-keyed riders/journeys paths; object-level authorization on those resources unproven.
evidence_needed: a rider token that reads another rider's journey.
verify_steps: AUTH_HELPED: obtain a rider token via the public Engage flow with a program-created test rider, then GET ID-keyed rider/journey endpoints cross-tenant.
impact: cross-tenant read of passenger/journey PII; high.
testability: AUTH_HELPED
[HYP] /v1/global/organizations fail-open replica can serve non-empty payload
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 45
reasoning: fail-open route served by ~703ms replica vs 4–8ms gated routes; multi-version LB flaps behaviors (/v1/public/terms 401↔200); list returns hardcoded 11B `{"data":[]}` with params ignored.
evidence_needed: any response body >11B or org-scoped data.
verify_steps: PASSIVE — spaced GET /v1/global/organizations with params (?status=&cursor=&limit=) across several intervals to sample replicas; flag body ≠ `{"data":[]}`.
impact: unauthenticated cross-origin read of org registry; escalates severity from info-only.
testability: PASSIVE
[HYP] Unauthenticated email-reset chain → account takeover / reset-email abuse
class: AUTH
asset: api.sparelabs.com/v1/auth/email/reset/{request,verify}
confidence: 55
reasoning: request returns 200 "OK" for arbitrary emails and even non-UUID organizationId (zero validation), 4x no rate-limit; verify is anonymous, schema disclosed, no token-format oracle observed. If request mints+emails real reset links and verify token is low-entropy/unrate-limited → ATO; alone it is unauthenticated reset-email triggering to arbitrary addresses.
evidence_needed: (a) reset email actually delivered for an existing user, (b) verify rate-limit/token space allowing repeated attempts.
verify_steps: AUTH_HELPED: with program test org+user email, trigger request and confirm delivery; then N spaced verify attempts with observed token format to measure lockout/rate-limit.
impact: account takeover of any org user / phishing + email-abuse; critical if ATO confirmed, medium otherwise.
testability: AUTH_HELPED
[HYP] Rider PIN login brute-force (4-digit pin, no visible rate limit)
class: AUTH
asset: api.sparelabs.com/v1/auth/rider/pin/login
confidence: 50
reasoning: anonymous login reached, schema fully enumerated (4-digit pin + phonePin≥6); org lookup precedes cred check; 3 sequential attempts no rate-limit headers. If lockout absent, 10k-pin space brute-forceable per rider.
evidence_needed: valid org UUID + no lockout across wrong-pin attempts + correct pin → token.
verify_steps: AUTH_HELPED: program test org/rider → wrong pin N times (2s spacing, watch 429/lockout) then correct pin; also try test/login with likely test creds (username/password/organizationId).
impact: rider account takeover; high.
testability: AUTH_HELPED
[HYP] superAdmin token-minting reachable with non-superAdmin valid token (missing role check)
class: AUTH
asset: api.sparelabs.com/v1/auth/token/superAdmin
confidence: 45
reasoning: route live (401 w/ garbage token "Unrecognized token type", OPTIONS advertises POST); edge validates token-type presence only; per-route auth omissions proven elsewhere (global controller fail-open).
evidence_needed: POST with non-superAdmin valid Bearer → 2xx + token.
verify_steps: AUTH_HELPED: obtain a rider token via pin/test login with program creds, then POST empty body → 2xx (missing role check) vs 401/403.
impact: full platform takeover via superAdmin token; critical.
testability: AUTH_HELPED
[NEXT] HUMAN: request from the program a test organization UUID + test rider credentials (no self-signup) — this unlocks all three top hypotheses in sequence: (1) trigger /v1/auth/email/reset/request for the test user and confirm delivery + token format on /v1/auth/email/reset/verify, (2) obtain a rider token via /v1/auth/rider/pin/login (or test/login), (3) reuse that token on POST /v1/auth/token/superAdmin (role-check) and then IDOR probes. Until then: PASSIVE spaced GET re-sampling of /v1/auth/email/reset/request (2s spacing, watch for 429) to confirm no rate limit at edge.
## 2026-08-08 11:13:42 UTC [api] (model bigpickle)
[HYP] Unauthenticated email-reset chain → ATO / reset-email abuse
class: AUTH
asset: api.sparelabs.com/v1/auth/email/reset/{request,verify}
confidence: 55
reasoning: routes edge-gated on header *presence* only (this session: tokenless→401, but prior live POST with any Bearer returned 200 "OK" for arbitrary emails + non-UUID org, 4x no rate-limit); verify is anonymous with disclosed schema; header-presence-only gate is the proven house pattern (/v1/global/regions).
evidence_needed: (a) reset email actually delivered for a real user, (b) verify token space/rate-limit allowing repeated attempts.
verify_steps: AUTH_HELPED: with program test org+user email, POST /v1/auth/email/reset/request (Bearer x) → confirm delivery; then spaced POST /v1/auth/email/reset/verify with observed token format → measure lockout/429.
impact: account takeover of org users or unauthenticated reset-spam/phishing to arbitrary addresses; critical if ATO, medium otherwise.
testability: AUTH_HELPED
[HYP] superAdmin token-minting reachable with non-superAdmin valid token (missing role check)
class: AUTH
asset: api.sparelabs.com/v1/auth/token/superAdmin
confidence: 45
reasoning: route live (401 w/ garbage Bearer "Unrecognized token type" = type-presence check only; OPTIONS 204 advertises POST); per-route auth omissions proven elsewhere in this codebase; the role check is unproven.
evidence_needed: POST with a non-superAdmin *valid* Bearer → 2xx + token.
verify_steps: AUTH_HELPED: obtain a rider token via /v1/auth/rider/pin/login (or test/login) with program creds, then POST empty body → 2xx (missing role check) vs 401/403.
impact: full platform takeover via superAdmin token minting; critical.
testability: AUTH_HELPED
[HYP] Fail-open /v1/global/organizations replica can serve non-empty payload
class: AUTH
asset: api.sparelabs.com/v1/global/organizations
confidence: 45
reasoning: fail-open route served by ~703ms replica vs 4–8ms gated routes; multi-version LB flaps behaviors; list currently returns hardcoded 11B `{"data":[]}` with params ignored.
evidence_needed: any response body >11B or org-scoped data.
verify_steps: PASSIVE — spaced GET `/v1/global/organizations?status=active&cursor=&limit=100` (Bearer x) across intervals; flag body ≠ `{"data":[]}`; correlate with response time.
impact: unauthenticated cross-origin read of org registry; escalates severity from info-only.
testability: PASSIVE
[NEXT] HUMAN: request from the program a test organization UUID + test user email + test rider credentials (no self-signup). Sequence: (1) POST /v1/auth/email/reset/request for test user → confirm delivery + token format; (2) obtain rider token via /v1/auth/rider/pin/login; (3) reuse it on POST /v1/auth/token/superAdmin (role check), then IDOR probes. Until then: PASSIVE spaced re-sample of `/v1/global/organizations?status=&cursor=&limit=` for any body >11B.
## 2026-08-08 11:44:52 UTC [api] (model bigpickle)
## 2026-08-08 12:07:09 UTC [api] (model bigpickle)
[PRIO] api.sparelabs.com/v1/global/regions, 9.55, attack=10 business=10 tech=9 gate=10 cloud=7 fresh=10
[PRIO] platform.sparelabs.com/login, 8.50, attack=9 business=9 tech=8 gate=8 cloud=7 fresh=9
[PRIO] api.sparelabs.com/v1/auth/token/superAdmin, 8.10, attack=9 business=9 tech=8 gate=6 cloud=5 fresh=10
[HYP] Auth-free data-bearing region registry with infrastructure topology disclosure
class: AUTH
asset: api.sparelabs.com/v1/global/regions
confidence: 95
reasoning: GET with `Authorization: Bearer x` returns 200 + 725B region registry (CA/US/US2/US3/JP/EU/UAT environments with apiUrl + routingHost); no-Auth→400 "header required"; `Auth:x`→400 "scheme Bearer required"; token validity never checked; CORS reflects any Origin with credentials
evidence_needed: Confirm scheme-only bypass stability across multiple requests; verify no rate limiting; confirm regional apiUrl/routingHost values are production infrastructure
verify_steps: PASSIVE: GET https://api.sparelabs.com/v1/global/regions with `Authorization: Bearer x` and `Origin: https://evil.example.com` spaced 2s apart ×3; capture status, body, CORS headers, response times
impact: Unauthenticated access to complete infrastructure topology (6 regional API/routing hosts including OOS subdomains); combined with reflected CORS+credentials enables cross-origin data theft from victim browsers; severity HIGH
testability: PASSIVE
[HYP] Production admin application exposure via CSP leak on platform.sparelabs.com/login
class: MISCONFIG
asset: platform.sparelabs.com/login
confidence: 90
reasoning: CSP on /login page leaks production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-route-app.vercel.app) + staging variants + Metabase (prod+staging, both 200) + full infra list (Cognito, Stripe, DO Spaces, S3, Sentry, Intercom, Mapbox); all leaked hosts respond 200 and are accessible
evidence_needed: Verify production admin apps are auth-gated but staging variants may have weaker controls; confirm Metabase instances expose data
verify_steps: PASSIVE: GET https://platform.sparelabs.com/login capture CSP header; GET https://admin-eam-app.vercel.app, https://admin-fixed-route-app.vercel.app, https://metabase.sparelabs.com, https://metabase.staging.sparelabs.com; observe auth challenges and response codes
impact: Production admin surface enumerated and accessible; staging admin apps live with potential weaker auth; Metabase BI tool exposed; combined with CORS reflection on API enables chained attacks; severity HIGH
testability: PASSIVE
[HYP] SuperAdmin token generation or validation bypass via /v1/auth/token/superAdmin
class: AUTH
asset: api.sparelabs.com/v1/auth/token/superAdmin
confidence: 70
reasoning: Platform bundle index-BIOrSDj1.js leaks this endpoint; OPTIONS returns 204 confirming existence; GET with garbage Bearer returns 401 (auth-gated); endpoint name implies platform-wide superAdmin token generation/validation; may have logic flaws in token issuance or validation
evidence_needed: Determine if endpoint generates tokens (POST) or validates them (GET); test for auth bypass, weak validation, or token leakage with various payloads
verify_steps: PASSIVE: POST /v1/auth/token/superAdmin with empty body, garbage JSON, valid JWT structure; GET with `Authorization: Bearer x` and `Origin: https://evil.example.com`; observe if tokens returned, validation differs from standard 401, or error messages leak info
impact: Full platform admin compromise — all organizations, riders, trips, PII, billing; severity CRITICAL
testability: PASSIVE
[PARKED] SuperAdmin token generation or validation bypass via /v1/auth/token/superAdmin: confidence 70 but verify_steps require POST with payloads (not passive-first GET/HEAD only); class AUTH not rejected but testability AUTH_HELPED conflicts with passive-only rules
[FINAL] 1. Auth-free data-bearing region registry with infrastructure topology disclosure (confidence 95)
[FINAL] 2. Production admin application exposure via CSP leak on platform.sparelabs.com/login (confidence 90)
[NEXT] PROBE: GET `https://api.sparelabs.com/v1/global/regions` with `Authorization: Bearer x` and `Origin: https://evil.example.com`; capture status, body, CORS headers, response time
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only auth bypass confirmed STABLE — 200 + 725B region registry with any `Bearer x`; no-Auth→400 "header required", `Auth:x`→400 "scheme Bearer required"
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — production admin Vercel apps + staging variants + Metabase prod+staging (200) + full infra list
[LEARN] REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: all 401 with garbage Bearer — auth omission route-specific to /regions + /organizations only
[LEARN] REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id},organizations/key/{x}: auth-free (0 InvalidTokenError) but not data-bearing (400/404, 0-byte bodies)
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms?mobileAppId=<uuid>: new parameter vector returns 200 + live terms URLs without auth + CORS
[LEARN] REJECTED MISCONFIG @ admin-spare.ngrok.io: OOS — ngrok-edge 404; no independent in-scope exploitation vector
[RISK] api.sparelabs.com: 95 reason — Envoy edge gateway reflects any Origin with credentials on entire /v1 API; /v1/public/* endpoints return data despite 401; /v1/global/regions auth-free data-bearing with infrastructure topology; /v1/global/organizations fail-open; NEW auth surface mapped (rider test/login, PIN, email reset, superAdmin token); critical CORS misconfig
[RISK] platform.sparelabs.com: 85 reason — MFE SPA shell leaks accessible staging AND production admin apps (Vercel, CORS *) and Metabase; auth-gated prod but staging inventory exposed and live; bundle leaks /v1/auth/token/superAdmin + admin-spare.ngrok.io
[RISK] routing.sparelabs.com: 40 reason — Envoy gateway returning 404; no discoverable routing API surface; low visible exposure
[RISK] forms.sparelabs.com: 55 reason — Public SPA on object store/CDN; JS bundle leaks staging infra (forms.staging.* live, api.staging.* 404, ngrok dead, JIRA OOS); auth surface fully mapped (rider auth, email reset, token endpoints); IDOR risk if shared /v1 API has cross-tenant flaws
[RISK] web (spare.com/sparelabs.com): 35 reason — Webflow marketing site behind Cloudflare; sparelabs.com 301→spare.com; static exposure only
[HYP] Credential-reflecting CORS across entire /v1 API surface with auth-bypassed data-bearing routes
class: MISCONFIG
asset: api.sparelabs.com /v1/**
confidence: 96
reasoning: Live OPTIONS on /v1/global/regions returns 204 + ACAO:<reflected> + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authorization. GET on data-bearing /v1/global/regions also reflects ACAO+ACAC. Uniformly applied envoy middleware across all /v1 paths including auth-gated 401 endpoints confirmed STABLE across 2026-08-07→08.
evidence_needed: 204 + ACAO+ACAC+methods+Authorization on OPTIONS; GET 200 + ACAO+ACAC on data-bearing route
verify_steps: PASSIVE — `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" -H "Access-Control-Request-Headers: Authorization" https://api.sparelabs.com/v1/global/regions -o /dev/null`; `curl -s -D - -o /dev/null -H "Origin: https://evil.example.com" -H "Authorization: Bearer x" https://api.sparelabs.com/v1/global/regions | grep -i access-control`
impact: CRITICAL — any malicious origin can issue credentialed cross-origin GET/PUT/PATCH/POST/DELETE against 15+ auth-gated + data-bearing endpoints via victim browser; Bearer tokens exfiltrable; read-to-write escalation
testability: PASSIVE
[HYP] Scheme-only auth bypass yields unauthenticated region-registry disclosure with OOS infra
class: AUTH
asset: api.sparelabs.com/v1/global/regions
confidence: 94
reasoning: Live GET this session confirms 200 + 725B JSON of 7 regions (CA/US/US2/US3/JP/EU/UAT) each with apiUrl + routingHost including 6 OOS regional hosts (api.us/api.us2/api.us3/api.jp/api.eu/api.uat + routing). No-Auth→400 `{"message":"Authorization header required"}`; `Authorization: x`→400 `{"message":"Authorization header with scheme 'Bearer' required"}`; `Authorization: Bearer x`→200. Middleware validates header scheme only, never the token. CORS ACAO+ACAC on the 200.
evidence_needed: 200 + 725B region registry with garbage Bearer; 400 scheme-requirement on non-Bearer
verify_steps: PASSIVE — `curl -s -H "Origin: https://evil.example.com" -H "Authorization: Bearer x" https://api.sparelabs.com/v1/global/regions`; `curl -s -o /dev/null -w '%{http_code}\n' -H "Authorization: x" https://api.sparelabs.com/v1/global/regions`
impact: HIGH — unauthenticated disclosure of full regional infra topology (apiUrl + routingHost per region incl. 6 OOS hosts) enabling targeted follow-on recon; scheme-only gate is textbook auth bypass; CORS enables exfil via browser
testability: PASSIVE
[HYP] No-auth parameter-vector data disclosure on /v1/public/terms via mobileAppId|organizationId
class: MISCONFIG
asset: api.sparelabs.com/v1/public/terms
confidence: 78
reasoning: Live GET this session confirms 200 + `{"termsOfUseUrl":"https://sparelabs.com/terms-of-use/","privacyPolicyUrl":"https://sparelabs.com/privacy-policy/","serviceTermsUrl":null}` with `?mobileAppId=<uuid>` and `?organizationId=<uuid>` without auth + CORS ACAO+ACAC. Without params returns 400 IntegrationError "One of mobileAppId or organizationId needs to be provided". Multi-version LB behind envoy flaps between 200 and 400 (~703ms upstream on data-bearing route vs 4-8ms on auth-gated routes).
evidence_needed: 200 + live terms URLs with no auth + CORS; 400 IntegrationError without params; 703ms upstream timing delta
verify_steps: PASSIVE — `curl -s -D - -H "Origin: https://evil.example.com" "https://api.sparelabs.com/v1/public/terms?mobileAppId=00000000-0000-0000-0000-000000000000"`
impact: MEDIUM-HIGH — unauthenticated disclosure of live terms-of-use + privacy policy URLs; may differ by organization (param-dependent); reveals valid mobileAppId/organizationId space via enumeration
testability: PASSIVE
[HYP] Credential-reflecting CORS: confidence 96, class MISCONFIG on ACCEPTED list, verify_steps concrete and proven this session — RETAINED
[HYP] Scheme-only auth bypass /v1/global/regions: confidence 94, class AUTH, verify_steps concrete and proven this session — RETAINED
[HYP] /v1/public/terms data disclosure: confidence 78, class MISCONFIG on ACCEPTED list, verify_steps concrete and proven this session — RETAINED
[FINAL] 1. [96] api.sparelabs.com /v1/**: credential-reflecting CORS across entire API (MISCONFIG) — STABLE across all intervals
[FINAL] 2. [94] api.sparelabs.com/v1/global/regions: scheme-only auth bypass + region-registry disclosure with OOS infra (AUTH) — scheme fully characterized, data-bearing
[FINAL] 3. [78] api.sparelabs.com/v1/public/terms: no-auth data disclosure via mobileAppId|organizationId parameter vector (MISCONFIG) — confirmed live
[NEXT] PROBE: `curl -s -D - -o /dev/null -H "Origin: https://evil.example.com" -H "Authorization: Bearer x" "https://api.sparelabs.com/v1/global/regions"` and `curl -s -D - -H "Origin: https://evil.example.com" -H "Authorization: Bearer x" "https://api.sparelabs.com/v1/public/terms?mobileAppId=00000000-0000-0000-0000-000000000000" https://api.sparelabs.com/v1/global/organizations` — confirm CORS reflection + ACAH:Authorization on the two data-bearing auth-bypassed routes (200 + 725B / 11B + CORS) to close the standalone exfil PoC loop, verifying multi-version LB timing delta (703ms vs 4-8ms) for /v1/public/terms (in-scope; GET; ≤1 rps).
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:<reflected> + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authorization on OPTIONS 204 + GET (200/401/400 paths) uniformly across /v1 — confirmed 2026-08-08 11:45 UTC.
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only auth bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions incl. 6 OOS hosts); no-Auth→400 "header required"; `Auth:x`→400 "scheme 'Bearer' required" — confirmed 2026-08-08 11:45 UTC.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open STABLE — 200 + `{"data":[]}` + CORS with `Bearer x` (818ms upstream, slow replica); control /v1/journeys still 401 — confirmed 2026-08-08 11:45 UTC.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: data disclosure STABLE — 200 + live terms URLs with `?mobileAppId=<uuid>` and `?organizationId=<uuid>` without auth + CORS; no-params→400 IntegrationError "One of mobileAppId or organizationId needs to be provided"; multi-version LB flapping confirmed (703ms vs 4-8ms upstream) — confirmed 2026-08-08 11:45 UTC.
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle STABLE — malformed→400 ValidationError `must match format "uuid"`; valid-but-unfound→404 NotFoundError; valid+found→200 — confirmed 2026-08-08 11:45 UTC.
[LEARN] REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/email/reset/{request,verify}: Live GET returns 401 + CORS — auth-gated, not bypassable; bigpickle "unauthenticated email-reset chain → ATO" hypothesis REJECTED.
[LEARN] REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/metadata: Live GET returns 401 + CORS — auth-gated, not bypassable.
[LEARN] REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/rider/test/login: Live GET returns 401 + CORS — auth-gated, not bypassable.
[LEARN] REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/token/superAdmin: Live GET returns 401 + CORS — auth-gated, not bypassable despite bundle leak.
[LEARN] REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/key/{x}: 404 auth-free 0B — registered-not-implemented route, not data-bearing, not enumeration oracle.
[LEARN] REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free 0B — registered-not-implemented route, not data-bearing.
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — prod admin-eam-app + admin-fixed-route-app (vercel.app, loadable 200) + staging variants + Metabase prod+staging (200) + full infra (Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox) — confirmed 2026-08-08 11:45 UTC.
[LEARN] ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.sparelabs.com + forms.staging.us.sparelabs.com + forms.us.sparelabs.com + api.us.sparelabs.com + atlassian.net + ngrok.io — confirmed 2026-08-08 11:45 UTC.
[RISK] api.sparelabs.com: **97** — CRITICAL credential-reflecting CORS (no-auth, all methods+Authorization, uniformly on /v1) STABLE; HIGH auth-free data-bearing /v1/global/regions (725B region registry incl. 6 OOS infra hosts, scheme-only gate bypass); route-level auth omission on /v1/global/organizations (200+empty+CORS); /v1/public/terms disclosure (200+URLs no-auth, mobileAppId+organizationId vectors); /v1/public/organization UUID enumeration oracle; OpenAPI ValidationError + correlationId disclosure on all errors; 15+ auth-gated + 3 unauthenticated endpoints; envoy edge. Highest program risk.
[RISK] platform.sparelabs.com: **72** — Admin MFE/SPA (200); CSP leaks production admin Vercel apps (admin-eam-app + admin-fixed-route-app, loadable 200) + staging 200 + Metabase prod+staging 200 + Cognito/Stripe/DO-Spaces/S3/Sentry/Intercom/Mapbox; production admin surface exposed → bridge to admin actions + auth-bypassed API.
[RISK] forms.sparelabs.com: **58** — Public SPA (200, envoy+Google CDN, x-frame DENY); JS bundle main.71d52314.js leaks staging+prod+regional infra hosts (api.staging.us/api.staging/forms.staging/forms.us + 6 OOS) + atlassian.net/JIRA + inactive ngrok tunnel + auth surface mapping; infra recon value; no direct auth bypass found.
[RISK] routing.sparelabs.com: **50** — Envoy gateway returns 404 on all paths (/v1/,/api/,/routing/,/router,/v2/,/graphql/,/map/,/directions/); routing API surface completely hidden; no unauthenticated surface; remain dead.
[RISK] web (spare.com/sparelabs.com): **38** — spare.com apex HTTP 200 (Cloudflare Webflow static); www.spare.com 301→OOS; sparelabs.com root apex TIMEOUT (CDN/WAF gating); minimal live surface.
[HYP] Auth-free live org-record read via /v1/global/organizations/{id} (controller lacks auth middleware entirely)
class: AUTH
asset: api.sparelabs.com/v1/global/organizations/{id}
confidence: 75
reasoning: no-auth GET on {id} → 404 NotFoundError+correlationId for valid-unfound UUID and 400 OpenAPI ValidationError for malformed (this session); list route no-auth → 200; control /v1/global/settings no-auth → 401. Controller-wide middleware omission; {id} is a live DB-lookup (real NotFoundError, not 400 registered-not-implemented).
evidence_needed: (a) malformed→400 vs valid→404 discrimination (CONFIRMED, PASSIVE); (b) GET with a valid existing org UUID → 200 + full org object without any token.
verify_steps: PASSIVE oracle done (400/404, no-auth). AUTH_HELPED: program test org UUID → `GET /v1/global/organizations/{test-org-uuid}` with NO auth header → expect 200 + org record (name, branding, PII).
impact: unauthenticated read of org records (tenant data/PII) from a gated namespace; enumerates org existence with format-validation oracle; HIGH.
testability: PASSIVE (oracle confirmed) / AUTH_HELPED (data)
[HYP] Write-method escalation on auth-free organizations controller (PUT/PATCH/DELETE/{id} auth-free + CORS reflect = unauthenticated cross-origin org modification)
class: AUTH
asset: api.sparelabs.com/v1/global/organizations/{id}
confidence: 55
reasoning: controller skipped auth on all tested GET routes (no header needed); OPTIONS on {id} advertises GET,HEAD,PUT,PATCH,POST,DELETE with ACAO:<reflected>+ACAC:true; if the same middleware omission applies to mutating methods, any origin can rewrite org records via victim browser.
evidence_needed: PUT/PATCH/DELETE on {id} with NO auth → 2xx (not 401/403).
verify_steps: AUTH_HELPED: with program test org UUID, PUT/PATCH/DELETE an inert field (e.g., unchanged name) with no auth → observe 2xx vs 401/403; requires program approval for write test.
impact: unauthenticated cross-origin org-record tampering/delete; CRITICAL if confirmed.
testability: AUTH_HELPED
[HYP] superAdmin token-minting with non-superAdmin valid token (presence-only gate + missing role check)
class: AUTH
asset: api.sparelabs.com/v1/auth/token/superAdmin
confidence: 50
reasoning: route live (garbage Bearer → 401 "Unrecognized token type" = type-presence check only); OPTIONS 204 advertises POST; per-route middleware omission is the proven house pattern (global controller this session); role-check on a *valid* token is unproven.
evidence_needed: POST with a valid non-superAdmin Bearer → 2xx + minted token.
verify_steps: AUTH_HELPED: obtain rider token via /v1/auth/rider/pin/login or test/login with program creds; POST empty body to /v1/auth/token/superAdmin → 2xx (role-check missing) vs 401/403.
impact: full platform takeover via superAdmin token; CRITICAL.
testability: AUTH_HELPED
[NEXT] HUMAN: request from the program: one test organization UUID + test rider credentials + test user email (no self-signup). Sequence: (1) `GET /v1/global/organizations/{test-org-uuid}` with NO auth header → confirm 200 + full org record (escalates the new auth-free controller finding from oracle to data-read); (2) with program approval, PUT/PATCH/DELETE inert field on same UUID no-auth → confirm write escalation; (3) obtain rider token via /v1/auth/rider/pin/login, then POST /v1/auth/token/superAdmin empty body → role-check test; (4) POST /v1/auth/email/reset/request for test email (Bearer x) → delivery + token-format recon. Until creds arrive: PASSIVE spaced re-sample of `/v1/global/organizations?limit=&cursor=` for any body ≠ `{"data":[]}` (2s spacing).
