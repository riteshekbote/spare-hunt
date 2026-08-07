# Ranked Hypotheses

## SEED 2026-08-07 (from passive recon, not model-generated yet)
- [55] api.sparelabs.com: 404-on-root but likely large API surface — enumerate OpenAPI/swagger/docs paths once reachable (from inventory seed)
- [50] sparelabs.com hosts timing out: CDN/WAF posture — verify origin vs CDN split for SSRF-ish primitives in first-party code (from inventory seed)
- [45] sparelabs org forks: stale/deprecated vendored libs (react-native, mapbox) — check for known CVEs in first-party usage (from inventory seed)

## RANKED HYPOTHESES 2026-08-07 18:34:58 UTC
- [70] api.sparelabs.com: api.sparelabs.com exposes undocumented API endpoints via missing OpenAPI spec (from reports/hypotheses-nemotron3.txt)
- [60] platform.sparelabs.com: platform.sparelabs.com CSP leaks internal/staging asset inventory (from reports/hypotheses-laguna.txt)
- [55] api.sparelabs.com/v1/**: Unauthenticated /v1/ endpoint surface on API gateway (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET https://api.sparelabs.com/docs, GET https://api.sparelabs.com/swagger, GET https://api.sparelabs.com/openapi.json, GET https://api.sparelabs.com/api-
- NEXT(hypotheses-bigpickle.txt): PROBE: bound no-auth GET sweep on api.sparelabs.com: /v1/config, /v1/health, /v1/journeyNotifications + /v1/nonexistent control, classify 401/200/404/500, ≤1 rp
- NEXT(hypotheses-laguna.txt): SCAN https://forms.sparelabs.com : enumerate sensitive object paths with HEAD/GET ≤1 rps (`/`, `/static/`, `/static/js/*.js`, `/.well-known/`, `/admin`, `/confi
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: asset unreachable, confidence below threshold, no auth context available

## RANKED HYPOTHESES 2026-08-07 19:01:01 UTC
- [65] api.sparelabs.com/v1/**: api.sparelabs.com inconsistent auth enforcement across /v1/* endpoints (from reports/hypotheses-nemotron3.txt)
- [50] api.sparelabs.com/v1/journeys: API gateway reflects any Origin with credentials — CORS misconfig (from reports/hypotheses-bigpickle.txt)
- [50] api.sparelabs.com: api.sparelabs.com unauthenticated org enumeration via OpenAPI schema leak (from reports/hypotheses-laguna.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET https://api.sparelabs.com/v1/config, GET https://api.sparelabs.com/v1/health, GET https://api.sparelabs.com/v1/journeyNotifications, GET https://api.
- NEXT(hypotheses-laguna.txt): PROBE: Sweep additional `/v1/public/*` and `/v1/*` endpoint candidate names on api.sparelabs.com with GET ≤1rps (e.g., /v1/public/{forms,cases,settings,rates,qu
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1: live probe confirms /v1/journeys returns explicit 401 without auth, proving API surface exists behind edge gateway an
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + MFE manifest enumeration of staging admin assets confirmed passively
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: asset returns envoy 404, no routing API surface visible, confidence below threshold, no auth context available
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + `/login` prefetch script CONFIRMED leaking `admin-eam-app-staging.vercel.app`, `admin-fixed-route-app-staging
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle CONFIRMED leaking `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `forms.staging.sparelabs.com`
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com: `/v1/` API CONFIRMED discoverable via passive enum. 3 unauthenticated endpoints live (200/400/404); 15+ auth-gated endpo
- LEARN: REJECTED AUTH @ api.sparelabs.com: Previous "auth not challengeable" hypothesis PARKED — edge properly returns 401 for auth-gated routes; new finding is the una
- LEARN: REJECTED MISCONFIG @ forms.sparelabs.com: Object-store directory listing hypothesis PARKED — traffic served via envoy+Google CDN (not raw object store); SPA cat
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all `/v1/`, `/api/`, `/routing/`, `/router`, `/v2/`, `/graphql`, `/map`, `/directions` paths return 

## RANKED HYPOTHESES 2026-08-07 19:16:49 UTC
- [65] api.sparelabs.com/v1/**: api.sparelabs.com inconsistent auth enforcement across /v1/* endpoints (from reports/hypotheses-nemotron3.txt)
- [60] api.sparelabs.com/v1/journeys,: API reflects any Origin with credentials on live auth-gated routes (from reports/hypotheses-bigpickle.txt)
- [50] api.sparelabs.com: api.sparelabs.com unauthenticated org enumeration via OpenAPI schema leak (from reports/hypotheses-laguna.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET https://api.sparelabs.com/v1/config, GET https://api.sparelabs.com/v1/health, GET https://api.sparelabs.com/v1/journeyNotifications, GET https://api.
- NEXT(hypotheses-laguna.txt): PROBE: Sweep additional `/v1/public/*` and `/v1/*` endpoint candidate names on api.sparelabs.com with GET ≤1rps (e.g., /v1/public/{forms,cases,settings,rates,qu
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1: live probe confirms /v1/journeys returns explicit 401 without auth, proving API surface exists behind edge gateway an
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + MFE manifest enumeration of staging admin assets confirmed passively
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: asset returns envoy 404, no routing API surface visible, confidence below threshold, no auth context available
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login prefetch script CONFIRMED leaking admin-eam-app-staging.vercel.app, admin-fixed-route-app-staging.verc
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle CONFIRMED leaking api.staging.us.sparelabs.com, api.staging.sparelabs.com, forms.staging.sparelabs.com, form
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com: /v1/ API CONFIRMED discoverable via passive enum. 3 unauthenticated endpoints live (200/400/404); 15+ auth-gated endpoin
- LEARN: REJECTED AUTH @ api.sparelabs.com: Previous "auth not challengeable" hypothesis PARKED — edge properly returns 401 for auth-gated routes; new finding is the una
- LEARN: REJECTED MISCONFIG @ forms.sparelabs.com: Object-store directory listing hypothesis PARKED — traffic served via envoy+Google CDN (not raw object store); SPA cat
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql, /map, /directions paths return 404; no discover
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + `/login` prefetch script CONFIRMED leaking `admin-eam-app-staging.vercel.app`, `admin-fixed-route-app-staging
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle CONFIRMED leaking `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `forms.staging.sparelabs.com`
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com: `/v1/` API CONFIRMED discoverable via passive enum. 3 unauthenticated endpoints live (200/400/404); 15+ auth-gated endpo
- LEARN: REJECTED AUTH @ api.sparelabs.com: Previous "auth not challengeable" hypothesis PARKED — edge properly returns 401 for auth-gated routes; new finding is the una
- LEARN: REJECTED MISCONFIG @ forms.sparelabs.com: Object-store directory listing hypothesis PARKED — traffic served via envoy+Google CDN (not raw object store); SPA cat
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all `/v1/`, `/api/`, `/routing/`, `/router`, `/v2/`, `/graphql`, `/map`, `/directions` paths return 

## RANKED HYPOTHESES 2026-08-07 20:05:10 UTC
- [80] api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials on entire /v1 API surface (confirmed) — escalate if any auto-attached credential exists (from reports/hypotheses-bigpickle.txt)
- [65] api.sparelabs.com/v1/**: api.sparelabs.com inconsistent auth enforcement across /v1/* endpoints (from reports/hypotheses-nemotron3.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET https://api.sparelabs.com/v1/config, GET https://api.sparelabs.com/v1/health, GET https://api.sparelabs.com/v1/journeyNotifications, GET https://api.
- NEXT(hypotheses-bigpickle.txt): PROBE: GET https://api.sparelabs.com/v1/public/terms?organizationId=00000000-0000-0000-0000-000000000000 and capture the response body — the new 200 contradicts
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1: live probe confirms /v1/journeys returns explicit 401 without auth, proving API surface exists behind edge gateway an
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + MFE manifest enumeration of staging admin assets confirmed passively
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: asset returns envoy 404, no routing API surface visible, confidence below threshold, no auth context available
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login prefetch script CONFIRMED leaking admin-eam-app-staging.vercel.app, admin-fixed-route-app-staging.verc
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle CONFIRMED leaking api.staging.us.sparelabs.com, api.staging.sparelabs.com, forms.staging.sparelabs.com, form
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com: /v1/ API CONFIRMED discoverable via passive enum. 3 unauthenticated endpoints live (200/400/404); 15+ auth-gated endpoin
- LEARN: REJECTED AUTH @ api.sparelabs.com: Previous "auth not challengeable" hypothesis PARKED — edge properly returns 401 for auth-gated routes; new finding is the una
- LEARN: REJECTED MISCONFIG @ forms.sparelabs.com: Object-store directory listing hypothesis PARKED — traffic served via envoy+Google CDN (not raw object store); SPA cat
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; no disco

## RANKED HYPOTHESES 2026-08-07 20:57:44 UTC
- [95] api.sparelabs.com/v1/**: api.sparelabs.com CORS reflect-any-origin with credentials on entire /v1 API surface (from reports/hypotheses-nemotron3.txt)
- NEXT(hypotheses-nemotron3.txt): AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with `access-control-
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on all /v1 endpoints (including auth-gated) via live probe
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/*: Endpoints return response data (terms URLs, org list, org existence) despite 401 status code — misleading st
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking staging admin apps (2x Vercel) and Metabase; all three staging hosts re
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com: Leaked staging API hosts return 404 behind same envoy gateway — no independent API surface
- LEARN: REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
- LEARN: ACCEPTED MISCONFIG @ forms.staging.sparelabs.com / forms.staging.us.sparelabs.com: Staging forms portals live (200, same SPA catch-all behind envoy+Google CDN)

## RANKED HYPOTHESES 2026-08-07 21:47:25 UTC
- [95] api.sparelabs.com/v1/**: api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (from reports/hypotheses-nemotron3.txt)
- [95] api.sparelabs.com: api.sparelabs.com: CORS reflect-any-origin with credentials + all methods + Authorization header on /v1 API (from reports/hypotheses-laguna.txt)
- NEXT(hypotheses-nemotron3.txt): AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with `access-control-
- NEXT(hypotheses-laguna.txt): PROBE: GET https://api.sparelabs.com/v1/journeys/requests — verify if this auth-gated endpoint also reflects CORS credentials on OPTIONS preflight (escalation p
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on all /v1 endpoints (including auth-gated) via live probe
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/*: Endpoints return response data (terms URLs, org list, org existence) despite 401 status code — misleading st
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking staging admin apps (2x Vercel) and Metabase; all three staging hosts re
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com: Leaked staging API hosts return 404 behind same envoy gateway — no independent API surface
- LEARN: REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
- LEARN: ACCEPTED MISCONFIG @ forms.staging.sparelabs.com / forms.staging.us.sparelabs.com: Staging forms portals live (200, same SPA catch-all behind envoy+Google CDN)
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; no disco
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com: CORS preflight confirms full credential reflection — any malicious origin can issue authenticated GET/PUT/PATCH/POST/DEL
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 malformed, 404 not-found, 200 found) with full OpenAPI Val
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Returns live termsOfUseUrl + privacyPolicyUrl without authentication — unauthenticated data disclosure
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: Returns 200 with {"data":[]} and reflected CORS+credentials — auth state inconsistent (was 401 a
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all paths return 404; no surface
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle rotated (main.6ed467ae.js → main.71d52314.js) but same staging+prod infra leak persists
- LEARN: REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
- LEARN: ACCEPTED MISCONFIG @ api.staging.sparelabs.com: Staging API hosts return 404 — no independent API surface

## RANKED HYPOTHESES 2026-08-07 22:08:24 UTC
- [95] api.sparelabs.com/v1/**: api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (from reports/hypotheses-nemotron3.txt)
- [95] api.sparelabs.com: api.sparelabs.com: CORS reflect-any-origin with credentials on /v1 API (from reports/hypotheses-laguna.txt)
- [50] api.sparelabs.com/v1/global/organizations: Auth-gate flapping on /v1/global/organizations (and possibly siblings) — fail-open window for unauth data disclosure (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with `access-control-
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on all /v1 endpoints (including auth-gated) via live probe
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/*: Endpoints return response data (terms URLs, org list, org existence) despite 401 status code — misleading st
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking staging admin apps (2x Vercel) and Metabase; all three staging hosts re
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com: Leaked staging API hosts return 404 behind same envoy gateway — no independent API surface
- LEARN: REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
- LEARN: ACCEPTED MISCONFIG @ forms.staging.sparelabs.com / forms.staging.us.sparelabs.com: Staging forms portals live (200, same SPA catch-all behind envoy+Google CDN)
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; no disco
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com: CORS preflight confirms full credential reflection — any malicious origin can issue authenticated GET/PUT/PATCH/POST/DEL
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 malformed, 404 not-found, 200 found) with full OpenAPI Val
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Returns live termsOfUseUrl + privacyPolicyUrl without authentication — unauthenticated data disclosure
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: Returns 200 with {"data":[]} and reflected CORS+credentials — auth state inconsistent (was 401 a
- LEARN: REJECTED MISCONFIG @ api-staking.sparelabs.com: Staging API hosts return 404 — no independent API surface
- LEARN: REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)

## RANKED HYPOTHESES 2026-08-07 22:55:14 UTC
- [95] api.sparelabs.com/v1/**: api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (from reports/hypotheses-nemotron3.txt)
- [95] api.sparelabs.com: api.sparelabs.com CORS reflect-any-origin with credentials on /v1 API enables cross-origin authenticated reads+writes (from reports/hypotheses-laguna.txt)
- [55] api.sparelabs.com/v1/global/organizations: Route-level auth omission on /v1/global/* (confirmed fail-open, data-bearing unproven) (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with `access-control-
- NEXT(hypotheses-bigpickle.txt): PROBE: GET https://api.sparelabs.com/v1/global/settings and /v1/global/regions (2 req, spaced ≥1.2s, ≤1 rps) — 401-vs-200 differential against /v1/journeys/requ
- NEXT(hypotheses-laguna.txt): PROBE: Poll `GET https://api.sparelabs.com/v1/global/organizations` at 5s intervals (≤1 rps) for 60s — characterize the auth-gate flap timing (when does it retu
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on all /v1 endpoints (including auth-gated) via live probe
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/*: Endpoints return response data (terms URLs, org list, org existence) despite 401 status code — misleading st
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking staging admin apps (2x Vercel) and Metabase; all three staging hosts re
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com: Leaked staging API hosts return 404 behind same envoy gateway — no independent API surface
- LEARN: REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
- LEARN: ACCEPTED MISCONFIG @ forms.staging.sparelabs.com / forms.staging.us.sparelabs.com: Staging forms portals live (200, same SPA catch-all behind envoy+Google CDN)
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; no disco
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: fail-open now STABLE — 200 ×6 across ~2h incl. pagination variants (params ignored, hardcoded `{"data
- LEARN: REJECTED BUSLOGIC @ api.sparelabs.com: CORS reflect-any-origin+credentials re-confirmed on all /v1 (401, 404, and 200 paths) — uniformly applied API-scoped midd
