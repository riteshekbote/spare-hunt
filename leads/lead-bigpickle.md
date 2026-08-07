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
