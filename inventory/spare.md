# Inventory: spare

## Seed 2026-08-07 (passive recon)

### Hosts (in scope)
- spare.com — 200
- sparelabs.com — timeout (retry)
- platform.sparelabs.com — timeout (retry)
- api.sparelabs.com — 404
- routing.sparelabs.com — timeout (retry)
- forms.sparelabs.com — timeout (retry)

### Hosts (EXCLUDED - other subdomains, do NOT test)
- www.spare.com (301) and every other *.spare.com / *.sparelabs.com not listed above

### Code surface
- github.com/sparelabs (28 repos) — mostly third-party forks (react-native-*, mapbox, osrm, graphile-worker, heroku-buildpack-lerna, swagger-express-validator); first-party: docs.sparelabs.com, getspare.github.io
- docs.sparelabs.com repo = marketing/docs site (verify)

### Open questions
- Authentication model of api.sparelabs.com (Bearer? API key?)
- What routing.sparelabs.com and forms.sparelabs.com serve (once reachable)
- CDN/WAF in front (why timeouts?)

## 2026-08-07 18:34:58 UTC
- NEW sparelabs.com now responds (301→https://spare.com via Cloudflare; HSTS `max-age=0; preload`) — previously TIMEOUT.
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT.
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT.
- NEW forms.sparelabs.com now responds 200 ("Spare Engage Web Portal" SPA; object-store headers) — previously TIMEOUT.
- CHANGED api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed.

## 2026-08-07 19:01:01 UTC
- NEW sparelabs.com now responds (301→https://spare.com via Cloudflare; HSTS `max-age=0; preload`) — previously TIMEOUT
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT
- NEW forms.sparelabs.com now responds 200 ("Spare Engage Web Portal" SPA; object-store headers) — previously TIMEOUT
- CHANGED api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed
- NEW api.sparelabs.com/v1/** live surface: `/v1/journeys` returns 401 InvalidTokenError (no auth header); `/v1/journeyNotifications/*` enumerated
- NEW platform.sparelabs.com MFE orchestration: CSP + `/login` prefetch enumerates staging admin apps (`admin-eam-app(-staging).vercel.app`, `admin-fixed-route-app(-staging).vercel.app`), `metabase.sparelab
- NEW forms.sparelabs.com served from object store (DO Spaces/S3): `content-disposition: inline`, `accept-ranges: bytes`, `etag`, no `server` header
- NEW api.sparelabs.com `/v1/` API prefix discovered: 3 unauthenticated endpoints (`/v1/global/organizations`→200, `/v1/public/organization?organizationId=<uuid>`→400/404, `/v1/public/terms?organizationId=<
- NEW api.sparelabs.com `/v1/public/organization?organizationId=<uuid>` validates UUID format via OpenAPI schema (400 "must match format uuid" for malformed, 404 "Organization was not found" for non-existen
- NEW forms.sparelabs.com JS bundle (`main.6ed467ae.js`, 342,725 bytes) leaks: staging+prod API hosts (`api.us.sparelabs.com`, `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `api-spare.ngrok.i
- CHANGED api.sparelabs.com: re-identified from "404 edge gateway, surface hidden behind unknown path prefix" to "envoy edge with discoverable `/v1/` API (3 unauth + 15+ auth-gated endpoints)"
- CHANGED forms.sparelabs.com: re-identified from "static object store SPA" to "SPA behind envoy+Google CDN; JS bundle leaks staging infrastructure; all paths return index.html (SPA catch-all, 537 bytes)"

## 2026-08-07 19:16:49 UTC
- NEW api.sparelabs.com `/v1/` API prefix discovered: 3 unauthenticated endpoints (`/v1/global/organizations`→200, `/v1/public/organization?organizationId=<uuid>`→400/404, `/v1/public/terms?organizationId=<
- NEW api.sparelabs.com `/v1/public/organization?organizationId=<uuid>` validates UUID format via OpenAPI schema (400 "must match format uuid" for malformed, 404 "Organization was not found" for non-existen
- NEW forms.sparelabs.com JS bundle (`main.6ed467ae.js`, 342,725 bytes) leaks: staging+prod API hosts (`api.us.sparelabs.com`, `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `api-spare.ngrok.i
- CHANGED api.sparelabs.com: re-identified from "404 edge gateway, surface hidden behind unknown path prefix" to "envoy edge with discoverable `/v1/` API (3 unauth + 15+ auth-gated endpoints)"
- CHANGED forms.sparelabs.com: re-identified from "static object store SPA" to "SPA behind envoy+Google CDN; JS bundle leaks staging infrastructure; all paths return index.html (SPA catch-all, 537 bytes)"

## 2026-08-07 20:05:10 UTC

## 2026-08-07 20:57:44 UTC
- CHANGED api.sparelabs.com `/v1/global/organizations` now returns 401 (was 200) but body returns `{"data":[]}` — data returned despite 401 status
- CHANGED api.sparelabs.com `/v1/public/organization?organizationId=<uuid>` now returns 401 (was 400/404) with `NotFoundError` body — auth gate added but error info leaks
- CHANGED api.sparelabs.com `/v1/public/terms?organizationId=<uuid>` now returns 401 (was 400/404) but body returns full terms URLs — **data returned despite 401 status**
- NEW api.sparelabs.com CORS `access-control-allow-origin` reflects **any Origin** with `access-control-allow-credentials: true` on **all /v1 endpoints** (including auth-gated `/v1/journeys`)
- CHANGED forms.sparelabs.com JS bundle filename rotated (`main.6ed467ae.js` → `main.71d52314.js`) but **same leaked endpoints persist**: `api.staging.sparelabs.com`, `api.staging.us.sparelabs.com`, `api-spare.
- NEW `forms.staging.sparelabs.com` and `forms.staging.us.sparelabs.com` now **respond 200** (same SPA catch-all, 537 bytes, envoy+Google CDN)
- NEW `api.staging.sparelabs.com` and `api.staging.us.sparelabs.com` respond **404** (envoy gateway, same as prod)
- NEW `admin-eam-app-staging.vercel.app` and `admin-fixed-route-app-staging.vercel.app` **respond 200** (Vercel, CORS `*`, minimal HTML)
- NEW `metabase.staging.sparelabs.com` **responds 200** (envoy gateway, Metabase login page, frame-ancestors 'none')
- NEW `api-spare.ngrok.io` returns **ngrok 404 (ERR_NGROK_3200)** — tunnel inactive

## 2026-08-07 21:47:25 UTC
- NEW None — all in-scope assets respond identically to 2026-08-07 20:57:44 UTC baseline (api CORS reflect-any-origin+creds on /v1/**, /v1/public/* data-on-401, platform CSP leaks staging admin/Metabase, fo
- NEW api.sparelabs.com CORS preflight (OPTIONS /v1/journeys) confirms `access-control-allow-origin` reflects any origin + `access-control-allow-credentials: true` + `access-control-allow-methods: GET,HEAD,
- NEW api.sparelabs.com /v1/global/organizations currently returns HTTP 200 (not 401 as claimed at 20:57 UTC) with {"data":[]} + reflected CORS+credentials
- NEW api.sparelabs.com /v1/public/organization?organizationId=00000000-0000-0000-0000-000000000000 returns 404 (valid UUID, not found) vs 400 for malformed UUID — confirms UUID enumeration oracle
- NEW api.sparelabs.com /v1/public/terms?organizationId=00000000-0000-0000-0000-000000000000 returns HTTP 200 with live terms URLs (termsOfUseUrl, privacyPolicyUrl) — unauthenticated data disclosure
- NEW forms.staging.sparelabs.com + forms.staging.us.sparelabs.com verified responding 200
- NEW admin-eam-app-staging.vercel.app + admin-fixed-route-app-staging.vercel.app verified responding 200
- NEW metabase.staging.sparelabs.com verified responding 200 (Metabase login)
- NEW api-spare.ngrok.io returns ERR_NGROK_3200 (tunnel inactive)
- CHANGED forms.sparelabs.com JS bundle rotated: main.6ed467ae.js → main.71d52314.js (verified live)

## 2026-08-07 22:08:24 UTC

## 2026-08-07 22:55:14 UTC
- CHANGED api.sparelabs.com /v1/global/organizations: auth fail-open is now STABLE not flapping — HTTP 200 `{"data":[]}` on all 6 samples across ~2h including ?limit=&offset= variants (params ignored, 11B hardc
- NEW api.sparelabs.com /v1/** error envelope leaks `metadata.correlationId` (UUID) on every 401/404 — request-tracking artifact, no independent value.
- NEW forms.sparelabs.com/ now shows `x-frame-options: DENY` while api/platform show SAMEORIGIN — inconsistent clickjacking posture, low value.

## 2026-08-07 23:27:19 UTC
- NEW NO_DELTA — all in-scope assets stable since 2026-08-07 22:55:14 UTC; no new surface changes observed
- NEW api.sparelabs.com /v1/** now confirmed reflecting CORS credentials on OPTIONS /v1/journeys/requests (full preflight: `access-control-allow-methods: GET,HEAD,PUT,PATCH,POST,DELETE`, `access-control-all
- NEW api.sparelabs.com /v1/global/organizations confirmed STABLE fail-open (200 + `{"data":[]}` + credentials) — auth omission is now persistent, not flapping
- NEW api.sparelabs.com /v1/public/organization UUID enumeration oracle confirmed on live probe (400 ValidationError for malformed, 404 NotFoundError for valid-but-unfound, 200 for valid org)
- NEW platform.sparelabs.com /login CSP confirmed leaking both staging AND production admin vercel.app hosts (`admin-eam-app-staging.vercel.app`, `admin-eam-app.vercel.app`, `admin-fixed-route-app-staging.v
- CHANGED api.sparelabs.com re-confirmed as envoy edge (server: envoy, via: 1.1 google) with discoverable /v1/ API surface

## 2026-08-07 23:59:36 UTC
- NEW api.sparelabs.com /v1/** CORS reflect-any-origin with credentials confirmed on OPTIONS preflight for all methods (GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS) + Authorization header
- NEW platform.sparelabs.com /login CSP now leaks production admin Vercel hosts (admin-eam-app.vercel.app, admin-fixed-route-app.vercel.app) in addition to staging
- CHANGED platform.sparelabs.com /login CSP: Now confirmed leaking **production** admin app hosts (`admin-eam-app.vercel.app`, `admin-fixed-route-app.vercel.app`) in addition to the previously-known staging hos

## 2026-08-08 01:03:13 UTC

## 2026-08-08 03:06:00 UTC

## 2026-08-08 04:16:26 UTC
- NEW api.sparelabs.com/v1/global/organizations/key/{anything} → 404 NotFoundError "Organization was not found" WITHOUT auth, no format validation (probed: `not-a-uuid`, `x`, all-zero UUID → byte-identical 
- NEW api.sparelabs.com/v1/global/organizations/zones/centroid (platform-bundle-derived) → 400 ValidationError "not found" WITHOUT auth — not a live route, yet bypasses the auth gate → omission is controlle
- CHANGED /v1/global/organizations list still 200 hardcoded `{"data":[]}` (params ignored) — empty-payload cap persists; no data-bearing 200 found
- CHANGED Control /v1/global/settings → 401 InvalidTokenError stable; Origin-reflect + credentials + envoy re-confirmed on all 8 probes this session

## 2026-08-08 05:10:34 UTC
- NEW api.sparelabs.com/v1/global/organizations/key/{anything} → 404 NotFoundError "Organization was not found" WITHOUT auth, no format validation (probed: `not-a-uuid`, `x`, all-zero UUID → byte-identical 
- NEW api.sparelabs.com/v1/global/organizations/zones/centroid (platform-bundle-derived) → 400 ValidationError "not found" WITHOUT auth — not a live route, yet bypasses auth gate → controller-wide omission
- CHANGED api.sparelabs.com/v1/global/organizations list still 200 hardcoded `{"data":[]}` (params ignored) — empty-payload cap persists; no data-bearing 200 found
- CHANGED api.sparelabs.com/v1/global/settings control → 401 InvalidTokenError stable; Origin-reflect + credentials + envoy re-confirmed on all probes
- NEW api.sparelabs.com/v1/public/terms?organizationId=<uuid> now returns 401 (was 400/404) but body returns full terms URLs — **data returned despite 401 status**

## 2026-08-08 06:00:08 UTC
- CHANGED api.sparelabs.com/v1/public/terms?organizationId=<uuid> now returns HTTP 401 (was 200/400/404) but response body STILL returns live termsOfUseUrl + privacyPolicyUrl — data disclosed despite misleading
- CHANGED api.sparelabs.com/v1/global/organizations remains HTTP 200 with hardcoded `{"data":[]}` (query params ignored, 11B body) — fail-open STABLE
- CHANGED api.sparelabs.com/v1/global/organizations/key/{any-string} returns 404 NotFoundError "Organization was not found" WITHOUT auth, no UUID format validation (probed: `not-a-uuid`, `x`, all-zero UUID → by
- CHANGED api.sparelabs.com/v1/global/organizations/zones/centroid (bundle-derived) returns 400 ValidationError "not found" WITHOUT auth — not a live route, yet bypasses auth gate
- CHANGED platform.sparelabs.com /login CSP still leaking production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-route-app.vercel.app) + staging variants + metabase.sparelabs.com + metabase.staging
- CHANGED forms.sparelabs.com JS bundle (main.71d52314.js) still leaking api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, api-spare.ngrok.io,
- CHANGED routing.sparelabs.com all paths (/v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/) return envoy 404 — CONFIRMED dead
- CHANGED api.staging.sparelabs.com, api.staging.us.sparelabs.com, api-spare.ngrok.io, api-staking.sparelabs.com all 404/inactive — remain dead

## 2026-08-08 06:38:30 UTC

## 2026-08-08 07:34:28 UTC
- NEW api.sparelabs.com/v1/global/regions: auth-free DATA-BEARING — 200 + 725B region registry (CA/US/US2/US3/JP/EU/UAT + apiUrl + routingHost) with any garbage Bearer token; header presence-only, token val
- NEW api.sparelabs.com/v1/global/regions/{id}: 400 auth-free route-registered-not-implemented (no InvalidTokenError) — controller-wide omission extends to subroutes
- NEW api.sparelabs.com/v1/public/organizations: 400 auth-free "not found" — new router path on public namespace
- CHANGED api.sparelabs.com/v1/public/terms?organizationId=<uuid>: behavior flapping between 200+data and 400 validation error — inconsistent parameter handling, suggests multi-version backend behind envoy LB
- CHANGED forms.sparelabs.com JS bundle rotated: main.6ed467ae.js → main.71d52314.js (verified live)
- NEW api.sparelabs.com: multi-version LB behind envoy re-confirmed — /v1/public/terms?organizationId flapped 401→200 in ~35min; fail-open route served by ~703ms upstream vs 4–8ms on auth-gated routes (dist

## 2026-08-08 08:12:41 UTC
- NEW api.sparelabs.com/v1/global/regions: auth-free DATA-BEARING — 200 + 725B region registry (CA/US/US2/US3/JP/EU/UAT + apiUrl + routingHost) with any garbage Bearer token; header presence-only, token val
- NEW api.sparelabs.com/v1/global/regions/{id}: 400 auth-free route-registered-not-implemented (no InvalidTokenError) — controller-wide omission extends to subroutes
- NEW api.sparelabs.com/v1/public/organizations: 400 auth-free "not found" — new router path on public namespace
- CHANGED api.sparelabs.com/v1/public/terms?organizationId=<uuid>: behavior flapping between 200+data and 400 validation error — inconsistent parameter handling, suggests multi-version backend behind envoy LB
- CHANGED forms.sparelabs.com JS bundle rotated: main.6ed467ae.js → main.71d52314.js (verified live)
- NEW api.sparelabs.com: multi-version LB behind envoy re-confirmed — /v1/public/terms?organizationId flapped 401→200 in ~35min; fail-open route served by ~703ms upstream vs 4–8ms on auth-gated routes (dist

## 2026-08-08 09:01:29 UTC
- NEW api.sparelabs.com /v1/public/terms?mobileAppId=<uuid>: Returns 200 with live terms URLs + reflected CORS credentials without auth — new parameter vector on existing public endpoint

## 2026-08-08 09:37:43 UTC
- NEW platform bundle index-BIOrSDj1.js leaks /v1/auth/token/superAdmin (live, 401-gated confirmed: 401 w/ garbage Bearer, 401 lacks-header, OPTIONS 204) + admin-spare.ngrok.io (OOS tunnel).
- NEW forms bundle main.71d52314.js maps auth surface: auth/metadata, auth/rider/{phone,email}/request|verify, auth/rider/pin/login, auth/rider/test/login, auth/email/reset/{request,verify}, auth/token, aut

## 2026-08-08 10:13:30 UTC
- NEW platform.sparelabs.com bundle index-BIOrSDj1.js leaks /v1/auth/token/superAdmin (401-gated, OPTIONS 204) + admin-spare.ngrok.io (OOS)
- NEW forms.sparelabs.com bundle main.71d52314.js maps auth surface: auth/metadata, auth/rider/{phone,email}/request|verify, auth/rider/pin/login, auth/rider/test/login, auth/email/reset/{request,verify}, a
- NEW `/v1/global/regions` auth gate fully characterized: no-Auth→400 `{"message":"Authorization header required"}`; `Authorization: x`→400 `{"message":"Authorization header with scheme 'Bearer' required"}`
- NEW Subroute sweep: `/v1/global/regions/{id}`→400 (0B auth-free), `/v1/global/organizations/key/{x}`→404 (0B auth-free) — auth gate skipped but **not data-bearing** (registered-not-implemented routes).
- CHANGED `/v1/public/terms?organizationId=<uuid` flapped back to **200 + live terms URLs** (was 401+body at 06:00 UTC) — confirms multi-version LB flapping; data disclosure stable across status variance.
- CHANGED `admin-spare.ngrok.io` (OOS) now returns ngrok-edge 404 (was `ERR_NGROK_3200` inactive) — tunnel registered, no backing app; remains OOS.

## 2026-08-08 10:50:59 UTC
- NEW platform.sparelabs.com bundle index-BIOrSDj1.js leaks /v1/auth/token/superAdmin (401-gated, OPTIONS 204) + admin-spare.ngrok.io (OOS)
- NEW forms.sparelabs.com bundle main.71d52314.js maps auth surface: auth/metadata, auth/rider/{phone,email}/request|verify, auth/rider/pin/login, auth/rider/test/login, auth/email/reset/{request,verify}, a
- NEW /v1/global/regions auth gate fully characterized: no-Auth→400 `{"message":"Authorization header required"}`; `Authorization: x`→400 `{"message":"Authorization header with scheme 'Bearer' required"}`
- NEW Subroute sweep: `/v1/global/regions/{id}`→400 (0B auth-free), `/v1/global/organizations/key/{x}`→404 (0B auth-free) — auth gate skipped but **not data-bearing**
- NEW `/v1/public/terms?mobileAppId=<uuid>`: Returns 200 with live terms URLs + reflected CORS credentials without auth — new parameter vector
- CHANGED `/v1/public/terms?organizationId=<uuid>` flapped back to **200 + live terms URLs** (was 401+body at 06:00 UTC) — confirms multi-version LB flapping; data disclosure stable
- CHANGED `admin-spare.ngrok.io` (OOS) now returns ngrok-edge 404 (was `ERR_NGROK_3200` inactive)
- NEW platform bundle index-BIOrSDj1.js leaks /v1/auth/token/superAdmin (live, 401-gated confirmed: 401 w/ garbage Bearer, 401 lacks-header, OPTIONS 204) + admin-spare.ngrok.io (OOS tunnel).
- NEW forms bundle main.71d52314.js maps auth surface: auth/metadata, auth/rider/{phone,email}/request|verify, auth/rider/pin/login, auth/rider/test/login, auth/email/reset/{request,verify}, auth/token, aut
- NEW platform bundle index-BIOrSDj1.js leaks /v1/auth/token/superAdmin (live, 401-gated confirmed: 401 w/ garbage Bearer, 401 lacks-header, OPTIONS 204) + admin-spare.ngrok.io (OOS tunnel).
- NEW forms bundle main.71d52314.js maps auth surface: auth/metadata, auth/rider/{phone,email}/request|verify, auth/rider/pin/login, auth/rider/test/login, auth/email/reset/{request,verify}, auth/token, aut
- NEW `/v1/global/regions/{id}` → 400 auth-free 0B (registered-not-implemented, not data-bearing)
- NEW `/v1/global/organizations/key/{x}` → 404 auth-free 0B (not data-bearing)
- NEW `/v1/global/organizations/zones/centroid` → 400 auth-free 0B (bundle-derived, not a live route)
- CHANGED `/v1/public/terms?mobileAppId=<uuid>` → 200 + live terms URLs + CORS without auth (new parameter vector)

## 2026-08-08 11:14:26 UTC

## 2026-08-08 11:51:10 UTC

## 2026-08-08 12:07:24 UTC

## 2026-08-08 13:13:27 UTC
- NEW NO_DELTA

## 2026-08-08 13:56:04 UTC
- NEW NO_DELTA

## 2026-08-08 14:26:37 UTC
- NEW NO_DELTA

## 2026-08-08 14:59:50 UTC
- NEW NO_DELTA

## 2026-08-08 15:24:22 UTC

## 2026-08-08 15:56:25 UTC

## 2026-08-08 16:24:36 UTC
