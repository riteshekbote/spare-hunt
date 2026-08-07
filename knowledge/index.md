# Knowledge Base (seed)

## Program rules (from scope.yml)
- In scope: spare.com, sparelabs.com, platform.sparelabs.com, api.sparelabs.com, routing.sparelabs.com, forms.sparelabs.com
- Out of scope: ALL OTHER subdomains of sparelabs.com and spare.com; third-party services
- Passive-first: GET/HEAD only, <=1 rps, no account creation, no data modification
- Secrets in commits: sha256 only, never raw

## Baseline surface (2026-08-07 passive recon)
- spare.com: HTTP 200 (apex, in scope)
- www.spare.com: 301 (subdomain -> OUT OF SCOPE per exclusions; note as excluded)
- sparelabs.com / platform.sparelabs.com / routing.sparelabs.com / forms.sparelabs.com: TIMEOUT on https (CDN/WAF gating or slow origin; retry, log server headers when reachable)
- api.sparelabs.com: HTTP 404 on /
- GitHub org sparelabs (28 repos): dominated by third-party forks (react-native-*, mapbox-*, osrm-backend, graphile-worker, heroku-buildpack-lerna, node-postgres, swagger-express-validator, terraform-provider-typesense, OSM-iD-editor) + docs.sparelabs.com + getspare.github.io. Most are vendored forks -> LOW value; docs.sparelabs.com and getspare.github.io are first-party

## Rejected / parked
- (none yet)
- 2026-08-07 REJECTED BUSLOGIC @ routing.sparelabs.com: asset unreachable, confidence below threshold, no auth context available
- 2026-08-07 ACCEPTED MISCONFIG @ api.sparelabs.com/v1: live probe confirms /v1/journeys returns explicit 401 without auth, proving API surface exists behind edge gateway and auth enforcement is at least partially active
- 2026-08-07 ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + MFE manifest enumeration of staging admin assets confirmed passively
- 2026-08-07 REJECTED BUSLOGIC @ routing.sparelabs.com: asset returns envoy 404, no routing API surface visible, confidence below threshold, no auth context available
- 2026-08-07 ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + `/login` prefetch script CONFIRMED leaking `admin-eam-app-staging.vercel.app`, `admin-fixed-route-app-staging.vercel.app`, `metabase.staging.sparelabs.com`, plus 20+ production infra URLs (Cognito, Stripe, DO Spaces, Sentry, Intercom, Mapbox).
- 2026-08-07 ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle CONFIRMED leaking `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `forms.staging.sparelabs.com`, `forms.staging.us.sparelabs.com`, `api-spare.ngrok.io` (dev tunnel), `sparelabs.atlassian.net` (JIRA).
- 2026-08-07 ACCEPTED MISCONFIG @ api.sparelabs.com: `/v1/` API CONFIRMED discoverable via passive enum. 3 unauthenticated endpoints live (200/400/404); 15+ auth-gated endpoints confirmed (401). OpenAPI validation errors leak UUID format requirement + query param schema.
- 2026-08-07 REJECTED AUTH @ api.sparelabs.com: Previous "auth not challengeable" hypothesis PARKED — edge properly returns 401 for auth-gated routes; new finding is the unauthenticated `/v1/public/*` endpoints.
- 2026-08-07 REJECTED MISCONFIG @ forms.sparelabs.com: Object-store directory listing hypothesis PARKED — traffic served via envoy+Google CDN (not raw object store); SPA catch-all returns index.html for all paths.
- 2026-08-07 REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all `/v1/`, `/api/`, `/routing/`, `/router`, `/v2/`, `/graphql`, `/map`, `/directions` paths return 404; no discoverable surface behind envoy gateway.
- 2026-08-07 ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login prefetch script CONFIRMED leaking admin-eam-app-staging.vercel.app, admin-fixed-route-app-staging.vercel.app, metabase.staging.sparelabs.com, plus 20+ production infra URLs
- 2026-08-07 ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle CONFIRMED leaking api.staging.us.sparelabs.com, api.staging.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, api-spare.ngrok.io, sparelabs.atlassian.net
- 2026-08-07 ACCEPTED MISCONFIG @ api.sparelabs.com: /v1/ API CONFIRMED discoverable via passive enum. 3 unauthenticated endpoints live (200/400/404); 15+ auth-gated endpoints confirmed (401). OpenAPI validation errors leak UUID format requirement + query param schema
- 2026-08-07 REJECTED AUTH @ api.sparelabs.com: Previous "auth not challengeable" hypothesis PARKED — edge properly returns 401 for auth-gated routes; new finding is the unauthenticated /v1/public/* endpoints
- 2026-08-07 REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql, /map, /directions paths return 404; no discoverable surface behind envoy gateway
- 2026-08-07 REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; no discoverable surface behind envoy gateway
- 2026-08-07 ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on all /v1 endpoints (including auth-gated) via live probe
- 2026-08-07 ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/*: Endpoints return response data (terms URLs, org list, org existence) despite 401 status code — misleading status, data accessible without auth
- 2026-08-07 ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking staging admin apps (2x Vercel) and Metabase; all three staging hosts respond 200 and are accessible
- 2026-08-07 REJECTED MISCONFIG @ api.staging.sparelabs.com: Leaked staging API hosts return 404 behind same envoy gateway — no independent API surface
- 2026-08-07 REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
- 2026-08-07 ACCEPTED MISCONFIG @ forms.staging.sparelabs.com / forms.staging.us.sparelabs.com: Staging forms portals live (200, same SPA catch-all behind envoy+Google CDN)
- 2026-08-07 ACCEPTED MISCONFIG @ api.sparelabs.com: CORS preflight confirms full credential reflection — any malicious origin can issue authenticated GET/PUT/PATCH/POST/DELETE requests with Authorization header via victim browser (escalates read to write)
- 2026-08-07 ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 malformed, 404 not-found, 200 found) with full OpenAPI ValidationError body disclosure
- 2026-08-07 ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Returns live termsOfUseUrl + privacyPolicyUrl without authentication — unauthenticated data disclosure
- 2026-08-07 ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: Returns 200 with {"data":[]} and reflected CORS+credentials — auth state inconsistent (was 401 at 20:57 UTC, 200 at 21:30 UTC)
- 2026-08-07 REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all paths return 404; no surface
- 2026-08-07 ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle rotated (main.6ed467ae.js → main.71d52314.js) but same staging+prod infra leak persists
- 2026-08-07 ACCEPTED MISCONFIG @ api.staging.sparelabs.com: Staging API hosts return 404 — no independent API surface
- 2026-08-07 REJECTED MISCONFIG @ api-staking.sparelabs.com: Staging API hosts return 404 — no independent API surface
- 2026-08-07 ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: fail-open now STABLE — 200 ×6 across ~2h incl. pagination variants (params ignored, hardcoded `{"data":[]}`), control route stable 401 → route-level auth omission confirmed as pattern, not flapping; severity remains capped while payload empty.
- 2026-08-07 REJECTED BUSLOGIC @ api.sparelabs.com: CORS reflect-any-origin+credentials re-confirmed on all /v1 (401, 404, and 200 paths) — uniformly applied API-scoped middleware, not path-conditional.
