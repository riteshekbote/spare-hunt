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

## RANKED HYPOTHESES 2026-08-07 23:27:19 UTC
- [95] api.sparelabs.com/v1/**: api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (from reports/hypotheses-nemotron3.txt)
- [95] api.sparelabs.com: api.sparelabs.com CORS reflects any Origin with credentials on entire /v1 API (authenticated reads+writes via malicious origin) (from reports/hypotheses-laguna.txt)
- NEXT(hypotheses-nemotron3.txt): AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with `access-control-
- NEXT(hypotheses-laguna.txt): PROBE: Poll `GET https://api.sparelabs.com/v1/global/organizations` at 5s intervals (≤1 rps) for 60s — characterize whether the fail-open 200 persists or interm
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on all /v1 endpoints (including auth-gated) via live probe
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/*: Endpoints return response data (terms URLs, org list, org existence) despite 401 status code — misleading st
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking staging admin apps (2x Vercel) and Metabase; all three staging hosts re
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com: Leaked staging API hosts return 404 behind same envoy gateway — no independent API surface
- LEARN: REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
- LEARN: ACCEPTED MISCONFIG @ forms.staging.sparelabs.com / forms.staging.us.sparelabs.com: Staging forms portals live (200, same SPA catch-all behind envoy+Google CDN)
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; no disco
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: fail-open now STABLE — 200 ×6 across ~2h incl. pagination variants (params ignored, hardcoded `{"data
- LEARN: REJECTED BUSLOGIC @ api.sparelabs.com: CORS reflect-any-origin+credentials re-confirmed on all /v1 (401, 404, and 200 paths) — uniformly applied API-scoped midd
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on OPTIONS preflight + GET responses for all /v1 endpoints (met
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open confirmed STABLE (200 + `{"data":[]}` + credentials across 6+ samples over ~2h), not f
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 ValidationError for malformed, 404 NotFoundError for valid
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; envoy 404 on all paths, n
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com: staging API hosts return 404 behind envoy gateway, no independent API surface

## RANKED HYPOTHESES 2026-08-07 23:59:36 UTC
- [95] api.sparelabs.com/v1/**: api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (from reports/hypotheses-nemotron3.txt)
- [95] api.sparelabs.com: api.sparelabs.com /v1/** CORS credential reflection enables cross-origin authenticated reads/writes (from reports/hypotheses-laguna.txt)
- [75] api.sparelabs.com/v1/global/organizations: Organizations controller-wide auth omission on /v1/global/organizations (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with access-control-a
- NEXT(hypotheses-laguna.txt): PROBE: Enumerate additional /v1/ endpoints (GET /v1/riders, GET /v1/organizations, GET /v1/global/settings, GET /v1/global/regions) at ≤1 rps — each with `Origi
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on OPTIONS preflight + GET responses for all /v1 endpoints (met
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-rou
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 ValidationError for malformed, 404 NotFoundError for valid
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com: staging API hosts return 404 behind envoy gateway, no independent API surface
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; envoy 404 on all paths, n
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com /login: CSP now confirmed leaking production admin app hosts (admin-eam-app.vercel.app, admin-fixed-route-app.vercel
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/**: CORS credential reflection confirmed stable across all scan intervals (OPTIONS preflight + GET on 401/404/200 pat
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: All /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404 — envoy gateway, no surfac

## RANKED HYPOTHESES 2026-08-08 01:03:13 UTC
- [95] api.sparelabs.com/v1/**: api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (from reports/hypotheses-nemotron3.txt)
- [95] api.sparelabs.com: api.sparelabs.com CORS reflect-any-origin with credentials on entire /v1 API (from reports/hypotheses-laguna.txt)
- [70] api.sparelabs.com/v1/global/organizations: Unauthenticated write exposure on /v1/global/organizations controller (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with access-control-a
- NEXT(hypotheses-bigpickle.txt): PROBE: OPTIONS preflight (Origin: https://evil.example, ACRM: POST, ACRH: authorization) on `https://api.sparelabs.com/v1/global/organizations/key/x` → then GET
- NEXT(hypotheses-laguna.txt): PROBE: At ≤1 rps (≥1.2s spacing), sweep additional /v1 controllers with Origin header to find sibling route-level auth omissions: GET https://api.sparelabs.com/
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on OPTIONS preflight + GET responses for all /v1 endpoints (met
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-rou
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 ValidationError for malformed, 404 NotFoundError for valid
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com: staging API hosts return 404 behind envoy gateway, no independent API surface
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; envoy 404 on all paths, n

## RANKED HYPOTHESES 2026-08-08 03:06:00 UTC
- [95] api.sparelabs.com/v1/**: api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (from reports/hypotheses-nemotron3.txt)
- [95] api.sparelabs.com: api.sparelabs.com /v1/**: CORS reflect-any-origin with credentials on entire /v1 API (from reports/hypotheses-laguna.txt)
- [85] api.sparelabs.com/v1/global/organizations: Organizations controller-wide auth omission confirmed via bracketed differential (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with access-control-a
- NEXT(hypotheses-laguna.txt): AUTH_HELPED: With an authorized api.sparelabs.com session (Bearer token in `Authorization`), run `curl -s -H "Origin: https://evil.example.com" -H "Authorizatio
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on OPTIONS preflight + GET responses for all /v1 endpoints (met
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-rou
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 ValidationError for malformed, 404 NotFoundError for valid
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com: staging API hosts return 404 behind envoy gateway, no independent API surface
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; envoy 404 on all paths, n
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/**: Live OPTIONS this session re-confirms `access-control-allow-origin:<reflected>` + `access-control-allow-credentia
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/global/organizations: Live GET this session re-confirms 200 + `{"data":[]}` + CORS credentials — fail-open STABLE (no
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/generic/regions: Live GET returns 400 (param validation gate active) + CORS credentials — auth enforced, NOT fail-ope
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com /login: Live GET confirms 200 + CSP still leaking production admin Vercel hosts (admin-eam-app.vercel.app, admin-fix
- LEARN: REJECTED BUSLOGIC @ api.sparelabs.com: Sibling sweep (/v1/organizations, /v1/riders, /v1/global/settings) all 401 + CORS → NO sibling route-level auth omission 
- LEARN: REJECTED MISCONFIG @ routing.sparelabs.com: No re-probe delta; envoy 404 across all paths — remains dead.
- LEARN: REJECTED MISCONFIG @ forms.staging.sparelabs.com, api.staging.sparelabs.com, api-spare.ngrok.io, api-staking.sparelabs.com: No re-probe delta — staging hosts 40

## RANKED HYPOTHESES 2026-08-08 04:16:26 UTC
- [95] api.sparelabs.com/v1/**: api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (from reports/hypotheses-nemotron3.txt)
- [60] api.sparelabs.com/v1/global/organizations: Write-method exposure on auth-free organizations controller (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with access-control-a
- NEXT(hypotheses-bigpickle.txt): HUMAN: With an authorized Bearer token, PUT invalid-body JSON to `https://api.sparelabs.com/v1/global/organizations/00000000-0000-0000-0000-000000000000` and `/
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on OPTIONS preflight + GET responses for all /v1 endpoints (met
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-rou
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 ValidationError for malformed, 404 NotFoundError for valid
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com: staging API hosts return 404 behind envoy gateway, no independent API surface
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; envoy 404 on all paths, n
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: controller-scoped auth omission re-confirmed live — list 200 `{"data":[]}`, key/{any} 404, zones/cent
- LEARN: REJECTED BUSLOGIC @ api.sparelabs.com/v1/global/organizations/key/: NOT an enumeration oracle — every key string returns identical 404 NotFoundError (no format 
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/zones/centroid: bundle-derived path is not a live route (400 "not found") — its auth-free 400 sti

## RANKED HYPOTHESES 2026-08-08 05:10:34 UTC
- [96] api.sparelabs.com: api.sparelabs.com /v1/** credential-reflecting CORS (from reports/hypotheses-laguna.txt)
- [95] api.sparelabs.com/v1/**: api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (from reports/hypotheses-nemotron3.txt)
- NEXT(hypotheses-nemotron3.txt): AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with access-control-a
- NEXT(hypotheses-laguna.txt): PROBE: HUMAN — With an authorized api.sparelabs.com session (Bearer token in Authorization), run curl -s -H "Origin: https://evil.example.com" -H "Authorization
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on OPTIONS preflight + GET responses for all /v1 endpoints (met
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-rou
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 ValidationError for malformed, 404 NotFoundError for valid
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com: staging API hosts return 404 behind envoy gateway, no independent API surface
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; envoy 404 on all paths, n
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: controller-scoped auth omission re-confirmed live — list 200 `{"data":[]}`, key/{any} 404, zones/cent
- LEARN: REJECTED BUSLOGIC @ api.sparelabs.com/v1/global/organizations/key/: NOT an enumeration oracle — every key string returns identical 404 NotFoundError (no format 
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/zones/centroid: bundle-derived path is not a live route (400 "not found") — its auth-free 400 sti
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/**: Live OPTIONS this session re-confirms ACAO:<reflected> + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + hea
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/global/organizations: Live GET this session re-confirms 200 + {"data":[]} + CORS credentials — fail-open STABLE (11B 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/public/terms: Live GET with organizationId returns 200 + live terms URLs (termsOfUseUrl+privacyPolicyUrl+serviceTerms
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com /login: Live GET confirms 200 + CSP leaks production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-route-
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js confirmed leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.
- LEARN: REJECTED MISCONFIG @ api.us.sparelabs.com: OOS subdomain (per scope exclusions) with identical CORS profile to api.sparelabs.com — surfaced only via in-scope fo
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: No re-probe delta; envoy 404 across all /v1/,/api/,/routing/,/router,/v2/,/graphql/,/map/,/directions/ — CONFIRMED de
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com, api.staging.us.sparelabs.com, api-spare.ngrok.io, api-staking.sparelabs.com: No re-probe delta — staging API hos

## RANKED HYPOTHESES 2026-08-08 06:00:08 UTC
- [96] api.sparelabs.com: api.sparelabs.com /v1/** credential-reflecting CORS (from reports/hypotheses-laguna.txt)
- [95] api.sparelabs.com/v1/**: api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (from reports/hypotheses-nemotron3.txt)
- NEXT(hypotheses-nemotron3.txt): AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with access-control-a
- NEXT(hypotheses-laguna.txt): PROBE: HUMAN — With an authorized api.sparelabs.com session (Bearer token in Authorization), run `curl -s -H "Origin: https://evil.example.com" -H "Authorizatio
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on OPTIONS preflight + GET responses for all /v1 endpoints (met
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-rou
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 ValidationError for malformed, 404 NotFoundError for valid
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com: staging API hosts return 404 behind envoy gateway, no independent API surface
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; envoy 404 on all paths, n
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: controller-scoped auth omission re-confirmed live — list 200 `{"data":[]}`, key/{any} 404, zones/cent
- LEARN: REJECTED BUSLOGIC @ api.sparelabs.com/v1/global/organizations/key/: NOT an enumeration oracle — every key string returns identical 404 NotFoundError (no format 
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/zones/centroid: bundle-derived path is not a live route (400 "not found") — its auth-free 400 sti
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/**: Live OPTIONS this session re-confirms ACAO:<reflected> + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + hea
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/global/organizations: Live GET this session re-confirms 200 + {"data":[]} + CORS credentials — fail-open STABLE (11B 
- LEARN: NEW: api.sparelabs.com /v1/public/terms?mobileAppId=<uuid>: Returns 200 with live terms URLs + reflected CORS credentials without auth — new parameter vector on
- LEARN: CHANGED: api.sparelabs.com /v1/public/terms?organizationId=<uuid>: Behavior now flapping between 200+data and 400 validation error — inconsistent parameter hand
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com /login: CSP confirmed STABLE — still leaking production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-rou
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: No re-probe delta; envoy 404 across all paths — remains dead.
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com, api.staging.us.sparelabs.com, api-spare.ngrok.io, api-staking.sparelabs.com: No re-probe delta — staging API hos

## RANKED HYPOTHESES 2026-08-08 06:38:30 UTC
- [95] api.sparelabs.com/v1/**: api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (from reports/hypotheses-nemotron3.txt)
- [70] api.sparelabs.com/v1/global/*: Data-bearing auth-free routes on /v1/global controller beyond /regions (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with access-control-a
- NEXT(hypotheses-bigpickle.txt): PROBE: GET `/v1/global/{countries,currencies,fares,tariffs,zones,settings/regions}` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on OPTIONS preflight + GET responses for all /v1 endpoints (met
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-rou
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 ValidationError for malformed, 404 NotFoundError for valid
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com: staging API hosts return 404 behind envoy gateway, no independent API surface
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; envoy 404 on all paths, n
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: controller-scoped auth omission re-confirmed live — list 200 `{"data":[]}`, key/{any} 404, zones/cent
- LEARN: REJECTED BUSLOGIC @ api.sparelabs.com/v1/global/organizations/key/: NOT an enumeration oracle — every key string returns identical 404 NotFoundError (no format 
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/zones/centroid: bundle-derived path is not a live route (400 "not found") — its auth-free 400 sti
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: auth-free DATA-BEARING — 200 + 725B region registry (CA/US/US2/US3/JP/EU/UAT + apiUrl + routingHost) with a
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free route-registered-not-implemented (no InvalidTokenError) — controller-wide omission 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organizations: 400 auth-free "not found" — new router path on public namespace.
- LEARN: ACCEPTED BUSLOGIC @ api.sparelabs.com: multi-version LB behind envoy re-confirmed — /v1/public/terms?organizationId flapped 401→200 in ~35min; fail-open route s
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/generic/regions: garbage token → 404 empty (not data-bearing) — generic namespace does not mirror the global controller's o

## RANKED HYPOTHESES 2026-08-08 07:34:28 UTC
- [90] api.sparelabs.com/v1/global/*: api.sparelabs.com/v1/global/* controller-wide auth omission exposes data-bearing routes (from reports/hypotheses-nemotron3.txt)
- [75] api.sparelabs.com/v1/global/regions: Route-scoped auth omission set on /v1/global — data-bearing only at /regions, write methods advertised auth-free (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET `/v1/global/{countries,currencies,fares,tariffs,zones,settings/regions}` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced 
- NEXT(hypotheses-bigpickle.txt): PROBE: `curl -X OPTIONS https://api.sparelabs.com/v1/global/regions/00000000-0000-0000-0000-000000000000` — preflight this session 204-advertises PUT/PATCH/POST
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: auth-free DATA-BEARING — 200 + 725B region registry (CA/US/US2/US3/JP/EU/UAT + apiUrl + routingHost) with a
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free route-registered-not-implemented (no InvalidTokenError) — controller-wide omission 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organizations: 400 auth-free "not found" — new router path on public namespace
- LEARN: ACCEPTED BUSLOGIC @ api.sparelabs.com: multi-version LB behind envoy re-confirmed — /v1/public/terms?organizationId flapped 401→200 in ~35min; fail-open route s
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/generic/regions: garbage token → 404 empty (not data-bearing) — generic namespace does not mirror the global controller's o

## RANKED HYPOTHESES 2026-08-08 08:12:41 UTC
- [96] api.sparelabs.com: api.sparelabs.com /v1/** credential-reflecting CORS across entire API (from reports/hypotheses-laguna.txt)
- [90] api.sparelabs.com/v1/global/*: api.sparelabs.com/v1/global/* controller-wide auth omission exposes additional data-bearing routes (from reports/hypotheses-nemotron3.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET `/v1/global/{countries,currencies,fares,tariffs,zones,settings/regions}` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced 
- NEXT(hypotheses-laguna.txt): HUMAN: With an authorized api.sparelabs.com session Bearer token, run `curl -s -H "Origin: https://evil.example.com" -H "Authorization: Bearer <token>" -H "Acce
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: auth-free DATA-BEARING — 200 + 725B region registry (CA/US/US2/US3/JP/EU/UAT + apiUrl + routingHost) with a
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free route-registered-not-implemented (no InvalidTokenError) — controller-wide omission 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organizations: 400 auth-free "not found" — new router path on public namespace
- LEARN: ACCEPTED BUSLOGIC @ api.sparelabs.com: multi-version LB behind envoy re-confirmed — /v1/public/terms?organizationId flapped 401→200 in ~35min; fail-open route s
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/generic/regions: garbage token → 404 empty (not data-bearing) — generic namespace does not mirror the global controller's o
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/**: CORS credential reflection remains STABLE across all intervals — ACAO:<reflected> + ACAC:true + methods GET,HEAD,
- LEARN: ACCEPTED AUTH @ api.sparelabs.com /v1/global/regions: auth-free DATA-BEARING confirmed STABLE — 200 + 725B region registry with any garbage Bearer; header prese
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/global/organizations: controller-scoped auth omission STABLE — 200 + `{"data":[]}` + CORS, control /v1/journeys still
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com /login: CSP leak STABLE — production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-route-app.vercel.app) 
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.s
- LEARN: REJECTED MISCONFIG @ routing.sparelabs.com: No surface — remain dead, envoy 404 across all paths
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com, api.staging.us.sparelabs.com, api-spare.ngrok.io, api-staking.sparelabs.com: All 404/inactive (ERR_NGROK_3200) —

## RANKED HYPOTHESES 2026-08-08 09:01:29 UTC
- [96] api.sparelabs.com: api.sparelabs.com /v1/**: credential-reflecting CORS across entire API (from reports/hypotheses-laguna.txt)
- [90] api.sparelabs.com/v1/global/*: api.sparelabs.com/v1/global/* controller-wide auth omission exposes additional data-bearing routes (from reports/hypotheses-nemotron3.txt)
- [55] api.sparelabs.com/v1/global/regions/{id}/zones,: Implemented-but-auth-free read siblings on the global controller (fail-open replica route table) (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET `/v1/global/{countries,currencies,fares,tariffs,zones,settings/regions}` with `Authorization: Bearer x` + `Origin: https://evil.example.com`, spaced 
- NEXT(hypotheses-bigpickle.txt): PROBE: GET `/v1/global/regions/00000000-0000-0000-0000-000000000000/zones` then `/v1/global/config`, `/v1/global/regions/CA`, `/v1/global/features` with `Author
- NEXT(hypotheses-laguna.txt): PROBE: GET `https://api.sparelabs.com/v1/global/{countries,currencies,fares,tariffs,zones,settings}` with `Authorization: Bearer x` + `Origin: https://evil.exam
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: auth-free DATA-BEARING — 200 + 725B region registry (CA/US/US2/US3/JP/EU/UAT + apiUrl + routingHost) with a
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free route-registered-not-implemented (no InvalidTokenError) — controller-wide omission 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organizations: 400 auth-free "not found" — new router path on public namespace
- LEARN: ACCEPTED BUSLOGIC @ api.sparelabs.com: multi-version LB behind envoy re-confirmed — /v1/public/terms?organizationId flapped 401→200 in ~35min; fail-open route s
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/generic/regions: garbage token → 404 empty (not data-bearing) — generic namespace does not mirror the global controller's o
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/**: CORS credential reflection remains STABLE across all intervals — ACAO:<reflected> + ACAC:true + methods GET,HEAD,
- LEARN: ACCEPTED AUTH @ api.sparelabs.com /v1/global/regions: auth-free DATA-BEARING confirmed STABLE — 200 + 725B region registry with any garbage Bearer; header prese
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/global/organizations: controller-scoped auth omission STABLE — 200 + `{"data":[]}` + CORS, control /v1/journeys still
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com /login: CSP leak STABLE — production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-route-app.vercel.app) 
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.s
- LEARN: REJECTED MISCONFIG @ routing.sparelabs.com: No surface — remain dead, envoy 404 across all paths
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com, api.staging.us.sparelabs.com, api-spare.ngrok.io, api-staking.sparelabs.com: All 404/inactive (ERR_NGROK_3200) —
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/**: CORS credential reflection remains STABLE across all intervals — ACAO:<reflected> + ACAC:true + methods GET,HEAD,
- LEARN: ACCEPTED AUTH @ api.sparelabs.com /v1/global/regions: auth-free DATA-BEARING confirmed STABLE — 200 + 725B region registry with any garbage Bearer; header prese
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com /v1/global/organizations: controller-scoped auth omission STABLE — 200 + `{"data":[]}` + CORS, control /v1/journeys still
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com /login: CSP leak STABLE — production admin Vercel apps + staging variants + Metabase + full infra list
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle STABLE — leaking staging+prod infra hosts + inactive ngrok tunnel
- LEARN: REJECTED BUSLOGIC @ routing.sparelabs.com: No surface — envoy 404 across all paths, remains dead
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com, api.staging.us.sparelabs.com, api-spare.ngrok.io, api-staking.sparelabs.com: All 404/inactive — remain dead

## RANKED HYPOTHESES 2026-08-08 09:37:43 UTC
- [50] platform.sparelabs.com/login: Module-federation manifest enumeration → new first-party /v1 paths (re-fetch rotated chunks) (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-bigpickle.txt): PROBE: GET `/v1/global/regions/00000000-0000-0000-0000-000000000000/zones` then `/v1/global/config`, `/v1/global/regions/CA`, `/v1/global/features` with `Author

## RANKED HYPOTHESES 2026-08-08 10:13:30 UTC
- [96] api.sparelabs.com: api.sparelabs.com /v1/**: credential-reflecting CORS across entire API (from reports/hypotheses-laguna.txt)
- [75] api.sparelabs.com/auth/rider/test/login,: Rider authentication bypass via test/login or PIN login endpoints (from reports/hypotheses-nemotron3.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: POST `https://api.sparelabs.com/auth/rider/test/login` with `Content-Type: application/json` body `{"phone":"+15551234567","code":"123456"}` and `Origin:
- NEXT(hypotheses-laguna.txt): PROBE: `GET https://api.sparelabs.com/v1/global/regions/00000000-0000-0000-0000-000000000000/zones`, `/v1/global/regions/CA`, `/v1/global/organizations?key=0000
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: auth-free DATA-BEARING confirmed STABLE — 200 + 725B region registry with any garbage Bearer; header presen
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free route-registered-not-implemented (no InvalidTokenError) — controller-wide omission 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organizations: 400 auth-free "not found" — new router path on public namespace
- LEARN: ACCEPTED BUSLOGIC @ api.sparelabs.com: multi-version LB behind envoy re-confirmed — /v1/public/terms?organizationId flapped 401→200 in ~35min; fail-open route s
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/generic/regions: garbage token → 404 empty (not data-bearing) — generic namespace does not mirror the global controller's o
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection remains STABLE across all intervals — ACAO:<reflected> + ACAC:true + methods GET,HEAD,P
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-route-app.vercel.app) +
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.s
- LEARN: REJECTED MISCONFIG @ routing.sparelabs.com: No surface — remain dead, envoy 404 across all paths
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com, api.staging.us.sparelabs.com, api-spare.ngrok.io, api-staking.sparelabs.com: All 404/inactive (ERR_NGROK_3200) —
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only auth bypass confirmed STABLE — 200 + 725B region registry (incl. 6 OOS regional api/routing hos
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: sibling sweep (this session) → 401 on all (prop
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection confirmed STABLE on OPTIONS preflight + GET (200/401/400 paths) uniformly across /v1 — 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open `200 + {"data":[]}` + CORS STABLE (empty payload caps severity; route-specific).
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: data disclosure flapped back to 200+live terms URLs (termsOfUseUrl+privacyPolicyUrl) with no auth + CORS
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id},organizations/key/{x}: auth-free (0 InvalidTokenError) but **not data-bearing** (400/404, 0-byte b
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — prod admin-eam-app + admin-fixed-route-app (vercel.app, loadable) + staging variants + Meta
- LEARN: REJECTED MISCONFIG @ admin-spare.ngrok.io: OOS — now ngrok-edge 404 (was ERR_NGROK_3200 inactive); no independent in-scope exploitation vector; marked dead/OOS.

## RANKED HYPOTHESES 2026-08-08 10:50:59 UTC
- [96] api.sparelabs.com: Credential-reflecting CORS across entire /v1 API surface (from reports/hypotheses-laguna.txt)
- [90] api.sparelabs.com/v1/global/*: Controller-wide auth omission on /v1/global/* exposes additional data-bearing routes (from reports/hypotheses-nemotron3.txt)
- [55] platform.sparelabs.com/login: Module-federation manifest enumeration → new first-party /v1 paths (re-fetch rotated chunks) (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET `https://api.sparelabs.com/v1/global/countries` with `Authorization: Bearer x` and `Origin: https://evil.example.com`; capture status, body, CORS hea
- NEXT(hypotheses-bigpickle.txt): PROBE: GET `/v1/global/regions/00000000-0000-0000-0000-000000000000/zones` then `/v1/global/config`, `/v1/global/regions/CA`, `/v1/global/features` with `Author
- NEXT(hypotheses-laguna.txt): PROBE: `curl -s -o /dev/null -w '%{http_code}\n' -H "Origin: https://evil.example.com" -H "Authorization: Bearer x" https://api.sparelabs.com/v1/global/regions`
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: auth-free DATA-BEARING confirmed STABLE — 200 + 725B region registry with any garbage Bearer; header presen
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free route-registered-not-implemented (no InvalidTokenError) — controller-wide omission 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organizations: 400 auth-free "not found" — new router path on public namespace
- LEARN: ACCEPTED BUSLOGIC @ api.sparelabs.com: multi-version LB behind envoy re-confirmed — /v1/public/terms?organizationId flapped 401→200 in ~35min; fail-open route s
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/generic/regions: garbage token → 404 empty (not data-bearing) — generic namespace does not mirror the global controller's o
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection remains STABLE across all intervals — ACAO:<reflected> + ACAC:true + methods GET,HEAD,P
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-route-app.vercel.app) +
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.s
- LEARN: REJECTED MISCONFIG @ routing.sparelabs.com: No surface — remain dead, envoy 404 across all paths
- LEARN: REJECTED MISCONFIG @ api.staging.sparelabs.com, api.staging.us.sparelabs.com, api-spare.ngrok.io, api-staking.sparelabs.com: All 404/inactive (ERR_NGROK_3200) —
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only auth bypass confirmed STABLE — 200 + 725B region registry (incl. 6 OOS regional api/routing hos
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: sibling sweep (this session) → 401 on all (prop
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection confirmed STABLE on OPTIONS preflight + GET (200/401/400 paths) uniformly across /v1 — 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open `200 + {"data":[]}` + CORS STABLE (empty payload caps severity; route-specific).
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: data disclosure flapped back to 200+live terms URLs (termsOfUseUrl+privacyPolicyUrl) with no auth + CORS
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id},organizations/key/{x}: auth-free (0 InvalidTokenError) but **not data-bearing** (400/404, 0-byte b
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — prod admin-eam-app + admin-fixed-route-app (vercel.app, loadable) + staging variants + Meta
- LEARN: REJECTED MISCONFIG @ admin-spare.ngrok.io: OOS — now ngrok-edge 404 (was ERR_NGROK_3200 inactive); no independent in-scope exploitation vector; marked dead/OOS.
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: all 401 with garbage Bearer — auth omission doe
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free 0B — registered-not-implemented route, omission is route-registration-level not exp
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/generic/regions: garbage Bearer → 404 empty 0B — generic namespace does not mirror global controller's auth omission.
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only bypass confirmed STABLE — `Bearer x` → 200 + 725B region registry; no-Auth → 400 "header requir
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms?mobileAppId=<uuid>: new parameter vector returns 200 + live terms URLs without auth + CORS — data disclos

## RANKED HYPOTHESES 2026-08-08 11:14:26 UTC
- [95] api.sparelabs.com/v1/global/regions: Auth-free data-bearing region registry with infrastructure topology disclosure (from reports/hypotheses-nemotron3.txt)
- [55] api.sparelabs.com/v1/auth/email/reset/{request,verify}: Unauthenticated email-reset chain → ATO / reset-email abuse (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET `https://api.sparelabs.com/v1/global/regions` with `Authorization: Bearer x` and `Origin: https://evil.example.com`; capture status, body, CORS heade
- NEXT(hypotheses-bigpickle.txt): HUMAN: request from the program a test organization UUID + test user email + test rider credentials (no self-signup). Sequence: (1) POST /v1/auth/email/reset/re
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only auth bypass confirmed STABLE — 200 + 725B region registry with any `Bearer x`; no-Auth→400 "hea
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — production admin Vercel apps + staging variants + Metabase prod+staging (200) + full infra 
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: all 401 with garbage Bearer — auth omission rou
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id},organizations/key/{x}: auth-free (0 InvalidTokenError) but not data-bearing (400/404, 0-byte bodie
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms?mobileAppId=<uuid>: new parameter vector returns 200 + live terms URLs without auth + CORS
- LEARN: REJECTED MISCONFIG @ admin-spare.ngrok.io: OOS — ngrok-edge 404; no independent in-scope exploitation vector

## RANKED HYPOTHESES 2026-08-08 11:51:10 UTC
- [96] api.sparelabs.com: Credential-reflecting CORS across entire /v1 API surface with auth-bypassed data-bearing routes (from reports/hypotheses-laguna.txt)
- [95] api.sparelabs.com/v1/global/regions: Auth-free data-bearing region registry with infrastructure topology disclosure (from reports/hypotheses-nemotron3.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET `https://api.sparelabs.com/v1/global/regions` with `Authorization: Bearer x` and `Origin: https://evil.example.com`; capture status, body, CORS heade
- NEXT(hypotheses-laguna.txt): PROBE: `curl -s -D - -o /dev/null -H "Origin: https://evil.example.com" -H "Authorization: Bearer x" "https://api.sparelabs.com/v1/global/regions"` and `curl -s
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only auth bypass confirmed STABLE — 200 + 725B region registry with any `Bearer x`; no-Auth→400 "hea
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — production admin Vercel apps + staging variants + Metabase prod+staging (200) + full infra 
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: all 401 with garbage Bearer — auth omission rou
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id},organizations/key/{x}: auth-free (0 InvalidTokenError) but not data-bearing (400/404, 0-byte bodie
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms?mobileAppId=<uuid>: new parameter vector returns 200 + live terms URLs without auth + CORS
- LEARN: REJECTED MISCONFIG @ admin-spare.ngrok.io: OOS — ngrok-edge 404; no independent in-scope exploitation vector
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:<reflected> + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:A
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only auth bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions incl. 6 OOS hosts); no-
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open STABLE — 200 + `{"data":[]}` + CORS with `Bearer x` (818ms upstream, slow replica); co
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: data disclosure STABLE — 200 + live terms URLs with `?mobileAppId=<uuid>` and `?organizationId=<uuid>` w
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle STABLE — malformed→400 ValidationError `must match format "uuid"`; valid-
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/email/reset/{request,verify}: Live GET returns 401 + CORS — auth-gated, not bypassable; bigpickle "unauthenticate
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/metadata: Live GET returns 401 + CORS — auth-gated, not bypassable.
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/rider/test/login: Live GET returns 401 + CORS — auth-gated, not bypassable.
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/token/superAdmin: Live GET returns 401 + CORS — auth-gated, not bypassable despite bundle leak.
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/key/{x}: 404 auth-free 0B — registered-not-implemented route, not data-bearing, not enumeration o
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free 0B — registered-not-implemented route, not data-bearing.
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — prod admin-eam-app + admin-fixed-route-app (vercel.app, loadable 200) + staging variants + 
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.s

## RANKED HYPOTHESES 2026-08-08 12:07:24 UTC
- [97] api.sparelabs.com/v1/**: Credential-reflecting CORS across entire /v1 API with uniform cred reflection (from reports/hypotheses-laguna.txt)
- [95] api.sparelabs.com/v1/global/regions: Auth-free data-bearing region registry with infrastructure topology disclosure (from reports/hypotheses-nemotron3.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET `https://api.sparelabs.com/v1/global/regions` with `Authorization: Bearer x` and `Origin: https://evil.example.com`; capture status, body, CORS heade
- NEXT(hypotheses-bigpickle.txt): PROBE: GET `https://api.sparelabs.com/v1/global/regions` with `Authorization: Bearer x` and `Origin: https://evil.example.com`; capture status, body, CORS heade
- NEXT(hypotheses-laguna.txt): PROBE: `curl -s -D - -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-ControlRequest-Method: DELETE" -H "Access-ControlRequestHeaders: Authorization,
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only auth bypass confirmed STABLE — 200 + 725B region registry with any `Bearer x`; no-Auth→400 "hea
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — production admin Vercel apps + staging variants + Metabase prod+staging (200) + full infra 
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: all 401 with garbage Bearer — auth omission rou
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id},organizations/key/{x}: auth-free (0 InvalidTokenError) but not data-bearing (400/404, 0-byte bodie
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms?mobileAppId=<uuid>: new parameter vector returns 200 + live terms URLs without auth + CORS
- LEARN: REJECTED MISCONFIG @ admin-spare.ngrok.io: OOS — ngrok-edge 404; no independent in-scope exploitation vector
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/email/reset/{request,verify}: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/token/superAdmin: Live GET returns 401 + CORS — auth-gated, not bypassable despite bundle leak
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only auth bypass confirmed STABLE — 200 + 725B region registry with any `Bearer x`; no-Auth→400 "hea
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — production admin Vercel apps + staging variants + Metabase prod+staging (200) + full infra 
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: all 401 with garbage Bearer — auth omission rou
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id},organizations/key/{x}: auth-free (0 InvalidTokenError) but not data-bearing (400/404, 0-byte bodie
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms?mobileAppId=<uuid>: new parameter vector returns 200 + live terms URLs without auth + CORS
- LEARN: REJECTED MISCONFIG @ admin-spare.ngrok.io: OOS — ngrok-edge 404; no independent in-scope exploitation vector
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:<reflected> + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:A
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only auth bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions incl. 6 OOS hosts); no-
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open STABLE — 200 + `{"data":[]}` + CORS with `Bearer x` (818ms upstream, slow replica); co
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: data disclosure STABLE — 200 + live terms URLs with `?mobileAppId=<uuid>` and `?organizationId=<uuid>` w
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle STABLE — malformed→400 ValidationError `must match format "uuid"`; valid-
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/email/reset/{request,verify}: Live GET returns 401 + CORS — auth-gated, not bypassable; bigpickle "unauthenticate
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/metadata: Live GET returns 401 + CORS — auth-gated, not bypassable.
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/rider/test/login: Live GET returns 401 + CORS — auth-gated, not bypassable.
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/token/superAdmin: Live GET returns 401 + CORS — auth-gated, not bypassable despite bundle leak.
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/key/{x}: 404 auth-free 0B — registered-not-implemented route, not data-bearing, not enumeration o
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free 0B — registered-not-implemented route, not data-bearing.
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — prod admin-eam-app + admin-fixed-route-app (vercel.app, loadable 200) + staging variants + 
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.s
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:https://evil.example.com + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DE
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions incl. 6 OOS api/routing host
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open STABLE — 200 + `{"data":[]}` + CORS (ACAO+ACAC) with `Bearer x`; OPTIONS 204 confirms 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: data disclosure STABLE — 200 + live terms URLs with `?mobileAppId=<uuid>` and `?organizationId=<uuid>` w

## RANKED HYPOTHESES 2026-08-08 13:13:27 UTC
- [95] api.sparelabs.com/v1/global/regions: Auth-free data-bearing region registry with infrastructure topology disclosure (from reports/hypotheses-nemotron3.txt)
- [50] api.sparelabs.com/v1/global/regions: Cross-origin write on auth-free data-bearing regions controller (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET `https://api.sparelabs.com/v1/global/regions` with `Authorization: Bearer x` and `Origin: https://evil.example.com`; capture status, body, CORS heade
- NEXT(hypotheses-bigpickle.txt): HUMAN: request from the program: one test organization UUID + explicit approval for a single write test. Sequence: (1) `GET /v1/global/organizations/{test-org-u
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:https://evil.example.com + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DE
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions incl. 6 OOS api/routing host
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open STABLE — 200 + `{"data":[]}` + CORS (ACAO+ACAC) with `Bearer x`; OPTIONS 204 confirms 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: data disclosure STABLE — 200 + live terms URLs with `?mobileAppId=<uuid>` and `?organizationId=<uuid>` w
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — prod admin-eam-app + admin-fixed-route-app (vercel.app, loadable 200) + staging variants + 
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.s
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/email/reset/{request,verify}: Live GET returns 401 + CORS — auth-gated, not bypassable; bigpickle "unauthenticate
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/metadata: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/rider/test/login: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/token/superAdmin: Live GET returns 401 + CORS — auth-gated, not bypassable despite bundle leak
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/key/{x}: 404 auth-free 0B — registered-not-implemented route, not data-bearing, not enumeration o
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free 0B — registered-not-implemented route, not data-bearing
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: all 401 with garbage Bearer — auth omission doe
- LEARN: REJECTED MISCONFIG @ admin-spare.ngrok.io: OOS — ngrok-edge 404; no independent in-scope exploitation vector

## RANKED HYPOTHESES 2026-08-08 13:56:04 UTC
- [95] api.sparelabs.com/v1/global/regions: Auth-free data-bearing region registry with infrastructure topology disclosure (from reports/hypotheses-nemotron3.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET `https://api.sparelabs.com/v1/global/regions` with `Authorization: Bearer x` and `Origin: https://evil.example.com`; capture status, body, CORS heade
- NEXT(hypotheses-laguna.txt): PROBE: `curl -s -D - -o /dev/null -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-ControlRequest-Method: DELETE" -H "Access-ControlRequestHeaders: A
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:<reflected> + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:A
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions incl. 6 OOS api/routing host
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open STABLE — 200 + `{"data":[]}` + CORS (ACAO+ACAC) with `Bearer x`; OPTIONS 204 confirms 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: data disclosure STABLE — 200 + live terms URLs with `?mobileAppId=<uuid>` and `?organizationId=<uuid>` w
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — prod admin-eam-app + admin-fixed-route-app (vercel.app, loadable 200) + staging variants + 
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.s
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/email/reset/{request,verify}: Live GET returns 401 + CORS — auth-gated, not bypassable; bigpickle "unauthenticate
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/metadata: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/rider/test/login: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/token/superAdmin: Live GET returns 401 + CORS — auth-gated, not bypassable despite bundle leak
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/key/{x}: 404 auth-free 0B — registered-not-implemented route, not data-bearing, not enumeration o
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free 0B — registered-not-implemented route, not data-bearing
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: all 401 with garbage Bearer — auth omission doe
- LEARN: REJECTED MISCONFIG @ admin-spare.ngrok.io: OOS — ngrok-edge 404; no independent in-scope exploitation vector
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — `access-control-allow-origin: https://evil.example.com` + `access-control-allo
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions incl. 6 OOS api/routing host
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open STABLE — 200 + `{"data":[]}` (11B) + CORS (ACAO+ACAC) with `Bearer x`; upstream 1160ms
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: data disclosure STABLE — 200 + live terms URLs (`termsOfUseUrl`+`privacyPolicyUrl`, 137B) with `?mobileA
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com /login: CSP leak STABLE — production admin Vercel apps (`admin-eam-app.vercel.app` + `admin-fixed-route-app.vercel.a

## RANKED HYPOTHESES 2026-08-08 14:26:37 UTC
- [95] api.sparelabs.com/v1/global/regions: Scheme-only auth bypass yields unauthenticated region-registry disclosure with OOS infra topology (from reports/hypotheses-laguna.txt)
- [95] api.sparelabs.com/v1/global/regions: Auth-free data-bearing region registry with infrastructure topology disclosure (from reports/hypotheses-nemotron3.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET `https://api.sparelabs.com/v1/global/regions` with `Authorization: Bearer x` and `Origin: https://evil.example.com`; capture status, body, CORS heade
- NEXT(hypotheses-laguna.txt): PROBE: `curl -s -D - -o /dev/null -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-ControlRequest-Method: DELETE" -H "Access-ControlRequestHeaders: A
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:<reflected> + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:A
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions incl. 6 OOS api/routing host
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open STABLE — 200 + `{"data":[]}` (11B) + CORS (ACAO+ACAC) with `Bearer x`; upstream 1160ms
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: data disclosure STABLE — 200 + live terms URLs (`termsOfUseUrl`+`privacyPolicyUrl`, 137B) with `?mobileA
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — production admin Vercel apps (`admin-eam-app.vercel.app` + `admin-fixed-route-app.vercel.ap
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/email/reset/{request,verify}: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/metadata: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/rider/test/login: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/token/superAdmin: Live GET returns 401 + CORS — auth-gated, not bypassable despite bundle leak
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/key/{x}: 404 auth-free 0B — registered-not-implemented route, not data-bearing, not enumeration o
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free 0B — registered-not-implemented route, not data-bearing
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: all 401 with garbage Bearer — auth omission doe
- LEARN: REJECTED MISCONFIG @ admin-spare.ngrok.io: OOS — ngrok-edge 404; no independent in-scope exploitation vector
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — `access-control-allow-origin: https://evil.example.com` + `access-control-allo
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions incl. 6 OOS api/routing host
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open STABLE — 200 + `{"data":[]}` (11B) + CORS (ACAO+ACAC) with `Bearer x`; OPTIONS 204 con
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: data disclosure STABLE — 200 + live terms URLs (`termsOfUseUrl`+`privacyPolicyUrl`, 137B) with `?mobileA
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com /login: CSP leak STABLE — production admin Vercel apps (`admin-eam-app.vercel.app` + `admin-fixed-route-app.vercel.a
- LEARN: ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle main.71d52314.js STABLE — leaking api.staging.sparelabs.com + api.staging.us.sparelabs.com + forms.staging.s
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/email/reset/{request,verify}: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/metadata: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/rider/test/login: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/token/superAdmin: Live GET returns 401 + CORS — auth-gated, not bypassable despite bundle leak
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/key/{x}: 404 auth-free 0B — registered-not-implemented route, not data-bearing, not enumeration o
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free 0B — registered-not-implemented route, not data-bearing
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: all 401 with garbage Bearer — auth omission doe
- LEARN: REJECTED MISCONFIG @ admin-spare.ngrok.io: OOS — ngrok-edge 404; no independent in-scope exploitation vector
- LEARN: REJECTED MISCONFIG @ routing.sparelabs.com: envoy 404 across all paths — remains dead, no surface

## RANKED HYPOTHESES 2026-08-08 14:59:50 UTC
- [97] api.sparelabs.com/v1/**: Credential-reflecting CORS with full method surface on entire /v1 API (no-auth) (from reports/hypotheses-laguna.txt)
- [95] api.sparelabs.com/v1/global/regions: Scheme-only auth bypass on /v1/global/regions yields unauthenticated infrastructure topology (from reports/hypotheses-nemotron3.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET `https://api.sparelabs.com/v1/global/regions` with `Authorization: Bearer x` and `Origin: https://evil.example.com`; capture status, body, CORS heade
- NEXT(hypotheses-laguna.txt): PROBE: `curl -s -D - -o /dev/null -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-ControlRequest-Method: PUT" -H "Access-ControlRequestHeaders: Auth
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions incl. 6 OOS api/routing host
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:<reflected> + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:A
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open STABLE — 200 + `{"data":[]}` (11B) + CORS (ACAO+ACAC) with `Bearer x`; upstream 1160ms
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: data disclosure STABLE — 200 + live terms URLs (`termsOfUseUrl`+`privacyPolicyUrl`, 137B) with `?mobileA
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — production admin Vercel apps (`admin-eam-app.vercel.app` + `admin-fixed-route-app.vercel.ap
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/email/reset/{request,verify}: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/metadata: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/rider/test/login: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/token/superAdmin: Live GET returns 401 + CORS — auth-gated, not bypassable despite bundle leak
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/key/{x}: 404 auth-free 0B — registered-not-implemented route, not data-bearing, not enumeration o
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free 0B — registered-not-implemented route, not data-bearing
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: all 401 with garbage Bearer — auth omission doe
- LEARN: REJECTED MISCONFIG @ admin-spare.ngrok.io: OOS — ngrok-edge 404; no independent in-scope exploitation vector
- LEARN: REJECTED MISCONFIG @ routing.sparelabs.com: envoy 404 across all paths — remains dead, no surface
- LEARN: STABLE RECORDED: api.sparelabs.com/v1/** CORS credential reflection confirmed live 2026-08-08 14:56 UTC — ACAO:https://evil.example.com + ACAC:true + methods GE
- LEARN: STABLE RECORDED: api.sparelabs.com/v1/global/regions scheme-only bypass confirmed live 2026-08-08 14:56 UTC — Bearer x -> 200 + 725B (7 regions, 6 OOS api/routi
- LEARN: STABLE RECORDED: api.sparelabs.com/v1/public/terms data disclosure confirmed live 2026-08-08 14:56 UTC — ?mobileAppId=<nil-uuid> -> 200 + termsOfUseUrl + privac
- LEARN: STABLE RECORDED: api.sparelabs.com/v1/global/organizations fail-open confirmed live 2026-08-08 14:56 UTC — 200 + `{"data":[]}` (11B) + ACAO+ACAC with Bearer x; 
- LEARN: STABLE RECORDED: api.sparelabs.com/v1/public/organization UUID enumeration oracle confirmed live 2026-08-08 14:56 UTC — malformed -> 400 ValidationError "must m
- LEARN: NO_DELTA: routing.sparelabs.com remains envoy 404 across all paths; no surface.
- LEARN: NO_DELTA: forms.sparelabs.com JS bundle remains main.71d52314.js (same infra leak incl. OOS + ngrok inactive).
- LEARN: NO_DELTA: platform.sparelabs.com /login CSP remains leaking prod admin-eam-app + admin-fixed-route-app (vercel.app) + staging + Metabase + full infra.
- LEARN: STABLE RECORDED: api.sparelabs.com/v1/** CORS credential reflection confirmed live 2026-08-08 14:56 UTC — ACAO:https://evil.example.com + ACAC:true + methods GE
- LEARN: STABLE RECORDED: api.sparelabs.com/v1/global/regions scheme-only bypass confirmed live 2026-08-08 14:56 UTC — Bearer x -> 200 + 725B (7 regions, 6 OOS api/routi
- LEARN: STABLE RECORDED: api.sparelabs.com/v1/public/terms data disclosure confirmed live 2026-08-08 14:56 UTC — ?mobileAppId=<nil-uuid> -> 200 + termsOfUseUrl + privac
- LEARN: STABLE RECORDED: api.sparelabs.com/v1/global/organizations fail-open confirmed live 2026-08-08 14:56 UTC — 200 + `{"data":[]}` (11B) + ACAO+ACAC with Bearer x; 
- LEARN: STABLE RECORDED: api.sparelabs.com/v1/public/organization UUID enumeration oracle confirmed live 2026-08-08 14:56 UTC — malformed -> 400 ValidationError "must m
- LEARN: NO_DELTA: routing.sparelabs.com remains envoy 404 across all paths; no surface.
- LEARN: NO_DELTA: forms.sparelabs.com JS bundle remains main.71d52314.js (same infra leak incl. OOS + ngrok inactive).
- LEARN: NO_DELTA: platform.sparelabs.com /login CSP remains leaking prod admin-eam-app + admin-fixed-route-app (vercel.app) + staging + Metabase + full infra.

## RANKED HYPOTHESES 2026-08-08 15:24:22 UTC
- [96] api.sparelabs.com/v1/global/regions: Scheme-only auth bypass yields unauthenticated 725B region-registry disclosure incl. 6 OOS infra hosts (from reports/hypotheses-laguna.txt)
- [95] api.sparelabs.com/v1/global/regions: Scheme-only auth bypass on /v1/global/regions yields unauthenticated infrastructure topology (from reports/hypotheses-nemotron3.txt)
- [75] api.sparelabs.com/v1/global/organizations/{id}: Auth-free live org-record read via /v1/global/organizations/{id} (from reports/hypotheses-bigpickle.txt)
- NEXT(hypotheses-nemotron3.txt): PROBE: GET `https://api.sparelabs.com/v1/global/regions` with `Authorization: Bearer x` and `Origin: https://evil.example.com`; capture status, body, CORS heade
- NEXT(hypotheses-laguna.txt): PROBE: `curl -s -D - -o /dev/null -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-ControlRequest-Method: PUT" -H "Access-ControlRequestHeaders: Auth
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only bypass STABLE — `Bearer x` → 200 + 725B region registry (7 regions incl. 6 OOS api/routing host
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — ACAO:<reflected> + ACAC:true + methods GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:A
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open STABLE — 200 + `{"data":[]}` (11B) + CORS (ACAO+ACAC) with `Bearer x`; upstream 709ms 
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: data disclosure STABLE — 200 + live terms URLs (`termsOfUseUrl`+`privacyPolicyUrl`, 137B) with `?mobileA
- LEARN: ACCEPTED MISCONFIG @ platform.sparelabs.com/login: CSP leak STABLE — production admin Vercel apps (`admin-eam-app.vercel.app` + `admin-fixed-route-app.vercel.ap
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/email/reset/{request,verify}: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/metadata: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/rider/test/login: Live GET returns 401 + CORS — auth-gated, not bypassable
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/auth/token/superAdmin: Live GET returns 401 + CORS — auth-gated, not bypassable despite bundle leak
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/organizations/key/{x}: 404 auth-free 0B — registered-not-implemented route, not data-bearing, not enumeration o
- LEARN: REJECTED MISCONFIG @ api.sparelabs.com/v1/global/regions/{id}: 400 auth-free 0B — registered-not-implemented route, not data-bearing
- LEARN: REJECTED AUTH @ api.sparelabs.com/v1/global/{config,features,countries,currencies,fares,tariffs,zones,settings}: all 401 with garbage Bearer — auth omission doe
- LEARN: REJECTED MISCONFIG @ admin-spare.ngrok.io: OOS — ngrok-edge 404; no independent in-scope exploitation vector
- LEARN: REJECTED MISCONFIG @ routing.sparelabs.com: envoy 404 across all paths — remains dead, no surface
- LEARN: ACCEPTED AUTH @ api.sparelabs.com/v1/global/regions: scheme-only bypass STABLE — confirmed live 2026-08-08 15:22 UTC — 200 + 725B + ACAO+ACAC with Bearer x
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS credential reflection STABLE — confirmed live 2026-08-08 15:22 UTC — ACAO:<reflected> + ACAC:true + methods G
- LEARN: ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: fail-open STABLE — confirmed live 2026-08-08 15:22 UTC — OPTIONS 204 advertises PUT/PATCH/POST/D
