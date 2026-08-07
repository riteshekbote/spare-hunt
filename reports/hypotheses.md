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
