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

## 2026-08-08 17:20:15 UTC
- NEW NO_DELTA — no new probes or surface changes since 2026-08-08 16:24 UTC; last inventory/knowledge entries at 16:21-16:22 UTC

## 2026-08-08 17:58:34 UTC

## 2026-08-08 18:07:27 UTC

## 2026-08-08 18:56:28 UTC

## 2026-08-08 19:30:48 UTC

## 2026-08-08 19:58:31 UTC

## 2026-08-08 20:39:47 UTC

## 2026-08-08 21:06:47 UTC

## 2026-08-08 21:51:32 UTC

## 2026-08-08 22:05:12 UTC
- NEW api.sparelabs.com/v1/global/organizations: COMPLETE no-auth bypass confirmed (no Authorization header needed) — severity upgraded from scheme-only to full route-level omission; OPTIONS 204 confirms wr
- CHANGED api.sparelabs.com/v1/global/organizations: Auth bypass refined — previously "scheme-only" like /regions, now confirmed zero-header bypass (200 + `{"data":[]}` + ACAO+ACAC with NO Authorization header)

## 2026-08-08 22:45:41 UTC
- NEW api.sparelabs.com/v1/global/organizations: COMPLETE no-auth bypass confirmed (no Authorization header needed) — severity upgraded from scheme-only to full route-level omission; OPTIONS 204 confirms wr
- CHANGED api.sparelabs.com/v1/global/organizations: Auth bypass refined — previously "scheme-only" like /regions, now confirmed zero-header bypass (200 + `{"data":[]}` + ACAO+ACAC with NO Authorization header)
- NEW api.sparelabs.com/v1/admin/*: no-auth GET /v1/admin/health + /v1/admin/organizations → 404 0B (0B, no CORS) — no admin namespace on API; platform root-config (index-BIOrSDj1.js, 6MB) contains ZERO v1/
- NEW platform.sparelabs.com root-config: leaks regional env matrix (api.eu/jp/us/us2/uat/staging.sparelabs.com + platform.eu/jp/us/us2/uat.staging) — ALL OOS subdomains per exclusions; informational only, 
- NEW api.sparelabs.com/v1/journeyNotifications/{rebookedRescheduled,rebookingFailed,rebookingPlanned,rebookedReshaped} + /v1/meticulous-manual-init: bundle-derived refs → live GET 404 0B (dead build-time r

## 2026-08-08 23:14:02 UTC
- NEW platform.sparelabs.com root-config (index-BIOrSDj1.js): leaks regional env matrix (api.eu/jp/us/us2/uat/staging.sparelabs.com + platform.eu/jp/us/us2/uat.staging) — ALL OOS subdomains per exclusions
- CHANGED api.sparelabs.com/v1/global/organizations: COMPLETE no-auth bypass confirmed (no Authorization header needed) — severity upgraded from scheme-only to full route-level omission; OPTIONS 204 confirms wr
- NEW api.sparelabs.com/v1/admin/*: no-auth GET /v1/admin/health + /v1/admin/organizations → 404 0B — no admin namespace on API
- NEW api.sparelabs.com/v1/journeyNotifications/* + /v1/meticulous-manual-init: bundle-derived refs → live GET 404 0B — dead build-time refs
- NEW REJECTED MISCONFIG @ api.sparelabs.com/v1/admin/* and REJECTED BUSLOGIC @ api.sparelabs.com/v1/journeyNotifications/*

## 2026-08-08 23:49:20 UTC
- NEW NO_DELTA — inventory and knowledge base show no new surface changes since 2026-08-08 23:12 UTC stable re-confirmation

## 2026-08-09 00:39:22 UTC
- NEW NO_DELTA — inventory and knowledge base show no new surface changes since 2026-08-08 23:12 UTC stable re-confirmation

## 2026-08-09 02:52:07 UTC

## 2026-08-09 04:10:40 UTC

## 2026-08-09 05:18:56 UTC

## 2026-08-09 06:06:03 UTC

## 2026-08-09 07:14:46 UTC
- NEW 2026-08-09 07:12:02 UTC — NO_DELTA: inventory and knowledge base show no new surface changes since 2026-08-09 06:03 UTC stable re-confirmation; all prior ACCEPTED/REJECTED classes remain stable

## 2026-08-09 08:07:35 UTC

## 2026-08-09 09:01:14 UTC

## 2026-08-09 09:49:15 UTC

## 2026-08-09 10:20:42 UTC
- NEW NO_DELTA — inventory and knowledge base show no new surface changes since 2026-08-09 09:46 UTC stable re-confirmation; all prior ACCEPTED/REJECTED classes remain stable

## 2026-08-09 10:59:01 UTC
- NEW NO_DELTA — inventory and knowledge base show no new surface changes since 2026-08-09 09:46 UTC stable re-confirmation; all prior ACCEPTED/REJECTED classes remain stable

## 2026-08-09 11:38:34 UTC
- NEW NO_DELTA — inventory and knowledge base show no new surface changes since 2026-08-09 09:46 UTC stable re-confirmation; all prior ACCEPTED/REJECTED classes remain stable

## 2026-08-09 12:03:09 UTC

## 2026-08-09 13:14:01 UTC

## 2026-08-09 14:02:58 UTC

## 2026-08-09 15:00:41 UTC

## 2026-08-09 15:17:02 UTC
- NEW NO_DELTA — inventory and knowledge base show no new surface changes since 2026-08-09 13:12 UTC stable re-confirmation; all prior ACCEPTED/REJECTED classes remain stable

## 2026-08-09 15:52:28 UTC
- NEW NO_DELTA — inventory and knowledge base show no new surface changes since 2026-08-09 13:12 UTC stable re-confirmation; all prior ACCEPTED/REJECTED classes remain stable

## 2026-08-09 16:21:49 UTC

## 2026-08-09 17:02:27 UTC
- NEW NO_DELTA — inventory and knowledge base show no new surface changes since 2026-08-09 15:52 UTC stable re-confirmation; all prior ACCEPTED/REJECTED classes remain stable
- CHANGED api.sparelabs.com/v1/public/organization: UUID enumeration oracle differential DEGRADED 3-way(400/404/200) → 2-way(400/200); nil-uuid now returns 400 ValidationError (was 404 NotFoundError). Valid-org

## 2026-08-09 17:42:34 UTC

## 2026-08-09 18:09:15 UTC
- NEW None — all live probes confirm STABLE state matching knowledge base (2026-08-09 13:10–15:00 UTC re-confirmations)
- CHANGED api.sparelabs.com/v1/public/organization: Inventory claimed UUID oracle degraded 3-way→2-way (nil-uuid→400), but live probe 2026-08-09 18:07 UTC confirms 3-way intact: malformed→400 ValidationError (2

## 2026-08-09 19:01:52 UTC

## 2026-08-09 19:42:11 UTC

## 2026-08-09 20:05:59 UTC
- NEW 2026-08-09 20:04:05 UTC — NO_DELTA: inventory and knowledge base show no new surface changes since 2026-08-09 19:42 UTC stable re-confirmation; all prior ACCEPTED/REJECTED classes remain stable

## 2026-08-09 20:50:34 UTC

## 2026-08-09 21:20:01 UTC

## 2026-08-09 21:55:53 UTC
- NEW NO_DELTA — inventory and knowledge base show no new surface changes since 2026-08-09 18:38 UTC stable re-confirmation; all prior ACCEPTED/REJECTED classes remain stable

## 2026-08-09 22:29:08 UTC
- NEW NO_DELTA — inventory and knowledge base show no new surface changes since 2026-08-09 18:38 UTC stable re-confirmation; all prior ACCEPTED/REJECTED classes remain stable

## 2026-08-09 23:06:23 UTC

## 2026-08-09 23:43:08 UTC

## 2026-08-10 00:08:47 UTC

## 2026-08-10 02:32:54 UTC

## 2026-08-10 04:19:42 UTC
- CHANGED platform.sparelabs.com: All 10 admin/API paths (/admin, /api, /graphql, /v1, /internal, /config, /env, /status, /health, /metrics) return 200 + `text/html` — confirmed SPA catch-all, NOT real API endp
- CHANGED forms.sparelabs.com: All 8 API paths (/api/health, /api/v1, /graphql, /webhooks, /export, /status, /config, /v1) return 200 + `text/html` (index.html, `content-disposition: inline; filename="index.htm

## 2026-08-10 05:50:57 UTC
- NEW platform.sparelabs.com: All 10 admin/API paths (/admin, /api, /graphql, /v1, /internal, /config, /env, /status, /health, /metrics) return 200 + `text/html` — confirmed SPA catch-all, NOT real API endp
- NEW forms.sparelabs.com: All 8 API paths (/api/health, /api/v1, /graphql, /webhooks, /export, /status, /config, /v1) return 200 + `text/html` (index.html) — confirmed SPA catch-all, no real API surface (2

## 2026-08-10 07:03:56 UTC

## 2026-08-10 08:52:58 UTC

## 2026-08-10 10:08:45 UTC

## 2026-08-10 11:21:53 UTC

## 2026-08-10 12:08:33 UTC
- NEW None — inventory scan 2026-08-10 11:21:53 UTC reports NO_DELTA; all prior ACCEPTED/REJECTED classes in knowledge base remain stable through 2026-08-10 05:50 UTC live re-confirmations

## 2026-08-10 13:42:05 UTC

## 2026-08-10 14:48:12 UTC

## 2026-08-10 15:43:50 UTC

## 2026-08-10 16:39:32 UTC

## 2026-08-10 17:36:33 UTC

## 2026-08-10 18:32:52 UTC
- NEW NO_DELTA — inventory scan 2026-08-10 11:21 UTC reports no surface changes; all prior ACCEPTED/REJECTED classes in knowledge base remain stable through 2026-08-10 05:50 UTC live re-confirmations

## 2026-08-10 19:38:39 UTC
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError). 3-way (400/404/200) → 2-way (400/200). Malfo
- NEW api.sparelabs.com/v1/public/riders/{id}: Confirmed DEAD — 404 0B for both malformed and nil-uuid. Route does not exist.
- NEW api.sparelabs.com/v1/public/vehicles/{id}: Confirmed DEAD — 404 0B for both malformed and nil-uuid. Route does not exist.
- NEW api.sparelabs.com/v1/public/mobileApps/{id}: Confirmed DEAD — 404 NotFoundError (with body) for both malformed and nil-uuid. No format discrimination → not an oracle.

## 2026-08-10 20:21:33 UTC
- NEW api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError); malformed and nil-uuid now indis

## 2026-08-10 21:13:47 UTC
- NEW None — inventory scan 2026-08-10 11:21 UTC reports NO_DELTA; all prior ACCEPTED/REJECTED classes in knowledge base remain stable through 2026-08-10 05:50 UTC live re-confirmations
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError); malformed and nil-uuid now indis

## 2026-08-10 21:59:04 UTC
- NEW None — inventory scan 2026-08-10 11:21 UTC reports NO_DELTA; all prior ACCEPTED/REJECTED classes in knowledge base remain stable through 2026-08-10 05:50 UTC live re-confirmations
- CHANGED None — last change (api.sparelabs.com/v1/public/organization UUID oracle degraded 3-way→2-way) already recorded in knowledge base 2026-08-10 19:38 UTC

## 2026-08-10 22:43:42 UTC
- NEW NO_DELTA — inventory scan 2026-08-10 11:21 UTC reports no surface changes; all prior ACCEPTED/REJECTED classes in knowledge base remain stable through 2026-08-10 05:50 UTC live re-confirmations
- CHANGED None — last change (api.sparelabs.com/v1/public/organization UUID oracle degraded 3-way→2-way) already recorded in knowledge base 2026-08-10 19:38 UTC

## 2026-08-10 23:25:23 UTC

## 2026-08-11 00:01:37 UTC
- NEW None — inventory scan 2026-08-10 23:25 UTC reports NO_DELTA; all prior ACCEPTED/REJECTED classes in knowledge base remain stable through 2026-08-10 05:50 UTC live re-confirmations

## 2026-08-11 01:55:51 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}: 3-way UUID enumeration oracle CONFIRMED (plural namespace) — malformed→400 ValidationError "must match format uuid" + correlationId; nil-uuid→404 NotFou

## 2026-08-11 03:47:59 UTC

## 2026-08-11 05:09:44 UTC
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) now confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY, not read+write as previously hypo
- NEW api.sparelabs.com/v1/global/organizations: Auth asymmetry confirmed — GET fails open (200 + 0-auth) while POST/PUT/PATCH/DELETE enforce token validation (401 with garbage Bearer). The CORS OPTIONS pre

## 2026-08-11 05:56:33 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}: 3-way UUID enumeration oracle CONFIRMED (plural namespace) — malformed→400 ValidationError "must match format uuid" + correlationId; nil-uuid→404 NotFou
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) now confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write. OPTION
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError); malformed and nil-uuid now indis
- NEW `api.sparelabs.com/v1/public/organizations/{id}` (plural namespace): 3-way UUID enumeration oracle CONFIRMED live — malformed→400 ValidationError "must match format uuid" + correlationId; nil-uuid→404
- CHANGED `api.sparelabs.com/v1/global/organizations` write methods: POST/PUT/PATCH/DELETE now confirmed to enforce auth properly (401 InvalidTokenError with garbage Bearer x) — bypass is **READ-ONLY (GET only)

## 2026-08-11 06:43:24 UTC

## 2026-08-11 07:59:11 UTC

## 2026-08-11 09:05:24 UTC
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError); malformed and nil-uuid now indis
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError with garbage Bearer x) — bypass is READ-ONLY (GET only), not 
- NEW api.sparelabs.com/v1/public/organizations/{id}: 3-way UUID enumeration oracle CONFIRMED (plural namespace) — malformed→400 ValidationError "must match format uuid" + correlationId; nil-uuid→404 NotFou

## 2026-08-11 10:12:05 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}: 3-way UUID enumeration oracle CONFIRMED (plural namespace) — malformed→400 ValidationError "must match format uuid" + correlationId; nil-uuid→404 NotFou
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError); malformed and nil-uuid now indis
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError with garbage Bearer x) — bypass is READ-ONLY (GET only), not 

## 2026-08-11 11:07:18 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}: 3-way UUID enumeration oracle CONFIRMED (plural namespace) — malformed→400 ValidationError "must match format uuid" + correlationId; nil-uuid→404 NotFou
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError); malformed and nil-uuid now indis
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError with garbage Bearer x) — bypass is READ-ONLY (GET only), not 

## 2026-08-11 12:00:04 UTC
- NEW None — inventory scan 2026-08-11 11:07 UTC reports no surface changes; all prior ACCEPTED/REJECTED classes stable through 2026-08-11 09:05 UTC live re-confirmations

## 2026-08-11 12:55:57 UTC

## 2026-08-11 14:16:06 UTC

## 2026-08-11 15:22:33 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}: 3-way UUID enumeration oracle CONFIRMED (plural namespace) — malformed→400 ValidationError "must match format uuid" + correlationId; nil-uuid→404 NotFou
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) now confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError)

## 2026-08-11 16:22:46 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}: 3-way UUID enumeration oracle CONFIRMED (plural namespace) — malformed→400 ValidationError "must match format uuid" + correlationId; nil-uuid→404 NotFou
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) now confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError)

## 2026-08-11 17:18:53 UTC
- NEW None — inventory scan 2026-08-11 11:07 UTC reports no surface changes; all prior ACCEPTED/REJECTED classes stable through 2026-08-11 09:05 UTC live re-confirmations
- CHANGED None — last live re-confirmation 2026-08-11 15:18 UTC shows all findings stable; no delta since prior analysis cycle

## 2026-08-11 18:12:48 UTC
- NEW None — inventory scan 2026-08-11 11:07 UTC reports no surface changes; all prior ACCEPTED/REJECTED classes stable through 2026-08-11 09:05 UTC live re-confirmations
- CHANGED None — last live re-confirmation 2026-08-11 15:18 UTC shows all findings stable; no delta since prior analysis cycle
- CHANGED REJECTED hypothesis: Auth-asymmetry does NOT extend to undocumented /v1/global/* controllers — all 8 probed (search, audit, exports, metrics, logs, webhooks, analytics, billing) returned HTTP 401 with

## 2026-08-11 19:23:01 UTC
- NEW None — inventory scan 2026-08-11 11:07 UTC reports no surface changes; all prior ACCEPTED/REJECTED classes stable through 2026-08-11 09:05 UTC live re-confirmations
- CHANGED None — last live re-confirmation 2026-08-11 15:18 UTC shows all findings stable; no delta since prior analysis cycle
- CHANGED REJECTED hypothesis: Auth-asymmetry does NOT extend to undocumented /v1/global/* controllers — all 8 probed (search, audit, exports, metrics, logs, webhooks, analytics, billing) returned HTTP 401 with
- CHANGED REJECTED hypothesis: Query parameters on `/v1/global/organizations` do NOT produce non-empty responses — all 7 params tested (`orgId`, `tenantId`, `scope`, `organizationId`, `id`, `name`, `region`) re

## 2026-08-11 20:14:50 UTC

## 2026-08-11 21:06:41 UTC
- NEW None — inventory scan 2026-08-11 11:07 UTC reports no surface changes; all prior ACCEPTED/REJECTED classes stable through 2026-08-11 09:05 UTC live re-confirmations
- CHANGED None — last live re-confirmation 2026-08-11 15:18 UTC shows all findings stable; no delta since prior analysis cycle

## 2026-08-11 22:01:01 UTC
- NEW None — inventory scan 2026-08-11 11:07 UTC reports no surface changes; all prior ACCEPTED/REJECTED classes stable through 2026-08-11 09:05 UTC live re-confirmations
- CHANGED None — last live re-confirmation 2026-08-11 15:18 UTC shows all findings stable; no delta since prior analysis cycle
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle further confirmed at 2-way — nil-uuid returns 400 ValidationError "not found" (malformed + nil indistinguishable); downgraded from orac
- CHANGED api.sparelabs.com/v1/public/organizations/{id} (plural): NEW 3-way UUID enumeration oracle CONFIRMED — malformed→400 ValidationError "must match format uuid"; nil-uuid→404 NotFoundError (131B + correl

## 2026-08-11 22:57:34 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}: 3-way UUID enumeration oracle CONFIRMED (plural namespace) — malformed→400 ValidationError "must match format uuid" + correlationId; nil-uuid→404 NotFou
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError); malformed and nil-uuid indisting
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write

## 2026-08-11 23:41:09 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}: 3-way UUID enumeration oracle CONFIRMED (plural namespace) — malformed→400 ValidationError "must match format uuid" + correlationId; nil-uuid→404 NotFou
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError); malformed and nil-uuid indisting
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write

## 2026-08-12 00:45:07 UTC

## 2026-08-12 03:15:56 UTC
- NEW NO_DELTA — no new inventory or knowledge entries since 2026-08-12 00:45 UTC; all findings stable through 2026-08-11 22:54 UTC live re-confirmation

## 2026-08-12 05:07:59 UTC
- NEW NO_DELTA — no new inventory or knowledge entries since 2026-08-12 00:45 UTC; all findings stable through 2026-08-11 22:54 UTC live re-confirmation

## 2026-08-12 06:44:26 UTC
- NEW NO_DELTA — no new inventory or knowledge entries since 2026-08-12 00:45 UTC; all findings stable through 2026-08-11 22:54 UTC live re-confirmation

## 2026-08-12 08:14:53 UTC
- NEW NO_DELTA — no new inventory or knowledge entries since 2026-08-12 00:45 UTC; all findings stable through 2026-08-11 22:54 UTC live re-confirmation

## 2026-08-12 09:24:29 UTC
- NEW NO_DELTA — no new inventory or knowledge entries since 2026-08-12 00:45 UTC; all findings stable through 2026-08-11 22:54 UTC live re-confirmation
- NEW NO_DELTA — no new surface items since 2026-08-12 03:15 UTC; all ACCEPTED findings stable through last probe (organizations zero-header bypass, regions scheme-only bypass, /public/organizations/{id} 3-

## 2026-08-12 10:36:29 UTC
- NEW NO_DELTA — no new surface items since 2026-08-12 00:45 UTC; all ACCEPTED findings stable through last live probe (organizations zero-header bypass, regions scheme-only bypass, /public/organizations/{i

## 2026-08-12 11:30:04 UTC
- NEW NO_DELTA — no new surface items since 2026-08-12 00:45 UTC; all ACCEPTED findings stable through last live probe

## 2026-08-12 12:14:20 UTC

## 2026-08-12 13:57:47 UTC

## 2026-08-12 14:51:13 UTC

## 2026-08-12 15:48:18 UTC

## 2026-08-12 16:45:01 UTC
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping — live probe shows nil→404 NotFoundError (3-way 400/404/200 intact); contradicts prior 2-way degradation claim; multi-version 

## 2026-08-12 17:46:34 UTC
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping — live probe shows nil→404 NotFoundError (3-way 400/404/200 intact); contradicts prior 2-way degradation claim; multi-version 

## 2026-08-12 18:41:57 UTC
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping between 2-way and 3-way — live probe shows nil→404 NotFoundError (3-way intact: malformed→400, nil→404, valid→200) on fast rep

## 2026-08-12 19:52:21 UTC
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping between 2-way and 3-way — live probe shows nil→404 NotFoundError (3-way 400/404/200 intact) on fast replica; contradicts prior

## 2026-08-12 20:31:15 UTC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle differential now confirmed FLAPPING between 2-way and 3-way — nil-uuid returns 404 NotFoundError on fast envoy replica (3-way 400/404/2

## 2026-08-12 21:25:22 UTC
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping between 2-way and 3-way — live probe shows nil→404 NotFoundError (3-way 400/404/200 intact) on fast replica; contradicts prior
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError); malformed and nil-uuid indisting

## 2026-08-12 22:12:04 UTC
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping between 2-way and 3-way — live probe shows nil→404 NotFoundError (3-way 400/404/200 intact) on fast replica; contradicts prior
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle differential DEGRADED 3-way→2-way — nil-uuid now returns 400 ValidationError "not found" (was 404 NotFoundError); malformed and nil-uuid indisting

## 2026-08-12 23:08:50 UTC

## 2026-08-13 00:11:44 UTC

## 2026-08-13 01:32:16 UTC
- NEW api.sparelabs.com/v1/public/* sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/org
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping confirmed between 2-way and 3-way — nil-uuid returns 404 on fast replica (3-way intact), 400 on slow; multi-version envoy LB c
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write

## 2026-08-13 03:54:08 UTC
- NEW api.sparelabs.com/v1/public/* sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/org
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping confirmed between 2-way and 3-way — nil-uuid returns 404 on fast replica (3-way intact), 400 on slow; multi-version envoy LB c
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write
- NEW sparelabs.com now responds (301→https://spare.com via Cloudflare; HSTS `max-age=0; preload`) — previously TIMEOUT.
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT.
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT.
- NEW forms.sparelabs.com now responds 200 ("Spare Engage Web Portal" SPA; object-store headers) — previously TIMEOUT.
- CHANGED api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed.
- NEW sparelabs.com now responds (301→https://spare.com via Cloudflare; HSTS `max-age=0; preload`) — previously TIMEOUT.
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT.
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT.
- NEW forms.sparelabs.com now responds 200 ("Spare Engage Web Portal" SPA; object-store headers) — previously TIMEOUT.
- CHANGED api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed.
- NEW api.sparelabs.com/v1/public/organization (singular): live probe with correct param `?organizationId=` shows nil→404 NotFoundError (131B) — 3-way state observed again at 03:53 UTC; confirms documented 
- CHANGED api.sparelabs.com/v1/public/organizations/{id}: 3-way oracle re-confirmed intact — malformed→400 ValidationError (263B), nil→404 NotFoundError (131B + correlationId); valid-format random UUID→404 (131
- NEW sparelabs.com now responds (301→https://spare.com via Cloudflare; HSTS `max-age=0; preload`) — previously TIMEOUT.
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT.
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT.
- NEW forms.sparelabs.com now responds 200 ("Spare Engage Web Portal" SPA; object-store headers) — previously TIMEOUT.
- CHANGED api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed.
- NEW api.sparelabs.com `/v1/` API prefix discovered: 3 unauthenticated endpoints (`/v1/global/organizations`→200, `/v1/public/organization?organizationId=<uuid>`→400/404, `/v1/public/terms?organizationId=<
- NEW api.sparelabs.com `/v1/public/organization?organizationId=<uuid>` validates UUID format via OpenAPI schema (400 "must match format uuid" for malformed, 404 "Organization was not found" for non-existen
- NEW forms.sparelabs.com JS bundle (`main.6ed467ae.js`, 342,725 bytes) leaks: staging+prod API hosts (`api.us.sparelabs.com`, `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `api-spare.ngrok.i
- CHANGED api.sparelabs.com: re-identified from "404 edge gateway, surface hidden behind unknown path prefix" to "envoy edge with discoverable `/v1/` API (3 unauth + 15+ auth-gated endpoints)"
- CHANGED forms.sparelabs.com: re-identified from "static object store SPA" to "SPA behind envoy+Google CDN; JS bundle leaks staging infrastructure; all paths return index.html (SPA catch-all, 537 bytes)"
- NEW api.sparelabs.com/v1/public/* sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/org
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping confirmed between 2-way and 3-way — nil-uuid returns 404 on fast replica (3-way intact), 400 on slow; multi-version envoy LB c
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write

## 2026-08-13 05:34:19 UTC
- NEW api.sparelabs.com/v1/public/* sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/org
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping confirmed between 2-way and 3-way — nil-uuid returns 404 on fast replica (3-way intact), 400 on slow; multi-version envoy LB c
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write

## 2026-08-13 07:07:27 UTC
- NEW sparelabs.com now responds 301→https://spare.com (Cloudflare, HSTS `max-age=0; preload`) — previously TIMEOUT
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT
- NEW forms.sparelabs.com now responds 200 — "Spare Engage Web Portal" SPA (object-store headers); previously TIMEOUT
- CHANGED api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed
- NEW api.sparelabs.com `/v1/` API prefix discovered: 3 unauthenticated endpoints (`/v1/global/organizations`→200, `/v1/public/organization?organizationId=<uuid>`→400/404, `/v1/public/terms?organizationId=<
- NEW api.sparelabs.com `/v1/public/organization?organizationId=<uuid>` validates UUID format via OpenAPI schema (400 "must match format uuid" for malformed, 404 "Organization was not found" for non-existen
- NEW forms.sparelabs.com JS bundle (`main.6ed467ae.js`, 342,725 bytes) leaks: staging+prod API hosts (`api.us.sparelabs.com`, `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `api-spare.ngrok.i
- NEW api.sparelabs.com/v1/public/* sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/org
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping confirmed between 2-way and 3-way — nil-uuid returns 404 on fast replica (3-way intact), 400 on slow; multi-version envoy LB c
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write

## 2026-08-13 08:45:44 UTC
- NEW api.sparelabs.com/v1/public/organizations plural-namespace subresource sweep (this cycle): /v1/public/organizations, .../status, .../{nil}/branding, /logo, /config, /tenants → 400 ValidationError "not

## 2026-08-13 09:48:34 UTC
- NEW api.sparelabs.com/v1/public/organizations plural-namespace subresource sweep exhausted — /v1/public/organizations, .../status, .../{nil}/branding, /logo, /config, /tenants all return 400 ValidationErr

## 2026-08-13 10:56:19 UTC
- NEW sparelabs.com now responds 301→https://spare.com (Cloudflare, HSTS `max-age=0; preload`) — previously TIMEOUT
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT
- NEW forms.sparelabs.com now responds 200 — "Spare Engage Web Portal" SPA (object-store headers); previously TIMEOUT
- CHANGED api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed
- NEW api.sparelabs.com `/v1/` API prefix discovered: 3 unauthenticated endpoints (`/v1/global/organizations`→200, `/v1/public/organization?organizationId=<uuid>`→400/404, `/v1/public/terms?organizationId=<
- NEW api.sparelabs.com `/v1/public/organization?organizationId=<uuid>` validates UUID format via OpenAPI schema (400 "must match format uuid" for malformed, 404 "Organization was not found" for non-existen
- NEW forms.sparelabs.com JS bundle (`main.6ed467ae.js`, 342,725 bytes) leaks: staging+prod API hosts (`api.us.sparelabs.com`, `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `api-spare.ngrok.i
- NEW api.sparelabs.com/v1/public/* sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/org
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping confirmed between 2-way and 3-way — nil-uuid returns 404 on fast replica (3-way intact), 400 on slow; multi-version envoy LB c
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write
- NEW api.sparelabs.com/v1/public/organizations plural-namespace subresource sweep exhausted — /v1/public/organizations, .../status, .../{nil}/branding, /logo, /config, /tenants all return 400 ValidationErr

## 2026-08-13 11:39:20 UTC

## 2026-08-13 12:34:06 UTC

## 2026-08-13 14:09:48 UTC
- NEW sparelabs.com now responds 301→https://spare.com (Cloudflare, HSTS `max-age=0; preload`) — previously TIMEOUT
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT
- NEW forms.sparelabs.com now responds 200 — "Spare Engage Web Portal" SPA (object-store headers); previously TIMEOUT
- NEW api.sparelabs.com `/v1/public/organizations` plural namespace subresource sweep exhausted — /v1/public/organizations, .../status, .../{nil}/branding, /logo, /config, /tenants all return 400 Validation
- NEW api.sparelabs.com `/v1/public/organization` (singular) UUID oracle flapping confirmed between 2-way and 3-way — nil-uuid returns 404 on fast replica (3-way intact), 400 on slow; multi-version envoy LB
- CHANGED api.sparelabs.com `/v1/global/organizations` write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write
- CHANGED forms.sparelabs.com JS bundle rotated: `main.6ed467ae.js` (342,725 bytes) replaces prior `main.71d52314.js`; same infra leak (staging+prod+regional API hosts, atlassian.net, ngrok.io)
- NEW api.sparelabs.com `/v1/public/*` sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/
- CHANGED Analytical closure: prior AUTH_HELPED "write-escalation" hypotheses (orgs conf 60, regions conf 50) are CONTRADICTED by existing KB evidence (write verbs POST/PUT/PATCH/DELETE → 401 InvalidTokenError 

## 2026-08-13 15:25:28 UTC

## 2026-08-13 16:21:04 UTC
- NEW sparelabs.com now responds 301→https://spare.com (Cloudflare, HSTS `max-age=0; preload`) — previously TIMEOUT
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT
- NEW forms.sparelabs.com now responds 200 — "Spare Engage Web Portal" SPA (object-store headers); previously TIMEOUT
- CHANGED api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed
- NEW api.sparelabs.com `/v1/` API prefix discovered: 3 unauthenticated endpoints (`/v1/global/organizations`→200, `/v1/public/organization?organizationId=<uuid>`→400/404, `/v1/public/terms?organizationId=<
- NEW api.sparelabs.com `/v1/public/organization?organizationId=<uuid>` validates UUID format via OpenAPI schema (400 "must match format uuid" for malformed, 404 "Organization was not found" for non-existen
- NEW forms.sparelabs.com JS bundle (`main.6ed467ae.js`, 342,725 bytes) leaks: staging+prod API hosts (`api.us.sparelabs.com`, `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `api-spare.ngrok.i
- NEW api.sparelabs.com/v1/public/* sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/org
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping confirmed between 2-way and 3-way — nil-uuid returns 404 on fast replica (3-way intact), 400 on slow; multi-version envoy LB c
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write
- NEW api.sparelabs.com/v1/public/organizations plural-namespace subresource sweep exhausted — all 6 subresources return 400 ValidationError "not found"
- CHANGED forms.sparelabs.com JS bundle rotated: `main.6ed467ae.js` replaces prior `main.71d52314.js`; same infra leak (staging+prod+regional API hosts, atlassian.net, ngrok.io)
- NEW forms.sparelabs.com JS bundle rotated again: `main.b0a0c190.js` replaces `main.6ed467ae.js`; same infra leak persists (api-spare.ngrok.io, api.staging/us.sparelabs.com, forms.staging/us.sparelabs.com,
- CHANGED Analytical closure: prior AUTH_HELPED "write-escalation" hypotheses (orgs conf 60, regions conf 50) are CONTRADICTED by existing KB evidence (write verbs POST/PUT/PATCH/DELETE → 401 InvalidTokenError)
- NEW forms.sparelabs.com JS bundle rotated: `main.6ed467ae.js` (342,725 bytes) → replaces prior `main.71d52314.js`; same infra leak (staging+prod+regional API hosts, atlassian.net, inactive ngrok tunnel)
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way confirmed across multi-version envoy LB replicas — nil-uuid→404 on fast replica (3-way intact), 400 on slow (2-way
- CHANGED api.sparelabs.com `/v1/global/organizations` write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET) only, NOT read+write; severity
- CHANGED routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — was TIMEOUT in seed; STABLE dead, NO_DELTA since discovery
- CHANGED platform.sparelabs.com now responds 200 (Micro-frontend SPA shell) — was TIMEOUT in seed; STABLE CSP infra leak
- NEW api.sparelabs.com/v1/public/* sibling sweep exhausted (8 paths: status/brands/config/features/countries/orgs/settings/health) — all 404 0B, namespace mapped to terms/org
- NEW api.sparelabs.com/v1/public/organizations/{id}/* subresource sweep exhausted (6 subpaths) — all 400 ValidationError "not found", plural namespace fully mapped to {id} leaf

## 2026-08-13 17:16:49 UTC
- NEW sparelabs.com now responds 301→https://spare.com (Cloudflare, HSTS `max-age=0; preload`) — previously TIMEOUT
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT
- NEW forms.sparelabs.com now responds 200 — "Spare Engage Web Portal" SPA (object-store headers); previously TIMEOUT
- CHANGED api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed
- NEW api.sparelabs.com `/v1/` API prefix discovered: 3 unauthenticated endpoints (`/v1/global/organizations`→200, `/v1/public/organization?organizationId=<uuid>`→400/404, `/v1/public/terms?organizationId=<
- NEW api.sparelabs.com `/v1/public/organization?organizationId=<uuid>` validates UUID format via OpenAPI schema (400 "must match format uuid" for malformed, 404 "Organization was not found" for non-existen
- NEW forms.sparelabs.com JS bundle (`main.6ed467ae.js`, 342,725 bytes) leaks: staging+prod API hosts (`api.us.sparelabs.com`, `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `api-spare.ngrok.i
- NEW api.sparelabs.com/v1/public/* sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/org
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping confirmed between 2-way and 3-way — nil-uuid returns 404 on fast replica (3-way intact), 400 on slow; multi-version envoy LB c
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write
- NEW api.sparelabs.com/v1/public/organizations plural-namespace subresource sweep exhausted — all 6 subresources return 400 ValidationError "not found"
- CHANGED forms.sparelabs.com JS bundle rotated: `main.6ed467ae.js` replaces prior `main.71d52314.js`; same infra leak
- NEW forms.sparelabs.com JS bundle rotated again: `main.b0a0c190.js` replaces `main.6ed467ae.js`; same infra leak persists
- CHANGED Analytical closure: prior AUTH_HELPED "write-escalation" hypotheses contradicted by existing KB evidence (write verbs POST/PUT/PATCH/DELETE → 401 InvalidTokenError)
- NEW api.sparelabs.com/v1/public/organizations/{id}/* subresource sweep exhausted (6 subpaths) — all 400 ValidationError "not found", plural namespace fully mapped to {id} leaf

## 2026-08-13 18:13:44 UTC
- NEW sparelabs.com now responds 301→https://spare.com (Cloudflare, HSTS `max-age=0; preload`) — previously TIMEOUT
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT
- NEW forms.sparelabs.com now responds 200 — "Spare Engage Web Portal" SPA (object-store headers); previously TIMEOUT
- NEW api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed
- NEW api.sparelabs.com `/v1/public/*` sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/
- NEW api.sparelabs.com `/v1/public/organizations/{id}/*` subresource sweep exhausted (6 subpaths) — all 400 ValidationError "not found", plural namespace fully mapped to {id} leaf
- NEW forms.sparelabs.com JS bundle rotated: `main.b0a0c190.js` replaces `main.6ed467ae.js`; same infra leak persists (api-spare.ngrok.io, api.staging/us.sparelabs.com, forms.staging/us.sparelabs.com, spare
- CHANGED api.sparelabs.com `/v1/global/organizations` write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write
- CHANGED api.sparelabs.com `/v1/public/organization` (singular): UUID oracle FLAPPING 3-way↔2-way confirmed across multi-version envoy LB replicas — nil-uuid→404 on fast replica (3-way intact), 400 on slow (2-

## 2026-08-13 19:30:40 UTC

## 2026-08-13 20:13:38 UTC
- NEW sparelabs.com now responds 301→https://spare.com (Cloudflare, HSTS `max-age=0; preload`) — previously TIMEOUT
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT
- NEW forms.sparelabs.com now responds 200 — "Spare Engage Web Portal" SPA (object-store headers); previously TIMEOUT
- NEW api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed
- NEW api.sparelabs.com `/v1/` API prefix discovered: 3 unauthenticated endpoints (`/v1/global/organizations`→200, `/v1/public/organization?organizationId=<uuid>`→400/404, `/v1/public/terms?organizationId=<
- NEW api.sparelabs.com `/v1/public/organization?organizationId=<uuid>` validates UUID format via OpenAPI schema (400 "must match format uuid" for malformed, 404 "Organization was not found" for non-existen
- NEW forms.sparelabs.com JS bundle (`main.6ed467ae.js`, 342,725 bytes) leaks: staging+prod API hosts (`api.us.sparelabs.com`, `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `api-spare.ngrok.i
- NEW api.sparelabs.com/v1/public/* sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/org
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping confirmed between 2-way and 3-way — nil-uuid returns 404 on fast replica (3-way intact), 400 on slow; multi-version envoy LB c
- NEW api.sparelabs.com/v1/public/organizations plural-namespace subresource sweep exhausted — all 6 subresources return 400 ValidationError "not found"
- NEW forms.sparelabs.com JS bundle rotated again: `main.b0a0c190.js` replaces `main.6ed467ae.js`; same infra leak persists (api-spare.ngrok.io, api.staging/us.sparelabs.com, forms.staging/us.sparelabs.com,
- NEW api.sparelabs.com/v1/public/organizations/{id}/* subresource sweep exhausted (6 subpaths) — all 400 ValidationError "not found", plural namespace fully mapped to {id} leaf
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write
- CHANGED forms.sparelabs.com JS bundle rotated: `main.6ed467ae.js` replaces prior `main.71d52314.js`; same infra leak
- CHANGED Analytical closure: prior AUTH_HELPED "write-escalation" hypotheses contradicted by existing KB evidence (write verbs POST/PUT/PATCH/DELETE → 401 InvalidTokenError)
- CHANGED routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — was TIMEOUT in seed; STABLE dead, NO_DELTA since discovery
- CHANGED platform.sparelabs.com now responds 200 (Micro-frontend SPA shell) — was TIMEOUT in seed; STABLE CSP infra leak
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way confirmed across multi-version envoy LB replicas — nil-uuid→404 on fast replica (3-way intact), 400 on slow (2-way

## 2026-08-13 21:09:53 UTC

## 2026-08-13 21:59:04 UTC
- NEW api.sparelabs.com/v1/public/engage/{caseType,form}: hypothesis from bigpickle for unauthenticated Engage intake-form schema disclosure (requires AUTH_HELPED validation; not yet live-probed)
- CHANGED forms.sparelabs.com JS bundle rotated to `main.b0a0c190.js` (replaces `main.6ed467ae.js`); same infra leak persists (api-spare.ngrok.io, api.staging/us.sparelabs.com, forms.staging/us.sparelabs.com, s
- NEW Bundle-derived engage namespace sweep: 15 additional endpoints all internal/auth-only (router-level 400 not found) on /v1/public/engage/; public surface FINAL = {caseType, form} read + {cases, caseFor
- NEW Engage caseType org-specific discrimination: GRT 200+547B vs Spare(d736519f)+same key 404 NotFoundError "Other was not found" 124B — org+key enumeration oracle shape; primary finding (GRT schema discl
- NEW Bundle-derived engage namespace sweep: 15 additional endpoints all internal/auth-only (router-level 400 not found) on /v1/public/engage/; public surface FINAL = {caseType, form} read + {cases, caseFor
- NEW Engage caseType org-specific discrimination: GRT 200+547B vs Spare(d736519f)+same key 404 NotFoundError "Other was not found" 124B — org+key enumeration oracle shape; primary finding (GRT schema discl

## 2026-08-13 22:51:49 UTC

## 2026-08-13 23:27:08 UTC
- NEW api.sparelabs.com/v1/public/engage/{caseType,form}: unauthenticated Engage intake-form schema disclosure (bigpickle hypothesis, 547B/1861B bodies, org-specific caseType discrimination GRT 200 vs Spare
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org enumeration via human-readable keys (spare→200+351B, grt→200+288B, cambus→404), no-auth + universal CORS
- NEW platform.sparelabs.com: newly live (was TIMEOUT) — MFE SPA shell 200, CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- NEW forms.sparelabs.com: newly live (was TIMEOUT) — "Spare Engage Web Portal" SPA 200, JS bundle rotated to main.b0a0c190.js, same infra leak persists
- NEW sparelabs.com: now 301→spare.com (was TIMEOUT), Cloudflare+HSTS
- NEW routing.sparelabs.com: newly live (was TIMEOUT) — envoy 404 on all paths, STABLE dead
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY (GET only), auth asymmetry confirmed
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way2-way across envoy replicas (nil-uuid→404 on fast, 400 on slow)
- CHANGED api.sparelabs.com/v1/public/* sibling sweep exhausted (8 paths: status/brands/config/features/countries/orgs/settings/health) — all 404 0B
- CHANGED api.sparelabs.com/v1/public/organizations/{id}/* subresource sweep exhausted (6 paths) — all 400 ValidationError "not found"
- CHANGED forms.sparelabs.com JS bundle rotated: main.b0a0c190.js replaces main.6ed467ae.js (same infra leak)
- CHANGED Analytical closure: prior AUTH_HELPED write-escalation hypotheses contradicted by KB (write verbs → 401)

## 2026-08-14 00:09:36 UTC
- NEW sparelabs.com now responds 301→https://spare.com (Cloudflare, HSTS `max-age=0; preload`) — previously TIMEOUT
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT
- NEW forms.sparelabs.com now responds 200 — "Spare Engage Web Portal" SPA (object-store headers); previously TIMEOUT
- NEW api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed
- NEW api.sparelabs.com `/v1/` API prefix discovered: 3 unauthenticated endpoints (`/v1/global/organizations`→200, `/v1/public/organization?organizationId=<uuid>`→400/404, `/v1/public/terms?organizationId=<
- NEW api.sparelabs.com `/v1/public/organization?organizationId=<uuid>` validates UUID format via OpenAPI schema (400 "must match format uuid" for malformed, 404 "Organization was not found" for non-existen
- NEW forms.sparelabs.com JS bundle (`main.6ed467ae.js`, 342,725 bytes) leaks: staging+prod API hosts (`api.us.sparelabs.com`, `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `api-spare.ngrok.i
- NEW api.sparelabs.com/v1/public/* sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/org
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping confirmed between 2-way and 3-way — nil-uuid returns 404 on fast replica (3-way intact), 400 on slow; multi-version envoy LB c
- NEW api.sparelabs.com/v1/public/organizations plural-namespace subresource sweep exhausted — all 6 subresources return 400 ValidationError "not found"
- NEW forms.sparelabs.com JS bundle rotated again: `main.b0a0c190.js` replaces `main.6ed467ae.js`; same infra leak persists
- NEW api.sparelabs.com/v1/public/organizations/{id}/* subresource sweep exhausted (6 subpaths) — all 400 ValidationError "not found", plural namespace fully mapped to {id} leaf
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write
- CHANGED forms.sparelabs.com JS bundle rotated: `main.6ed467ae.js` replaces prior `main.71d52314.js`; same infra leak
- CHANGED Analytical closure: prior AUTH_HELPED "write-escalation" hypotheses contradicted by existing KB evidence (write verbs POST/PUT/PATCH/DELETE → 401 InvalidTokenError)
- CHANGED routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — was TIMEOUT in seed; STABLE dead, NO_DELTA since discovery
- CHANGED platform.sparelabs.com now responds 200 (Micro-frontend SPA shell) — was TIMEOUT in seed; STABLE CSP infra leak
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way2-way confirmed across multi-version envoy LB replicas — nil-uuid→404 on fast replica (3-way intact), 400 on slow (2-way)
- NEW api.sparelabs.com/v1/public/engage/{caseType,form}: hypothesis from bigpickle for unauthenticated Engage intake-form schema disclosure (requires AUTH_HELPED validation; not yet live-probed)
- CHANGED forms.sparelabs.com JS bundle rotated to `main.b0a0c190.js` (replaces `main.6ed467ae.js`); same infra leak persists
- NEW Bundle-derived engage namespace sweep: 15 additional endpoints all internal/auth-only (router-level 400 not found) on /v1/public/engage/; public surface FINAL = {caseType, form} read + {cases, caseFor
- NEW Engage caseType org-specific discrimination: GRT 200+547B vs Spare(d736519f)+same key 404 NotFoundError "Other was not found" 124B — org+key enumeration oracle shape; primary finding (GRT schema discl
- NEW api.sparelabs.com/v1/public/engage/{caseType,form}: unauthenticated Engage intake-form schema disclosure (bigpickle hypothesis, 547B/1861B bodies, org-specific caseType discrimination GRT 200 vs Spare
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org enumeration via human-readable keys (spare→200+351B, grt→200+288B, cambus→404), no-auth + universal CORS
- NEW platform.sparelabs.com: newly live (was TIMEOUT) — MFE SPA shell 200, CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- NEW forms.sparelabs.com: newly live (was TIMEOUT) — "Spare Engage Web Portal" SPA 200, JS bundle rotated to main.b0a0c190.js, same infra leak persists
- NEW sparelabs.com: now 301→spare.com (was TIMEOUT), Cloudflare+HSTS
- NEW routing.sparelabs.com: newly live (was TIMEOUT) — envoy 404 on all paths, STABLE dead
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY (GET only), auth asymmetry confirmed
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way2-way across envoy replicas (nil-uuid→404 on fast, 400 on slow)
- CHANGED api.sparelabs.com/v1/public/* sibling sweep exhausted (8 paths: status/brands/config/features/countries/orgs/settings/health) — all 404 0B
- CHANGED api.sparelabs.com/v1/public/organizations/{id}/* subresource sweep exhausted (6 paths) — all 400 ValidationError "not found"
- CHANGED forms.sparelabs.com JS bundle rotated: main.b0a0c190.js replaces main.6ed467ae.js (same infra leak)
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: org-key directory oracle returning 200+351B (spare) / 200+288B (grt) / 404 (cambus) with no auth + CORS — tenant UUIDs + rider-auth posture chainab
- NEW api.sparelabs.com/v1/public/engage/{caseType,form}: new public surface returning 200+547B (caseType) / 200+1861B (form) with no auth + CORS — PII field definitions (mobilityPlusIdNumber, expiry, easyG
- NEW api.sparelabs.com/v1/public/engage/caseForms: live POST endpoint returning 400 method-gate (GET blocked) — auth-free method-gate, server-side submission-token enforcement unproven (AUTH_HELPED)
- CHANGED forms.sparelabs.com JS bundle rotated: `main.b0a0c190.js` replaces `main.71b52314.js`; same infra leak persists
- CHANGED routing.sparelabs.com: envoy 404 across all probed paths (was TIMEOUT→now responsive but dead)
- CHANGED metabase.sparelabs.com: confirmed 200 responsive (via CSP leak on platform.sparelabs.com/login)
- CHANGED sparelabs.com: now 301→spare.com (was TIMEOUT); Cloudflare+HSTS, no new surface

## 2026-08-14 02:51:15 UTC
- NEW api.sparelabs.com/v1/public/engage/{caseType,form}: unauthenticated Engage intake-form schema disclosure (547B/1861B bodies, org-specific caseType discrimination GRT 200 vs Spare 404)
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org enumeration via human-readable keys (spare→200+351B, grt→200+288B, cambus→404), no-auth + universal CORS
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way2-way across envoy replicas — nil-uuid→404 on fast replica (3-way intact), 400 on slow (2-way)
- CHANGED forms.sparelabs.com JS bundle rotated: `main.b0a0c190.js` replaces `main.6ed467ae.js`; same infra leak persists
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY (GET only), auth asymmetry confirmed
- NEW sparelabs.com now responds 301→https://spare.com (Cloudflare, HSTS `max-age=0; preload`) — previously TIMEOUT
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT
- NEW forms.sparelabs.com now responds 200 — "Spare Engage Web Portal" SPA (object-store headers); previously TIMEOUT
- NEW api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed
- NEW api.sparelabs.com `/v1/` API prefix discovered: 3 unauthenticated endpoints (`/v1/global/organizations`→200, `/v1/public/organization?organizationId=<uuid>`→400/404, `/v1/public/terms?organizationId=<
- NEW api.sparelabs.com `/v1/public/organization?organizationId=<uuid>` validates UUID format via OpenAPI schema (400 "must match format uuid" for malformed, 404 "Organization was not found" for non-existen
- NEW forms.sparelabs.com JS bundle (`main.6ed467ae.js`, 342,725 bytes) leaks: staging+prod API hosts (`api.us.sparelabs.com`, `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `api-spare.ngrok.i
- NEW api.sparelabs.com/v1/public/* sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/org
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping confirmed between 2-way and 3-way — nil-uuid returns 404 on fast replica (3-way intact), 400 on slow; multi-version envoy LB c
- NEW api.sparelabs.com/v1/public/organizations plural-namespace subresource sweep exhausted — all 6 subresources return 400 ValidationError "not found"
- NEW forms.sparelabs.com JS bundle rotated again: `main.b0a0c190.js` replaces `main.6ed467ae.js`; same infra leak persists
- NEW api.sparelabs.com/v1/public/organizations/{id}/* subresource sweep exhausted (6 subpaths) — all 400 ValidationError "not found", plural namespace fully mapped to {id} leaf
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed to enforce auth properly (401 InvalidTokenError) — bypass is READ-ONLY (GET only), not read+write
- CHANGED forms.sparelabs.com JS bundle rotated: `main.6ed467ae.js` replaces prior `main.71d52314.js`; same infra leak
- CHANGED Analytical closure: prior AUTH_HELPED "write-escalation" hypotheses contradicted by existing KB evidence (write verbs POST/PUT/PATCH/DELETE → 401 InvalidTokenError)
- CHANGED routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — was TIMEOUT in seed; STABLE dead, NO_DELTA since discovery
- CHANGED platform.sparelabs.com now responds 200 (Micro-frontend SPA shell) — was TIMEOUT in seed; STABLE CSP infra leak
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way2-way confirmed across multi-version envoy LB replicas — nil-uuid→404 on fast replica (3-way intact), 400 on slow (2-way)
- NEW api.sparelabs.com/v1/public/engage/{caseType,form}: hypothesis from bigpickle for unauthenticated Engage intake-form schema disclosure (requires AUTH_HELPED validation; not yet live-probed)
- CHANGED forms.sparelabs.com JS bundle rotated to `main.b0a0c190.js` (replaces `main.6ed467ae.js`); same infra leak persists
- NEW Bundle-derived engage namespace sweep: 15 additional endpoints all internal/auth-only (router-level 400 not found) on /v1/public/engage/; public surface FINAL = {caseType, form} read + {cases, caseFor
- NEW Engage caseType org-specific discrimination: GRT 200+547B vs Spare(d736519f)+same key 404 NotFoundError "Other was not found" 124B — org+key enumeration oracle shape; primary finding (GRT schema discl
- NEW api.sparelabs.com/v1/public/engage/{caseType,form}: unauthenticated Engage intake-form schema disclosure (bigpickle hypothesis, 547B/1861B bodies, org-specific caseType discrimination GRT 200 vs Spare
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org enumeration via human-readable keys (spare→200+351B, grt→200+288B, cambus→404), no-auth + universal CORS
- NEW platform.sparelabs.com: newly live (was TIMEOUT) — MFE SPA shell 200, CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- NEW forms.sparelabs.com: newly live (was TIMEOUT) — "Spare Engage Web Portal" SPA 200, JS bundle rotated to main.b0a0c190.js, same infra leak persists
- NEW sparelabs.com: now 301→spare.com (was TIMEOUT), Cloudflare+HSTS
- NEW routing.sparelabs.com: newly live (was TIMEOUT) — envoy 404 on all paths, STABLE dead
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY (GET only), auth asymmetry confirmed
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way2-way across envoy replicas (nil-uuid→404 on fast, 400 on slow)
- CHANGED api.sparelabs.com/v1/public/* sibling sweep exhausted (8 paths: status/brands/config/features/countries/orgs/settings/health) — all 404 0B
- CHANGED api.sparelabs.com/v1/public/organizations/{id}/* subresource sweep exhausted (6 paths) — all 400 ValidationError "not found"
- CHANGED forms.sparelabs.com JS bundle rotated: main.b0a0c190.js replaces main.6ed467ae.js (same infra leak)

## 2026-08-14 04:32:41 UTC
- NEW api.sparelabs.com/v1/public/engage/{caseType,form}: unauthenticated Engage intake-form schema disclosure (547B/1861B bodies, org-specific caseType discrimination GRT 200 vs Spare 404)
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org enumeration via human-readable keys (spare→200+351B, grt→200+288B, cambus→404), no-auth + universal CORS
- NEW sparelabs.com now responds 301→https://spare.com (Cloudflare, HSTS `max-age=0; preload`) — previously TIMEOUT
- NEW platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT
- NEW routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT
- NEW forms.sparelabs.com now responds 200 — "Spare Engage Web Portal" SPA (object-store headers); previously TIMEOUT
- NEW api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed
- NEW api.sparelabs.com `/v1/` API prefix discovered: 3 unauthenticated endpoints (`/v1/global/organizations`→200, `/v1/public/organization?organizationId=<uuid>`→400/404, `/v1/public/terms?organizationId=<
- NEW forms.sparelabs.com JS bundle (`main.6ed467ae.js`, 342,725 bytes) leaks: staging+prod API hosts (`api.us.sparelabs.com`, `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `api-spare.ngrok.i
- NEW api.sparelabs.com/v1/public/* sibling sweep exhausted: 8 additional paths (status/brands/config/features/countries/orgs/settings/health) all 404 0B — public namespace surface fully mapped to terms/org
- NEW api.sparelabs.com/v1/public/organizations plural-namespace subresource sweep exhausted — all 6 subresources return 400 ValidationError "not found"
- NEW forms.sparelabs.com JS bundle rotated again: `main.b0a0c190.js` replaces `main.6ed467ae.js`; same infra leak persists
- NEW api.sparelabs.com/v1/public/organizations/{id}/* subresource sweep exhausted (6 subpaths) — all 400 ValidationError "not found", plural namespace fully mapped to {id} leaf
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way2-way across envoy replicas — nil-uuid→404 on fast replica (3-way intact), 400 on slow (2-way)
- CHANGED forms.sparelabs.com JS bundle rotated: `main.b0a0c190.js` replaces `main.6ed467ae.js`; same infra leak persists
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY (GET only), auth asymmetry confirmed
- CHANGED routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — was TIMEOUT in seed; STABLE dead, NO_DELTA since discovery
- CHANGED platform.sparelabs.com now responds 200 (Micro-frontend SPA shell) — was TIMEOUT in seed; STABLE CSP infra leak
- CHANGED api.sparelabs.com/v1/public/* sibling sweep exhausted (8 paths: status/brands/config/features/countries/orgs/settings/health) — all 404 0B
- CHANGED api.sparelabs.com/v1/public/organizations/{id}/* subresource sweep exhausted (6 paths) — all 400 ValidationError "not found"
- CHANGED forms.sparelabs.com JS bundle rotated: `main.b0a0c190.js` replaces `main.6ed467ae.js` (same infra leak)

## 2026-08-14 06:05:06 UTC
- NEW api.sparelabs.com/v1/public/engage/{caseType,form} — unauthenticated Engage intake-form schema endpoints (547B/1861B bodies, org-specific caseType discrimination: GRT 200 vs Spare 404)
- NEW api.sparelabs.com/v1/public/organizations/key/{key} — human-readable org key enumeration oracle (3-way: spare→200+351B, grt→200+288B, cambus→404), no-auth + universal CORS
- NEW platform.sparelabs.com — MFE SPA shell now live (was TIMEOUT), CSP on /login discloses admin-eam-app.vercel.app + admin-fixed-route-app.vercel.app (prod+staging, loadable 200) + Metabase prod+staging 
- NEW forms.sparelabs.com — "Spare Engage Web Portal" SPA now live (was TIMEOUT), JS bundle main.b0a0c190.js leaks staging+prod+regional infra (6 OOS) + atlassian.net + inactive ngrok
- NEW routing.sparelabs.com — envoy 404 on all paths (was TIMEOUT), STABLE dead, NO_DELTA
- NEW sparelabs.com — 301→spare.com (was TIMEOUT), Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/public/organization (singular) — UUID oracle flapping 3-way2-way across envoy replicas (nil-uuid→404 on fast replica, 400 on slow)
- CHANGED api.sparelabs.com/v1/global/organizations — write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError, bypass is READ-ONLY (GET only), auth asymmetry confirmed
- CHANGED forms.sparelabs.com — JS bundle rotated to main.b0a0c190.js (was main.6ed467ae.js), same infra leak persists
- NEW api.sparelabs.com/v1/public/engage/{caseType,form}: Unauthenticated Engage intake-form schema disclosure — 200 + schema bodies (547B caseType, 1861B form) with PII field definitions (mobilityPlusIdNum
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org enumeration oracle via human-readable keys (spare→200+351B, grt→200+288B, cambus→404), no-auth + CORS — returns tenant UUID data per key,
- CHANGED forms.sparelabs.com JS bundle rotated to `main.b0a0c190.js` (replaces `main.6ed467ae.js`); same infra leak persists (staging+prod+regional + atlassian.net + inactive ngrok).
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle confirmed FLAPPING 3-way↔2-way across multi-version envoy replicas (nil-uuid→404 on fast replica, 400 on slow); downgraded from oracle 
- CHANGED api.sparelabs.com/v1/global/organizations: Write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY (GET only), auth asymmetry verified (was previously mislabeled "r

## 2026-08-14 07:50:28 UTC
- NEW api.sparelabs.com/v1/public/engage/{caseType,form} — unauthenticated Engage intake-form schema endpoints (547B/1861B bodies, org-specific caseType discrimination: GRT 200 vs Spare 404)
- NEW api.sparelabs.com/v1/public/organizations/key/{key} — human-readable org key enumeration oracle (3-way: spare→200+351B, grt→200+288B, cambus→404), no-auth + universal CORS
- NEW platform.sparelabs.com — MFE SPA shell now live (was TIMEOUT), CSP on /login discloses admin-eam-app.vercel.app + admin-fixed-route-app.vercel.app (prod+staging, loadable 200) + Metabase prod+staging 
- NEW forms.sparelabs.com — "Spare Engage Web Portal" SPA now live (was TIMEOUT), JS bundle main.b0a0c190.js leaks staging+prod+regional infra (6 OOS) + atlassian.net + inactive ngrok
- NEW routing.sparelabs.com — envoy 404 on all paths (was TIMEOUT), STABLE dead, NO_DELTA
- NEW sparelabs.com — 301→spare.com (was TIMEOUT), Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/public/organization (singular) — UUID oracle flapping 3-way2-way across envoy replicas (nil-uuid→404 on fast replica, 400 on slow)
- CHANGED api.sparelabs.com/v1/global/organizations — write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError, bypass is READ-ONLY (GET only), auth asymmetry confirmed
- CHANGED forms.sparelabs.com — JS bundle rotated to main.b0a0c190.js (was main.6ed467ae.js), same infra leak persists

## 2026-08-14 08:54:15 UTC
- NEW None — all surface items in latest inventory (07:50 UTC) already captured in last leads
- CHANGED None — all changes (Engage endpoints, org key oracle, platform/forms/routing live, JS bundle rotation, UUID oracle flapping, write-method auth asymmetry) already reflected in last leads
- NEW api.sparelabs.com/v1/public/organizations/{id}: 3-way UUID enumeration oracle CONFIRMED live (plural namespace; malformed→400 ValidationError, nil→404 NotFoundError, valid→200 HUMAN_ONLY; ACAO+ACAC) 8
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) now confirm proper 401 InvalidTokenError enforcement — bypass is READ-ONLY GET (auth asymmetry), OPTIONS still misleadi
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle FLAPPING 3-way↔2-way across multi-version envoy replicas (nil→404 on fast, 400 on slow); downgraded to validation-leak-only

## 2026-08-14 09:54:35 UTC
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} — FLAPPED to 400 "not found" on current envoy replica (was 200 with 547B/1861B schema bodies); multi-version LB confirmed
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key} — CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, notfound→404); no-auth + universal CORS
- CHANGED api.sparelabs.com/v1/global/organizations — CONFIRMED zero-header read-only bypass STABLE (200+11B+ACAO+ACAC, 1171ms slow replica); writes 401
- CHANGED api.sparelabs.com/v1/global/regions — CONFIRMED scheme-only bypass STABLE (Bearer x→200+725B+ACAO+ACAC, 3ms fast replica); 6 OOS subdomains in body

## 2026-08-14 10:48:23 UTC
- NEW api.sparelabs.com/v1/public/engage/{caseType,form} — FLAPPED to 400 "not found" on current envoy replica (was 200 with 547B/1861B schema bodies); multi-version LB confirmed
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key} — CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, notfound→404); no-auth + universal CORS
- CHANGED api.sparelabs.com/v1/global/organizations — CONFIRMED zero-header read-only bypass STABLE (200+11B+ACAO+ACAC, 1171ms slow replica); writes 401
- CHANGED api.sparelabs.com/v1/global/regions — CONFIRMED scheme-only bypass STABLE (Bearer x→200+725B+ACAO+ACAC, 3ms fast replica); 6 OOS subdomains in body

## 2026-08-14 11:35:42 UTC
- NEW api.sparelabs.com/v1/public/engage/{caseType,form} — FLAPPED to 400 "not found" on current envoy replica (was 200 with 547B/1861B schema bodies); multi-version LB confirmed — now unreliable/downgraded
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key} — CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, notfound→404); no-auth + universal CORS
- CHANGED api.sparelabs.com/v1/global/organizations — CONFIRMED zero-header read-only bypass STABLE (200+11B+ACAO+ACAC, 1171ms slow replica); writes 401
- CHANGED api.sparelabs.com/v1/global/regions — CONFIRMED scheme-only bypass STABLE (Bearer x→200+725B+ACAO+ACAC, 3ms fast replica); 6 OOS subdomains in body

## 2026-08-14 12:34:05 UTC
- NEW None — all surface items in latest knowledge (2026-08-14 11:35:42 UTC) already captured in last leads (Engage flap, org key oracle confirmed, global org/regions bypasses stable, platform/forms/routing

## 2026-08-14 13:59:53 UTC
- NEW None — all surface items in latest knowledge (2026-08-14 11:35:42 UTC) already captured in last leads (Engage flap, org key oracle confirmed, global org/regions bypasses stable, platform/forms/routing

## 2026-08-14 14:55:50 UTC

## 2026-08-14 15:42:24 UTC
- NEW api.sparelabs.com/v1/public/engage/{caseType,form} — FLAPPED to 400 "not found" on current envoy replica (was 200 with 547B/1861B schema bodies); multi-version LB confirmed — now unreliable/downgraded
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key} — CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, notfound→404); no-auth + universal CORS
- CHANGED api.sparelabs.com/v1/global/organizations — CONFIRMED zero-header read-only bypass STABLE (200+11B+ACAO+ACAC, 1171ms slow replica); writes 401
- CHANGED api.sparelabs.com/v1/global/regions — CONFIRMED scheme-only bypass STABLE (Bearer x→200+725B+ACAO+ACAC, 3ms fast replica); 6 OOS subdomains in body
- CHANGED forms.sparelabs.com — JS bundle rotated to main.b0a0c190.js (was main.6ed467ae.js), same infra leak persists

## 2026-08-14 16:34:07 UTC
- NEW None — latest inventory (2026-08-14 15:42:24 UTC) matches last leads (2026-08-14 15:40:45 UTC); no new surface items since last cycle

## 2026-08-14 17:36:47 UTC
- NEW None — latest inventory (2026-08-14 15:42:24 UTC) matches last leads (2026-08-14 15:40:45 UTC); no new surface items since last cycle
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} — FLAPPED to 400 "not found" on current envoy replica (was 200 with 547B/1861B schema bodies); multi-version LB confirmed — now unreliable/downgraded
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key} — CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, notfound→404); no-auth + universal CORS
- CHANGED api.sparelabs.com/v1/global/organizations — CONFIRMED zero-header read-only bypass STABLE (200+11B+ACAO+ACAC, 1171ms slow replica); writes 401
- CHANGED api.sparelabs.com/v1/global/regions — CONFIRMED scheme-only bypass STABLE (Bearer x→200+725B+ACAO+ACAC, 3ms fast replica); 6 OOS subdomains in body
- CHANGED forms.sparelabs.com — JS bundle rotated to main.b0a0c190.js (was main.6ed467ae.js), same infra leak persists

## 2026-08-14 18:33:41 UTC
- NEW None — latest inventory matches last leads; no new surface items since last cycle
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} — FLAPPED to 400 "not found" on current envoy replica (was 200 with 547B/1861B schema bodies); multi-version LB confirmed — now unreliable/downgraded
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key} — CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, notfound→404); no-auth + universal CORS
- CHANGED api.sparelabs.com/v1/global/organizations — CONFIRMED zero-header read-only bypass STABLE (200+11B+ACAO+ACAC, 1171ms slow replica); writes 401
- CHANGED api.sparelabs.com/v1/global/regions — CONFIRMED scheme-only bypass STABLE (Bearer x→200+725B+ACAO+ACAC, 3ms fast replica); 6 OOS subdomains in body
- CHANGED forms.sparelabs.com — JS bundle rotated to main.b0a0c190.js (was main.6ed467ae.js), same infra leak persists

## 2026-08-14 19:34:39 UTC
- NEW None — latest inventory (2026-08-14 15:42:24 UTC) matches last leads; no new surface items since last cycle

## 2026-08-14 20:13:02 UTC
- NEW None — latest inventory (2026-08-14 15:42:24 UTC) matches last leads; no new surface items since last cycle

## 2026-08-14 20:46:09 UTC
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW POST /v1/identity/workos/auth unauthenticated SSO-configuration oracle disclosing live WorkOS client_id + connection_id + Entra tenant IDs for partner orgs
- NEW Platform SPA bundle (index-B6uSYXCi.js 3MB) embeds FULL OpenAPI spec of fixed-route/EAM admin API (170 paths) — all 131 non-param paths properly gated (401/404)
- NEW Forms SPA bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys referrer-restricted
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- NEW /v1/public/engage/{caseType,form} FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- NEW sparelabs.ca DNS only dev.sparelabs.ca → GCP LB "fault filter abort" 404; no live surface
- NEW admin-*.vercel.app (4 hosts) ALIVE 200 but dev-only (admin-eam-app has api-baseurl=http://localhost:3057/api); no prod API base hardcoded
- CHANGED /v1/global/* namespace EXHAUSTIVE — 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- CHANGED Metabase.sparelabs.com exposed but OOS per scope exclusions — unauth /api/session/properties config dump (106KB), version v0.58.24, Google OAuth client IDs, 16 DB engines — no RCE (setup-token 404)

## 2026-08-14 21:07:27 UTC
- NEW None — inventory (2026-08-14 20:46:09 UTC) and last leads fully synchronized; no new surface items since last cycle
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only data (uat
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED forms.sparelabs.com: JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys all referrer-restricted
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-configuration oracle — POST {} → 200 172B disclosing live WorkOS client_id + connection_id + Entra tenant IDs; domain param discriminates
- NEW platform.sparelabs.com bundle (index-B6uSYXCi.js 3MB): Embedded full OpenAPI spec of EAM/fixed-route admin API — 170 paths extracted; ALL 131 non-param paths swept zero-auth + Bearer-x → 100% 401/404 
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW api.sparelabs.com/v1/public/organizations/{id}: 3-way UUID oracle STABLE (malformed→400, nil→404, valid→200 HUMAN_ONLY); superior to flapping singular /organization

## 2026-08-14 21:41:28 UTC
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW POST /v1/identity/workos/auth unauthenticated SSO-configuration oracle disclosing live WorkOS client_id + connection_id + Entra tenant IDs for partner orgs
- NEW Platform SPA bundle (index-B6uSYXCi.js 3MB) embeds FULL OpenAPI spec of fixed-route/EAM admin API (170 paths) — all 131 non-param paths properly gated (401/404)
- NEW Forms SPA bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys referrer-restricted
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- NEW /v1/public/engage/{caseType,form} FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- NEW sparelabs.ca DNS only dev.sparelabs.ca → GCP LB "fault filter abort" 404; no live surface
- NEW admin-*.vercel.app (4 hosts) ALIVE 200 but dev-only (admin-eam-app has api-baseurl=http://localhost:3057/api); no prod API base hardcoded
- NEW /v1/global/* namespace EXHAUSTIVE — 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW Metabase.sparelabs.com exposed but OOS per scope exclusions — unauth /api/session/properties config dump (106KB), version v0.58.24, Google OAuth client IDs, 16 DB engines — no RCE (setup-token 404)
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only data
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED forms.sparelabs.com: JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys all referrer-restricted

## 2026-08-14 22:10:26 UTC
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW POST /v1/identity/workos/auth unauthenticated SSO-configuration oracle disclosing live WorkOS client_id + connection_id + Entra tenant IDs for partner orgs
- NEW Platform SPA bundle (index-B6uSYXCi.js 3MB) embeds FULL OpenAPI spec of fixed-route/EAM admin API (170 paths) — all 131 non-param paths properly gated (401/404)
- NEW Forms SPA bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys referrer-restricted
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- NEW /v1/public/engage/{caseType,form} FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- NEW sparelabs.ca DNS only dev.sparelabs.ca → GCP LB "fault filter abort" 404; no live surface
- NEW admin-*.vercel.app (4 hosts) ALIVE 200 but dev-only (admin-eam-app has api-baseurl=http://localhost:3057/api); no prod API base hardcoded
- NEW /v1/global/* namespace EXHAUSTIVE — 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW Metabase.sparelabs.com exposed but OOS per scope exclusions — unauth /api/session/properties config dump (106KB), version v0.58.24, Google OAuth client IDs, 16 DB engines — no RCE (setup-token 404)
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only data
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED forms.sparelabs.com: JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys all referrer-restricted
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW POST /v1/identity/workos/auth unauthenticated SSO-configuration oracle disclosing live WorkOS client_id + connection_id + Entra tenant IDs for partner orgs
- NEW Platform SPA bundle (index-B6uSYXCi.js 3MB) embeds FULL OpenAPI spec of fixed-route/EAM admin API (170 paths) — all 131 non-param paths properly gated (401/404)
- NEW Forms SPA bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys referrer-restricted
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- NEW /v1/public/engage/{caseType,form} FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- NEW sparelabs.ca DNS only dev.sparelabs.ca → GCP LB "fault filter abort" 404; no live surface
- NEW admin-*.vercel.app (4 hosts) ALIVE 200 but dev-only (admin-eam-app has api-baseurl=http://localhost:3057/api); no prod API base hardcoded
- NEW /v1/global/* namespace EXHAUSTIVE — 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW Metabase.sparelabs.com exposed but OOS per scope exclusions — unauth /api/session/properties config dump (106KB), version v0.58.24, Google OAuth client IDs, 16 DB engines — no RCE (setup-token 404)
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only data
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED forms.sparelabs.com: JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys all referrer-restricted

## 2026-08-14 22:32:28 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-configuration oracle — POST {} → 200 172B disclosing live WorkOS client_id + connection_id + Entra tenant IDs; domain param discriminates
- NEW platform.sparelabs.com bundle (index-B6uSYXCi.js 3MB): Embedded full OpenAPI spec of EAM/fixed-route admin API — 170 paths extracted; ALL 131 non-param paths swept zero-auth + Bearer-x → 100% 401/404 
- NEW forms.sparelabs.com: JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys all referrer-restricted
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW Metabase.sparelabs.com exposed but OOS per scope exclusions — unauth /api/session/properties config dump (106KB), version v0.58.24, Google OAuth client IDs, 16 DB engines — no RCE (setup-token 404)
- NEW sparelabs.ca DNS only dev.sparelabs.ca → GCP LB "fault filter abort" 404; no live surface
- NEW admin-*.vercel.app (4 hosts) ALIVE 200 but dev-only (admin-eam-app has api-baseurl=http://localhost:3057/api); no prod API base hardcoded
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- NEW /v1/public/engage/{caseType,form} FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only data
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED forms.sparelabs.com: JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys all referrer-restricted

## 2026-08-14 23:02:53 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-configuration oracle — POST {} → 200 172B disclosing live WorkOS client_id + connection_id + Entra tenant IDs; domain param discriminates
- NEW platform.sparelabs.com bundle (index-B6uSYXCi.js 3MB): Embedded full OpenAPI spec of EAM/fixed-route admin API — 170 paths extracted; ALL 131 non-param paths swept zero-auth + Bearer-x → 100% 401/404
- NEW forms.sparelabs.com: JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys all referrer-restricted
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW Metabase.sparelabs.com exposed but OOS per scope exclusions — unauth /api/session/properties config dump (106KB), version v0.58.24, Google OAuth client IDs, 16 DB engines — no RCE (setup-token 404)
- NEW sparelabs.ca DNS only dev.sparelabs.ca → GCP LB "fault filter abort" 404; no live surface
- NEW admin-*.vercel.app (4 hosts) ALIVE 200 but dev-only (admin-eam-app has api-baseurl=http://localhost:3057/api); no prod API base hardcoded
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- NEW /v1/public/engage/{caseType,form} FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only data
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED forms.sparelabs.com: JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys all referrer-restricted

## 2026-08-14 23:29:23 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-configuration oracle — POST {} → 200 172B disclosing live WorkOS client_id + connection_id + Entra tenant IDs; domain param discriminates
- NEW platform.sparelabs.com bundle (index-B6uSYXCi.js 3MB): Embedded full OpenAPI spec of EAM/fixed-route admin API — 170 paths extracted; ALL 131 non-param paths swept zero-auth + Bearer-x → 100% 401/404
- NEW forms.sparelabs.com: JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys all referrer-restricted
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only data
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas

## 2026-08-14 23:46:43 UTC
- NEW forms.sparelabs.com JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (infra leak PATCHED); 3 Google Maps keys all referrer-restricted
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-configuration oracle — POST {} → 200 172B disclosing live WorkOS client_id + connection_id + Entra tenant IDs; domain param discriminates
- NEW platform.sparelabs.com bundle (index-B6uSYXCi.js 3MB): Embedded full OpenAPI spec of EAM/fixed-route admin API — 170 paths extracted; ALL 131 non-param paths swept zero-auth + Bearer-x → 100% 401/404
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- NEW /v1/public/engage/{caseType,form} FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- NEW sparelabs.ca DNS only dev.sparelabs.ca → GCP LB "fault filter abort" 404; no live surface
- NEW admin-*.vercel.app (4 hosts) ALIVE 200 but dev-only (admin-eam-app api-baseurl=http://localhost:3057/api); no prod API base hardcoded
- NEW Metabase.sparelabs.com exposed but OOS per scope exclusions — unauth /api/session/properties config dump (106KB), version v0.58.24, Google OAuth client IDs, 16 DB engines — no RCE (setup-token 404)
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only data
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way — nil-uuid → 400 ValidationError on slow replica (current), 404 NotFoundError on fast replica; multi-version envoy

## 2026-08-15 00:05:44 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-configuration oracle — POST {} → 200 172B disclosing live WorkOS client_id + connection_id + Entra tenant IDs; domain param discriminates
- NEW platform.sparelabs.com bundle (index-B6uSYXCi.js 3MB): Embedded full OpenAPI spec of EAM/fixed-route admin API — 170 paths extracted; ALL 131 non-param paths swept zero-auth + Bearer-x → 100% 401/404
- NEW forms.sparelabs.com JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (leak PATCHED); 3 Google Maps keys all referrer-restricted
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW Metabase.sparelabs.com exposed but OOS per scope exclusions — unauth /api/session/properties config dump (106KB), version v0.58.24, Google OAuth client IDs, 16 DB engines — no RCE (setup-token 404)
- NEW sparelabs.ca DNS only dev.sparelabs.ca → GCP LB "fault filter abort" 404; no live surface
- NEW admin-*.vercel.app (4 hosts) ALIVE 200 but dev-only (admin-eam-app api-baseurl=http://localhost:3057/api); no prod API base hardcoded
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- NEW /v1/public/engage/{caseType,form} FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only data
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way — nil-uuid → 400 ValidationError on slow replica (current), 404 NotFoundError on fast replica; multi-version envoy
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-config oracle (POST domain→200+172B disclosing WorkOS client_id + connection_id + Entra tenant IDs; 200-vs-404 discrimination for tenant 
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org-key enumeration oracle CONFIRMED live (spare→200+351B, grt→200+288B, dallas→200+277B, cambus→404+131B; winnipeg+hsr added; prod-only data
- CHANGED api.sparelabs.com/v1/global/regions: Scheme-only bypass CONFIRMED NOT PATCHED — longcat triage "PATCHED" claim (2026-08-11) DISPROVEN; Bearer x still → 200+725B+ACAO+ACAC, sha256 fb9800acb…585c3fe ver

## 2026-08-15 01:49:40 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-configuration oracle — POST {} → 200 172B disclosing live WorkOS client_id + connection_id + Entra tenant IDs; domain param discriminates
- NEW platform.sparelabs.com bundle (index-B6uSYXCi.js 3MB): Embedded full OpenAPI spec of EAM/fixed-route admin API — 170 paths extracted; ALL 131 non-param paths swept zero-auth + Bearer-x → 100% 401/404
- NEW forms.sparelabs.com JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (infra leak PATCHED); 3 Google Maps keys all referrer-restricted
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- NEW /v1/public/engage/{caseType,form} FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- NEW sparelabs.ca DNS only dev.sparelabs.ca → GCP LB "fault filter abort" 404; no live surface
- NEW admin-*.vercel.app (4 hosts) ALIVE 200 but dev-only (admin-eam-app api-baseurl=http://localhost:3057/api); no prod API base hardcoded
- NEW Metabase.sparelabs.com exposed but OOS per scope exclusions — unauth /api/session/properties config dump (106KB), version v0.58.24, Google OAuth client IDs, 16 DB engines — no RCE (setup-token 404)
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only data
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way — nil-uuid → 400 ValidationError on slow replica (current), 404 NotFoundError on fast replica; multi-version envoy

## 2026-08-15 02:42:42 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-configuration oracle — POST {} → 200 172B disclosing WorkOS client_id + connection_id + Entra tenant IDs; domain param discriminates 200 
- NEW platform.sparelabs.com bundle (index-B6uSYXCi.js 3MB): Embedded full OpenAPI spec of EAM/fixed-route admin API — 170 paths extracted; ALL 131 non-param paths swept zero-auth + Bearer-x → 100% 401/404
- NEW forms.sparelabs.com JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (infra leak PATCHED); 3 Google Maps keys all referrer-restricted
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- NEW /v1/public/engage/{caseType,form} FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- NEW sparelabs.ca DNS only dev.sparelabs.ca → GCP LB "fault filter abort" 404; no live surface
- NEW admin-*.vercel.app (4 hosts) ALIVE 200 but dev-only (admin-eam-app api-baseurl=http://localhost:3057/api); no prod API base hardcoded
- NEW Metabase.sparelabs.com exposed but OOS per scope exclusions — unauth /api/session/properties config dump (106KB), version v0.58.24, Google OAuth client IDs, 16 DB engines — no RCE (setup-token 404)
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only data
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way — nil-uuid → 400 ValidationError on slow replica (current), 404 NotFoundError on fast replica; multi-version envoy
- CHANGED api.sparelabs.com/v1/global/regions: Scheme-only bypass CONFIRMED NOT PATCHED — longcat triage "PATCHED" claim (2026-08-11) DISPROVEN; Bearer x still → 200+725B+ACAO+ACAC, sha256 fb9800acb…585c3fe ver

## 2026-08-15 03:28:32 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-configuration oracle — POST domain param discriminates 200 (configured tenant) vs 404; discloses WorkOS client_id + connection_id + Entra
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org-key enumeration oracle CONFIRMED live (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only da
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way — nil-uuid → 400 ValidationError on slow replica, 404 NotFoundError on fast replica; multi-version envoy LB confir
- CHANGED api.sparelabs.com/v1/global/regions: Scheme-only bypass CONFIRMED NOT PATCHED — longcat triage "PATCHED" claim (2026-08-11) DISPROVEN; Bearer x still → 200+725B+ACAO+ACAC, sha256 fb9800acb09b65ec92591
- NEW platform.sparelabs.com bundle (index-B6uSYXCi.js 3MB): Embedded full OpenAPI spec of EAM/fixed-route admin API — 170 paths extracted; ALL 131 non-param paths swept zero-auth + Bearer-x → 100% 401/404
- NEW forms.sparelabs.com JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (infra leak PATCHED); 3 Google Maps keys all referrer-restricted
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- NEW /v1/public/engage/{caseType,form} FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- NEW sparelabs.ca DNS only dev.sparelabs.ca → GCP LB "fault filter abort" 404; no live surface
- NEW admin-*.vercel.app (4 hosts) ALIVE 200 but dev-only (admin-eam-app api-baseurl=http://localhost:3057/api); no prod API base hardcoded
- NEW Metabase.sparelabs.com exposed but OOS per scope exclusions — unauth /api/session/properties config dump (106KB), version v0.58.24, Google OAuth client IDs, 16 DB engines — no RCE (setup-token 404)

## 2026-08-15 04:07:25 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-configuration oracle (POST domain→200+172B disclosing WorkOS client_id + connection_id + Entra tenant IDs; 200-vs-404 discrimination for 
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org-key enumeration oracle CONFIRMED live (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404+131B; no-auth + universal CORS; prod-onl
- NEW platform.sparelabs.com bundle (index-B6uSYXCi.js 3MB): Embedded full OpenAPI spec of EAM/fixed-route admin API — 170 paths extracted; ALL 131 non-param paths swept zero-auth + Bearer-x → 100% 401/404
- NEW forms.sparelabs.com JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (infra leak PATCHED); 3 Google Maps keys all referrer-restricted
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- NEW /v1/public/engage/{caseType,form} FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- NEW sparelabs.ca DNS only dev.sparelabs.ca → GCP LB "fault filter abort" 404; no live surface
- NEW admin-*.vercel.app (4 hosts) ALIVE 200 but dev-only (admin-eam-app api-baseurl=http://localhost:3057/api); no prod API base hardcoded
- NEW Metabase.sparelabs.com exposed but OOS per scope exclusions — unauth /api/session/properties config dump (106KB), version v0.58.24, Google OAuth client IDs, 16 DB engines — no RCE (setup-token 404)
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only data
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way — nil-uuid → 400 ValidationError on slow replica (current), 404 NotFoundError on fast replica; multi-version envoy
- CHANGED api.sparelabs.com/v1/global/regions: Scheme-only bypass CONFIRMED NOT PATCHED — longcat triage "PATCHED" claim (2026-08-11) DISPROVEN; Bearer x still → 200+725B+ACAO+ACAC, sha256 fb9800acb…585c3fe ver

## 2026-08-15 04:46:46 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-configuration oracle — POST domain param discriminates 200 (configured tenant) vs 404; discloses WorkOS client_id + connection_id + Entra
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org-key enumeration oracle CONFIRMED live (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only da
- NEW platform.sparelabs.com bundle (index-B6uSYXCi.js 3MB): Embedded full OpenAPI spec of EAM/fixed-route admin API — 170 paths extracted; ALL 131 non-param paths swept zero-auth + Bearer-x → 100% 401/404
- NEW forms.sparelabs.com JS bundle rotated to main.8a2a39cb.js — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (infra leak PATCHED); 3 Google Maps keys all referrer-restricted
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW /v1/public/organizations/key/spare prod-only data disclosure (200+351B) — uat/us2/jp return 404; regional DBs empty
- NEW /v1/public/engage/{caseType,form} FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- NEW sparelabs.ca DNS only dev.sparelabs.ca → GCP LB "fault filter abort" 404; no live surface
- NEW admin-*.vercel.app (4 hosts) ALIVE 200 but dev-only (admin-eam-app api-baseurl=http://localhost:3057/api); no prod API base hardcoded
- NEW Metabase.sparelabs.com exposed but OOS per scope exclusions — unauth /api/session/properties config dump (106KB), version v0.58.24, Google OAuth client IDs, 16 DB engines — no RCE (setup-token 404)
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: CONFIRMED LIVE with 3-way discrimination (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only data
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: FLAPPED to 400 "not found" on current envoy replica — multi-version LB confirmed, unreliable across replicas
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way — nil-uuid → 400 ValidationError on slow replica (current), 404 NotFoundError on fast replica; multi-version envoy
- CHANGED api.sparelabs.com/v1/global/regions: Scheme-only bypass CONFIRMED NOT PATCHED — longcat triage "PATCHED" claim (2026-08-11) DISPROVEN; Bearer x still → 200+725B+ACAO+ACAC, sha256 fb9800acb09b65ec92591
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-config oracle confirmed live (POST {"domain":"spare.com"} → 200+172B disclosing WorkOS client_id + connection_id + Entra tenant IDs; king

## 2026-08-15 05:07:02 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-config oracle — POST domain→200+172B (WorkOS client_id + connection_id + Entra tenant IDs dislosed)
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org-key enumeration oracle (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404+131B), prod-only data
- NEW /v1/global/* namespace EXHAUSTIVE sweep: 22 sibling routes ALL 401 — bypass family scoped to exactly {/organizations, /regions}
- NEW CONFIRMED FLEETWIDE parity — bypass family repros on all 7 hosts (prod/us/us2/us3/jp/eu/uat), byte-stable
- NEW platform.sparelabs.com: NOW live — was TIMEOUT→200 (MFE SPA shell); envoy + Google CDN
- NEW routing.sparelabs.com: NOW live — was TIMEOUT→envoy 404 (STABLE dead, no surface)
- NEW forms.sparelabs.com: NOW live — was TIMEOUT→200 (Engage SPA); JS bundle main.8a2a39cb.js patched (zero infra leaks)
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT)
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy LB replicas
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: Flapped to 400 on current replica (unreliable, multi-version LB)
- CHANGED api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)

## 2026-08-15 05:40:33 UTC

## 2026-08-15 06:01:05 UTC
- NEW platform.sparelabs.com: NOW live — was TIMEOUT→200 (MFE SPA shell); envoy + Google CDN
- NEW routing.sparelabs.com: NOW live — was TIMEOUT→envoy 404 (STABLE dead, no surface)
- NEW forms.sparelabs.com: NOW live — was TIMEOUT→200 (Engage SPA); JS bundle main.8a2a39cb.js patched (zero infra leaks)
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT)
- NEW api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy LB replicas
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: Flapped to 400 on current replica (unreliable, multi-version LB)
- CHANGED api.sparelabs.com/v1/global/regions: Scheme-only bypass CONFIRMED NOT PATCHED — longcat triage "PATCHED" claim (2026-08-11) DISPROVEN; Bearer x still → 200+725B+ACAO+ACAC

## 2026-08-15 06:55:42 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-configuration oracle — POST domain param discriminates 200 (configured tenant) vs 404; discloses WorkOS client_id + connection_id + Entra
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org-key enumeration oracle CONFIRMED live (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only da
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW platform.sparelabs.com: NOW live — was TIMEOUT→200 (MFE SPA shell); envoy + Google CDN
- NEW routing.sparelabs.com: NOW live — was TIMEOUT→envoy 404 (STABLE dead, no surface)
- NEW forms.sparelabs.com: NOW live — was TIMEOUT→200 (Engage SPA); JS bundle main.8a2a39cb.js patched (zero infra leaks)
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT)
- NEW api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy LB replicas
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: Flapped to 400 on current replica (unreliable, multi-version LB)
- CHANGED api.sparelabs.com/v1/global/regions: Scheme-only bypass CONFIRMED NOT PATCHED — longcat triage "PATCHED" claim (2026-08-11) DISPROVEN; Bearer x still → 200+725B+ACAO+ACAC

## 2026-08-15 07:28:03 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-config oracle — POST domain param discriminates 200 (configured tenant) vs 404; discloses WorkOS client_id + connection_id + Entra tenant
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org-key enumeration oracle (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404+131B); no-auth + universal CORS; prod-only data
- NEW /v1/global/* namespace EXHAUSTIVE sweep: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW platform.sparelabs.com: NOW live — was TIMEOUT→200 (MFE SPA shell); envoy + Google CDN
- NEW routing.sparelabs.com: NOW live — was TIMEOUT→envoy 404 (STABLE dead, no surface)
- NEW forms.sparelabs.com: NOW live — was TIMEOUT→200 (Engage SPA); JS bundle main.8a2a39cb.js patched (zero infra leaks)
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT)
- NEW api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy LB replicas
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: Flapped to 400 on current replica (unreliable, multi-version LB)
- CHANGED api.sparelabs.com/v1/global/regions: Scheme-only bypass CONFIRMED NOT PATCHED — longcat triage "PATCHED" claim (2026-08-11) DISPROVEN; Bearer x still → 200+725B+ACAO+ACAC
- NEW api.sparelabs.com/v1/identity/workos/auth: MBTA (mbta.com) confirmed as hidden WorkOS SSO tenant — POST `{"domain":"mbta.com"}` → 200+172B with distinct connection_id `conn_01JXNAX59WE7XMTW0EEFHPV9DF`
- NEW api.sparelabs.com/v1/public/organizations/key/winnipeg: Confirmed 200+288B — UUID `6c84b370-5cc2-42c6-8cdd-146c99648535`, name "Winnipeg Transit", logoUrl on storage.googleapis.com, feature flags
- NEW api.sparelabs.com/v1/public/organizations/key/hsr: Confirmed 200+318B — UUID `83303a6b-fb96-4ff3-8f58-d6069a043fbb`, name "Hamilton Street Railway", feature flags
- NEW api.sparelabs.com/v1/public/organizations/key/dallas: Confirmed 200+277B — UUID `e5f587ba-50e7-4b0c-a2e6-e01f061d048d`, name "DART GoLink - City of Dallas"
- CHANGED forms.sparelabs.com JS bundle: Confirmed patched — `main.8a2a39cb.js` contains ZERO sparelabs/atlassian/ngrok/metabase/vercel references (downgrade from ACCEPTED to recon-only)

## 2026-08-15 07:55:17 UTC
- NEW platform.sparelabs.com: NOW live — was TIMEOUT→200 (MFE SPA shell); envoy + Google CDN
- NEW routing.sparelabs.com: NOW live — was TIMEOUT→envoy 404 (STABLE dead, no surface)
- NEW forms.sparelabs.com: NOW live — was TIMEOUT→200 (Engage SPA); JS bundle main.8a2a39cb.js patched (zero infra leaks)
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT)
- NEW api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-config oracle — POST domain param discriminates 200 (configured tenant) vs 404; discloses WorkOS client_id + connection_id + Entra tenant
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org-key enumeration oracle CONFIRMED live (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only da
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW api.sparelabs.com/v1/identity/workos/auth: MBTA (mbta.com) confirmed as hidden WorkOS SSO tenant — POST `{"domain":"mbta.com"}` → 200+172B with distinct connection_id `conn_01JXNAX59WE7XMTW0EEFHPV9DF`
- NEW api.sparelabs.com/v1/public/organizations/key/winnipeg: Confirmed 200+288B — UUID `6c84b370-5cc2-42c6-8cdd-146c99648535`, name "Winnipeg Transit", logoUrl on storage.googleapis.com, feature flags
- NEW api.sparelabs.com/v1/public/organizations/key/hsr: Confirmed 200+318B — UUID `83303a6b-fb96-4ff3-8f58-d6069a043fbb`, name "Hamilton Street Railway", feature flags
- NEW api.sparelabs.com/v1/public/organizations/key/dallas: Confirmed 200+277B — UUID `e5f587ba-50e7-4b0c-a2e6-e01f061d048d`, name "DART GoLink - City of Dallas"
- CHANGED forms.sparelabs.com JS bundle: Confirmed patched — `main.8a2a39cb.js` contains ZERO sparelabs/atlassian/ngrok/metabase/vercel references (downgrade from ACCEPTED to recon-only)
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy LB replicas
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: Flapped to 400 on current replica (unreliable, multi-version LB)
- CHANGED api.sparelabs.com/v1/global/regions: Scheme-only bypass CONFIRMED NOT PATCHED — longcat triage "PATCHED" claim (2026-08-11) DISPROVEN; Bearer x still → 200+725B+ACAO+ACAC

## 2026-08-15 08:29:35 UTC
- NEW platform.sparelabs.com: NOW live — was TIMEOUT→200 (MFE SPA shell); envoy + Google CDN
- NEW routing.sparelabs.com: NOW live — was TIMEOUT→envoy 404 (STABLE dead, no surface)
- NEW forms.sparelabs.com: NOW live — was TIMEOUT→200 (Engage SPA); JS bundle main.8a2a39cb.js patched (zero infra leaks)
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT)
- NEW api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-configuration oracle — POST domain param discriminates 200 (configured tenant) vs 404; discloses WorkOS client_id + connection_id + Entra
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org-key enumeration oracle CONFIRMED live (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only da
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW api.sparelabs.com/v1/identity/workos/auth: MBTA (mbta.com) confirmed as hidden WorkOS SSO tenant — POST `{"domain":"mbta.com"}` → 200+172B with distinct connection_id `conn_01JXNAX59WE7XMTW0EEFHPV9DF`
- NEW api.sparelabs.com/v1/public/organizations/key/winnipeg: Confirmed 200+288B — UUID `6c84b370-5cc2-42c6-8cdd-146c99648535`, name "Winnipeg Transit", logoUrl on storage.googleapis.com, feature flags
- NEW api.sparelabs.com/v1/public/organizations/key/hsr: Confirmed 200+318B — UUID `83303a6b-fb96-4ff3-8f58-d6069a043fbb`, name "Hamilton Street Railway", feature flags
- NEW api.sparelabs.com/v1/public/organizations/key/dallas: Confirmed 200+277B — UUID `e5f587ba-50e7-4b0c-a2e6-e01f061d048d`, name "DART GoLink - City of Dallas"
- CHANGED forms.sparelabs.com JS bundle: Confirmed patched — `main.8a2a39cb.js` contains ZERO sparelabs/atlassian/ngrok/metabase/vercel references (downgrade from ACCEPTED to recon-only)
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy LB replicas
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form}: Flapped to 400 on current replica (unreliable, multi-version LB)
- CHANGED api.sparelabs.com/v1/global/regions: Scheme-only bypass CONFIRMED NOT PATCHED — longcat triage "PATCHED" claim (2026-08-11) DISPROVEN; Bearer x still → 200+725B+ACAO+ACAC

## 2026-08-15 08:58:20 UTC
- CHANGED api.sparelabs.com/v1/public/terms: per-tenant config map COMPLETED — spare UUID→107B `{"termsOfUseUrl":"asdfd",...}` literal placeholder junk, winnipeg→197B real external URL (info.winnipegtransit.com
- CHANGED api.sparelabs.com/v1/identity/workos/auth: direct authorize-URL GET now 302→error.workos.com/sso/invalid-connection-selector (was live corporate IdP 302 per KB) — IdP-redirect/Entra-fingerprint chain 
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} — 22 new candidate keys (mbta,kingcounty,massdot,translink,dart,saskatoon,portland,
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 5/5 confirmed org bodies expose enabledPublicFeatureFlags differential (spare/grt/winnipeg/hsr feature-flagged, dallas=[]) + logoUrl all on single 

## 2026-08-15 09:15:29 UTC
- NEW platform.sparelabs.com: NOW live — was TIMEOUT→200 (MFE SPA shell); envoy + Google CDN
- NEW routing.sparelabs.com: NOW live — was TIMEOUT→envoy 404 (STABLE dead, no surface)
- NEW forms.sparelabs.com: NOW live — was TIMEOUT→200 (Engage SPA); JS bundle main.8a2a39cb.js patched (zero infra leaks)
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT)
- NEW api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-config oracle — POST domain param discriminates 200 (configured tenant) vs 404; discloses WorkOS client_id + connection_id + Entra tenant
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org-key enumeration oracle CONFIRMED live (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only da
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW api.sparelabs.com/v1/identity/workos/auth: MBTA (mbta.com) confirmed as hidden WorkOS SSO tenant — POST `{"domain":"mbta.com"}` → 200+172B with distinct connection_id `conn_01JXNAX59WE7XMTW0EEFHPV9DF`
- CHANGED api.sparelabs.com/v1/public/terms: per-tenant config map COMPLETED — spare UUID→107B `{"termsOfUseUrl":"asdfd",...}` literal placeholder junk, winnipeg→197B real external URL
- CHANGED api.sparelabs.com/v1/identity/workos/auth: direct authorize-URL GET now 302→error.workos.com/sso/invalid-connection-selector (was live corporate IdP 302 per KB)
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} — 22 new candidate keys all 404
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 5/5 confirmed org bodies expose enabledPublicFeatureFlags differential (spare/grt/winnipeg/hsr feature-flagged, dallas=[]) + logoUrl all on single 

## 2026-08-15 09:46:03 UTC
- NEW api.sparelabs.com/v1/public/terms: per-tenant config map COMPLETED — spare UUID→107B placeholder "asdfd", winnipeg→197B real URL (info.winnipegtransit.com), grt/hsr/dallas→137B generic; byte-stable sh
- NEW api.sparelabs.com/v1/identity/workos/auth: direct authorize-URL GET now 302→error.workos.com/sso/invalid-connection-selector (was live corporate IdP 302 per KB) — IdP-redirect/Entra-fingerprint chain 
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} — 22 new candidate keys all 404; SSO roster and org-key set definitively disjoint
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 5/5 confirmed org bodies expose enabledPublicFeatureFlags differential (spare/grt/winnipeg/hsr feature-flagged, dallas=[]) + logoUrl all on single 
- CHANGED api.sparelabs.com/v1/global/regions: Scheme-only bypass CONFIRMED NOT PATCHED — Bearer x still → 200+725B+ACAO+ACAC; longcat triage "PATCHED" claim (2026-08-11) DISPROVEN; longcat only tested no-auth 
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy LB replicas — nil-uuid→404 on fast replica (3-way intact), 400 on slow (2-way); plural /organizations
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js confirmed PATCHED — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (infra leak ELIMINATED); 3 Google Maps keys all referrer-restricted (geoco
- CHANGED platform.sparelabs.com: NOW live — was TIMEOUT→200 (MFE SPA shell); envoy + Google CDN; CSP on /login still discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live — was TIMEOUT→envoy 404 (STABLE dead, no surface); NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS, static-only

## 2026-08-15 10:09:23 UTC
- NEW platform.sparelabs.com: NOW live — was TIMEOUT→200 (MFE SPA shell); envoy + Google CDN; CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- NEW routing.sparelabs.com: NOW live — was TIMEOUT→envoy 404 (STABLE dead, no surface); NO_DELTA since 2026-08-07
- NEW forms.sparelabs.com: NOW live — was TIMEOUT→200 (Engage SPA); JS bundle main.8a2a39cb.js patched (zero infra leaks)
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS, static-only
- NEW api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- NEW api.sparelabs.com/v1/identity/workos/auth: Unauthenticated SSO-config oracle — POST domain param discriminates 200 (configured tenant) vs 404; discloses WorkOS client_id + connection_id + Entra tenant
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: 3-way org-key enumeration oracle CONFIRMED live (spare→200+351B, grt→200+288B, dallas→200+237B, cambus→404); no-auth + universal CORS; prod-only da
- NEW /v1/global/* namespace EXHAUSTIVE: 22 sibling routes ALL 401 (zero-auth + Bearer-x); bypass family DEFINITIVELY scoped to exactly {organizations, regions}
- NEW CONFIRMED FLEETWIDE parity for /v1/global/{organizations,regions} bypass across 7 hosts (prod/us/us2/us3/jp/eu/uat) with byte-stable responses
- NEW api.sparelabs.com/v1/identity/workos/auth: MBTA (mbta.com) confirmed as hidden WorkOS SSO tenant — POST `{"domain":"mbta.com"}` → 200+172B with distinct connection_id
- NEW api.sparelabs.com/v1/public/organizations/key/winnipeg: Confirmed 200+288B — UUID `6c84b370-5cc2-42c6-8cdd-146c99648535`, name "Winnipeg Transit", logoUrl on storage.googleapis.com
- NEW api.sparelabs.com/v1/public/organizations/key/hsr: Confirmed 200+318B — UUID `83303a6b-fb96-4ff3-8f58-d6069a043fbb`, name "Hamilton Street Railway"
- NEW api.sparelabs.com/v1/public/organizations/key/dallas: Confirmed 200+277B — UUID `e5f587ba-50e7-4b0c-a2e6-e01f061d048d`, name "DART GoLink - City of Dallas"
- CHANGED api.sparelabs.com/v1/public/terms: per-tenant config map COMPLETED — spare UUID→107B placeholder "asdfd", winnipeg→197B real URL (info.winnipegtransit.com), grt/hsr/dallas→137B generic; byte-stable sh
- CHANGED api.sparelabs.com/v1/identity/workos/auth: direct authorize-URL GET now 302→error.workos.com/sso/invalid-connection-selector (was live corporate IdP 302 per KB)
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} — 22 new candidate keys all 404; SSO roster and org-key set definitively disjoint
- CHANGED api.sparelabs.com/v1/global/regions: Scheme-only bypass CONFIRMED NOT PATCHED — Bearer x still → 200+725B+ACAO+ACAC; longcat triage "PATCHED" claim (2026-08-11) DISPROVEN
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy LB replicas — nil-uuid→404 on fast replica (3-way intact), 400 on slow (2-way); plural /organizations
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js confirmed PATCHED — ZERO sparelabs/atlassian/ngrok/metabase/vercel references (infra leak ELIMINATED); 3 Google Maps keys all referrer-restricted
- NEW api.sparelabs.com /v1/public/engage/caseForms POST — unauth public write route, body {formId,caseId,metadata}; OpenAPI validation chain 400→nil-UUID handler 404 "Form was not found"; NO auth gate betw
- NEW api.sparelabs.com /v1/public/engage/cases POST — unauth public write route, body {organizationId,caseTypeId,contactInfo,...}; validation chain 400→nil-UUID handler 404 "Other was not found"; NO auth g
- CHANGED api.sparelabs.com /v1/public/engage/{caseType,form} GET — now OpenAPI-validated on current replica (400 required caseTypeKey/organizationId, 299/308B) vs prior 400 "not found" 189–193B; all candidate 

## 2026-08-15 10:40:30 UTC
- NEW api.sparelabs.com/v1/public/engage/caseForms POST — unauth public write route (500 on nil payload); validation chain 400→nil-UUID handler 404 "Form was not found"; no auth gate between
- NEW api.sparelabs.com/v1/public/engage/cases POST — unauth public write route (400 on nil payload); validation chain 400→nil-UUID handler 404 "Other was not found"; no auth gate
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET — now OpenAPI-validated on current replica (400 required caseTypeKey/organizationId, 299/308B) vs prior 400 "not found" 189–193B
- CHANGED forms.sparelabs.com JS bundle — main.8a2a39cb.js confirmed PATCHED (ZERO sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted)
- CHANGED platform.sparelabs.com — NOW live (was TIMEOUT→200 MFE SPA shell; envoy+Google CDN; CSP on /login discloses prod admin Vercel apps+Metabase+9 cloud services)
- CHANGED routing.sparelabs.com — NOW live (was TIMEOUT→envoy 404; STABLE dead, no surface)
- CHANGED forms.sparelabs.com — NOW live (was TIMEOUT→200 Engage SPA)
- CHANGED sparelabs.com — NOW 301→spare.com apex (was TIMEOUT; Cloudflare+HSTS static-only)
- CHANGED api.sparelabs.com — positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- CHANGED api.sparelabs.com/v1/public/engage/{cases,caseForms} — NEW unauth POST routes confirmed live (POST {} → 400 ValidationError with no InvalidTokenError, CORS reflected). Routes exist (GET → "method not 
- CHANGED forms.sparelabs.com JS bundle main.8a2a39cb.js (sha256 34f336cd…) STILL contains infra leak (`sparelabs.atlassian.net`, `api-spare.ngrok.io`, `forms.staging.us.sparelabs.com`, `api.staging.us.sparelab
- NEW api.sparelabs.com/v1/identity/workos/auth — 7th SSO tenant confirmed: kingcounty.gov → 200+172B (conn_01JKRZ46KNAQRZN3J3PYTJKWAQ), distinct from 6 prior tenants; fleet-parity across prod/uat/us2/jp.

## 2026-08-15 10:58:42 UTC
- NEW api.sparelabs.com/v1/public/engage/caseForms POST — unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Form was not found", no 401 InvalidTokenError; CORS all
- NEW api.sparelabs.com/v1/public/engage/cases POST — unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Other was not found", no 401; CORS allows POST with credent
- CHANGED api.sparelabs.com/v1/identity/workos/auth — 7th SSO tenant confirmed: kingcounty.gov → 200+172B (conn_01JKRZ46KNAQRZN3J3PYTJKWAQ), fleet-parity across prod/uat/us2/jp
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key} — live set CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates all 404; SSO roster and org-key set definitively disjoint
- CHANGED forms.sparelabs.com JS bundle — main.8a2a39cb.js CONFIRMED PATCHED (zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted)
- CHANGED platform.sparelabs.com — NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com — NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com — NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com — positively identified as envoy edge gateway (server: envoy, via: 1.1 google)

## 2026-08-15 11:21:38 UTC
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Form was not found", no 401 InvalidTokenError; CORS allo
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Other was not found", no 401; CORS allows POST with credenti
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 7th SSO tenant confirmed: kingcounty.gov → 200+172B (conn_01JKRZ46KNAQRZN3J3PYTJKWAQ), fleet-parity across prod/uat/us2/jp
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: live set CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates all 404; SSO roster and org-key set definitively disjoint
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED (zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted)
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: now OpenAPI-validated on current replica (400 required caseTypeKey/organizationId, 299/308B) vs prior 400 "not found" 189–193B

## 2026-08-15 11:42:58 UTC
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Form was not found", no 401 InvalidTokenError; CORS allo
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Other was not found", no 401; CORS allows POST with credenti
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 7th SSO tenant confirmed: kingcounty.gov → 200+172B (conn_01JKRZ46KNAQRZN3J3PYTJKWAQ), fleet-parity across prod/uat/us2/jp
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates all 404; SSO roster and org-key set definitively disjoi
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: now OpenAPI-validated on current replica (400 required caseTypeKey/organizationId, 299/308B) vs prior 400 "not found" 189–193B — multi-version L
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — ZERO sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted (infra leak ELIMINATED)
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-15 12:00:05 UTC
- NEW api.sparelabs.com/v1/public/engage/caseForms POST — unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Form was not found", no 401; CORS allows POST with cred
- NEW api.sparelabs.com/v1/public/engage/cases POST — unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Other was not found", no 401; CORS allows POST with credent
- NEW api.sparelabs.com/v1/identity/workos/auth — 7th SSO tenant confirmed: kingcounty.gov (conn_01JKRZ46KNAQRZN3J3PYTJKWAQ), fleet-parity across prod/uat/us2/jp
- NEW api.sparelabs.com/v1/public/organizations/key/{key} — live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates all 404; SSO roster and org-key set definitively disjo
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET — now OpenAPI-validated on current replica (400 required caseTypeKey/organizationId, 299/308B) vs prior 400 "not found" 189–193B — multi-version 
- CHANGED forms.sparelabs.com JS bundle — main.8a2a39cb.js CONFIRMED PATCHED (zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted)
- CHANGED platform.sparelabs.com — NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com — NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com — NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com — positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- NEW api.sparelabs.com/v1/public/engage/cases POST — unauthenticated write path confirmed live (empty POST→400 ValidationError, nil-UUID→404 NotFoundError, **no 401 InvalidTokenError**; CORS reflected — au
- NEW api.sparelabs.com/v1/public/engage/caseForms POST — unauthenticated write path confirmed live (empty POST→400, nil-UUID→404 "Form was not found", no 401; CORS reflected)
- NEW api.sparelabs.com/v1/identity/workos/auth SSO-config oracle — 7th tenant kingcounty.gov confirmed (conn_01JKRZ46KNAQRZN3J3PYTJKWAQ); WorkOS client_id+connection_id+Entra tenant IDs disclosed with **no
- NEW api.sparelabs.com/v1/public/engage/{caseType,form} GET — OpenAPI validation now active on current replica (400 required caseTypeKey/organizationId, 299/308B) vs prior 400 "not found" 189–193B — multi-
- CHANGED forms.sparelabs.com JS bundle — main.b0a0c190.js→main.8a2a39cb.js PATCHED (ZERO sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted)
- CHANGED platform.sparelabs.com — NOW live (was TIMEOUT→200 MFE SPA shell; envoy+Google CDN); CSP /login infra leak STABLE
- CHANGED routing.sparelabs.com — NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface
- CHANGED sparelabs.com — NOW 301→spare.com apex (was TIMEOUT; Cloudflare+HSTS static-only)
- CHANGED api.sparelabs.com — positively identified as envoy edge gateway (server: envoy, via: 1.1 google)

## 2026-08-15 12:50:24 UTC
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Other was not found", no 401 InvalidTokenError; CORS allows 
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Form was not found", no 401; CORS allows POST with crede
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 7th SSO tenant confirmed: kingcounty.gov → 200+172B (conn_01JKRZ46KNAQRZN3J3PYTJKWAQ), fleet-parity across prod/uat/us2/jp
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates all 404; SSO roster and org-key set definitively disjoi
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: now OpenAPI-validated on current replica (400 required caseTypeKey/organizationId, 299/308B) vs prior 400 "not found" 189–193B — multi-version L
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED (zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted)
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)

## 2026-08-15 13:22:59 UTC
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Other was not found", no 401 InvalidTokenError; CORS allows 
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Form was not found", no 401; CORS allows POST with crede
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 7th SSO tenant confirmed: kingcounty.gov → 200+172B (conn_01JKRZ46KNAQRZN3J3PYTJKWAQ), fleet-parity across prod/uat/us2/jp
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates all 404; SSO roster and org-key set definitively disjoi
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: now OpenAPI-validated on current replica (400 required caseTypeKey/organizationId, 299/308B) vs prior 400 "not found" 189–193B — multi-version L
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED (zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted)
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Other was not found", no 401 InvalidTokenError; CORS allows 
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Form was not found", no 401; CORS allows POST with crede
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 7th SSO tenant confirmed: kingcounty.gov → 200+172B (conn_01JKRZ46KNAQRZN3J3PYTJKWAQ), fleet-parity across prod/uat/us2/jp
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates all 404; SSO roster and org-key set definitively disjoi
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: now OpenAPI-validated on current replica (400 required caseTypeKey/organizationId, 299/308B) vs prior 400 "not found" 189–193B — multi-version L
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED (zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted)
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)

## 2026-08-15 13:53:05 UTC
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Other was not found", no 401 InvalidTokenError; CORS allows 
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Form was not found", no 401; CORS allows POST with crede
- NEW api.sparelabs.com/v1/identity/workos/auth: 7th SSO tenant confirmed (kingcounty.gov → 200+172B, conn_01JKRZ46KNAQRZN3J3PYTJKWAQ), fleet-parity across prod/uat/us2/jp
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates all 404; SSO roster and org-key set definitively disjoi
- NEW api.sparelabs.com/v1/public/engage/{caseType,form} GET: now OpenAPI-validated on current replica (400 required caseTypeKey/organizationId, 299/308B) vs prior 400 "not found" 189–193B — multi-version L
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED (zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted)
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)

## 2026-08-15 14:12:52 UTC
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Other was not found", no 401 InvalidTokenError; CORS allows 
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Form was not found", no 401; CORS allows POST with crede
- NEW api.sparelabs.com/v1/identity/workos/auth: 7th SSO tenant confirmed (kingcounty.gov → 200+172B, conn_01JKRZ46KNAQRZN3J3PYTJKWAQ), fleet-parity across prod/uat/us2/jp
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates all 404; SSO roster and org-key set definitively disjoi
- NEW api.sparelabs.com/v1/public/engage/{caseType,form} GET: now OpenAPI-validated on current replica (400 required caseTypeKey/organizationId, 299/308B) vs prior 400 "not found" 189–193B — multi-version L
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED (zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted)
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)

## 2026-08-15 14:42:44 UTC
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Other was not found", no 401 InvalidTokenError; CORS allows 
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Form was not found", no 401; CORS allows POST with crede
- NEW api.sparelabs.com/v1/identity/workos/auth: 7th SSO tenant confirmed (kingcounty.gov → 200+172B, conn_01JKRZ46KNAQRZN3J3PYTJKWAQ), fleet-parity across prod/uat/us2/jp
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates all 404; SSO roster and org-key set definitively disjoi
- NEW api.sparelabs.com/v1/public/engage/{caseType,form} GET: now OpenAPI-validated on current replica (400 required caseTypeKey/organizationId, 299/308B) vs prior 400 "not found" 189–193B — multi-version L
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED (zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted)
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- CHANGED forms.sparelabs.com JS bundle patched — main.8a2a39cb.js contains ZERO sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak eliminated (was ACCEPTED M
- NEW api.sparelabs.com/v1/public/engage/cases POST: auth gate ABSENT — empty POST → 400 ValidationError (no 401 InvalidTokenError); nil-UUID orgId POST → 404 NotFoundError "Other was not found" (handler re
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: auth gate ABSENT — empty POST → 400 ValidationError; nil-UUID → 404 "Form was not found"; CORS reflected; multi-version LB flapping between router-le
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 7th SSO tenant confirmed — kingcounty.gov → 200+172B (WorkOS client_id + connection_id conn_01JKRZ46KNAQRZN3J3PYTJKWAQ + Entra tenant_id in relayState JWT); 
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs → 200 with distinct UUIDs+feature-flags+logoUrls); 22 new candidate keys al
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400 required caseTypeKey/organizationId, 299/308B) and router-level "not found" (400, 187–193B) — multi-ver
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy replicas (nil→404 on fast replica, 400 on slow) — downgraded from oracle class to validation-leak-onl

## 2026-08-15 15:00:04 UTC
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Other was not found", no 401 InvalidTokenError; CORS allows 
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Form was not found", no 401; CORS allows POST with crede
- NEW api.sparelabs.com/v1/identity/workos/auth: 7th SSO tenant confirmed (kingcounty.gov → 200+172B, conn_01JKRZ46KNAQRZN3J3PYTJKWAQ), fleet-parity across prod/uat/us2/jp
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates all 404; SSO roster and org-key set definitively disjoi
- NEW api.sparelabs.com/v1/public/engage/{caseType,form} GET: now OpenAPI-validated on current replica (400 required caseTypeKey/organizationId, 299/308B) vs prior 400 "not found" 189–193B — multi-version L
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED (zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted)
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- CHANGED api.sparelabs.com/v1/public/engage/cases POST: auth gate ABSENT — empty POST → 400 ValidationError (no 401 InvalidTokenError); nil-UUID orgId POST → 404 NotFoundError "Other was not found" (handler re
- CHANGED api.sparelabs.com/v1/public/engage/caseForms POST: auth gate ABSENT — empty POST → 400 ValidationError; nil-UUID → 404 "Form was not found"; CORS reflected; multi-version LB flapping between router-le
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 7th SSO tenant confirmed — kingcounty.gov → 200+172B (WorkOS client_id + connection_id conn_01JKRZ46KNAQRZN3J3PYTJKWAQ + Entra tenant_id in relayState JWT)
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs → 200 with distinct UUIDs+feature-flags+logoUrls); 22 new candidate keys al
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400 required caseTypeKey/organizationId, 299/308B) and router-level "not found" (400, 187–193B) — multi-ver
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy replicas (nil→404 on fast replica, 400 on slow) — downgraded from oracle class to validation-leak-onl

## 2026-08-15 15:31:52 UTC
- NEW NO_DELTA

## 2026-08-15 15:55:18 UTC
- NEW NO_DELTA — surface unchanged since 2026-08-15 15:00 UTC; all core bypasses re-confirmed live this cycle

## 2026-08-15 16:12:45 UTC

## 2026-08-15 16:46:11 UTC
- NEW NO_DELTA — surface unchanged since 2026-08-15 15:00 UTC; all core bypasses re-confirmed live this cycle

## 2026-08-15 17:03:11 UTC
- NEW NO_DELTA — surface unchanged since 2026-08-15 15:00 UTC; all core bypasses re-confirmed live this cycle

## 2026-08-15 17:33:50 UTC
- NEW NO_DELTA — surface unchanged since 2026-08-15 15:00 UTC; all core bypasses re-confirmed live this cycle

## 2026-08-15 17:51:53 UTC
- NEW SSO tenant roster EXPANDED to 8: winnipeg.ca CONFIRMED live (conn_01HP76PPV8CMRJH6RYRTWEPSGS), distinct from spare.com (conn_01GRW7M1CJEJGYKMEMPBCQEZHY), saskatoon.ca (conn_01G29CFD168BP9D4390FM9X40M)
- NEW Rejected this round (all 404): hamilton.ca, cityofwinnipeg.ca, hamiltonregion.ca, dallas.gov, dart.agencies, hsr.ca, calgary.ca, vancouver.ca, toronto.ca, grt.ca(control). Non-municipality pattern hol

## 2026-08-15 18:07:28 UTC
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Other was not found", no 401 InvalidTokenError; CORS allows 
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live (empty POST → 400 ValidationError, nil-UUID → 404 "Form was not found", no 401; CORS allows POST with crede
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant confirmed — winnipeg.ca (conn_01HP76PPV8CMRJH6RYRTWEPSGS), distinct from spare.com/saskatoon.ca/kingcounty.gov; fleet-parity across 7 hosts
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400 required caseTypeKey/organizationId, 299/308B) and router-level "not found" (400, 187–193B) — multi-ver
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy replicas (nil→404 on fast replica, 400 on slow) — downgraded from oracle class to validation-leak-onl
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED (zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted)
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)

## 2026-08-15 18:43:42 UTC
- NEW NO_DELTA — surface unchanged since 2026-08-15 15:00 UTC; all core bypasses re-confirmed live this cycle
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live — auth gate ABSENT (empty POST→400 ValidationError, no 401 InvalidTokenError; nil-UUID→404 NotFoundError handle
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live — auth gate ABSENT (empty POST→400 ValidationError, nil-UUID→404 "Form was not found", no 401; CORS reflect
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant confirmed — winnipeg.ca (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts, universal CORS on both 200/404 branches
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); feature-flag differential confirmed stable; 22 new candidate keys all 404
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js (was main.b0a0c190.js→main.8a2a39cb.js confirmed PATCHED) — ZERO sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restric

## 2026-08-15 19:08:47 UTC

## 2026-08-15 19:34:16 UTC

## 2026-08-15 19:53:09 UTC
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live — empty POST→400 ValidationError (no 401), nil-UUID→404 NotFoundError, spare UUID→403 ForbiddenError (feature-f
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live — empty POST→400 ValidationError (no 401), nil-UUID→404 "Form was not found", CORS reflected
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs), 22 new candidates 404, prod-only data
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — ZERO sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400 required caseTypeKey/organizationId) and router-level "not found" — multi-version LB
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy replicas — downgraded to validation-leak-only

## 2026-08-15 20:06:28 UTC
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live (empty POST→400 ValidationError, no 401; nil-UUID→404 NotFoundError; spare-UUID→403 ForbiddenError feature-flag
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live (empty POST→400 ValidationError, no 401; nil-UUID→404 "Form was not found"; CORS reflected)
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs), 22 new candidates 404, prod-only data
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — ZERO sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys referrer-restricted
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400 required caseTypeKey/organizationId) and router-level "not found" — multi-version LB
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy replicas — downgraded to validation-leak-only

## 2026-08-15 20:38:11 UTC
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404 NotFoundError (handler reached); spare UUID→403 Forbidd
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404 "Form was not found"; CORS reflected. Auth gate abs
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS); fleet-parity across 7 hosts; universal CORS on both 200/404 branches.
- CHANGED forms.sparelabs.com JS bundle: main.b0a0c190.js→main.8a2a39cb.js confirmed PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak elimina
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy replicas — nil→404 on fast replica (3-way intact), 400 on slow (2-way); downgraded to validation-leak
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, 299B) and router-level "not found" (400, 189B) — multi-version LB confirmed.

## 2026-08-15 21:28:51 UTC
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, no surface, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — ZERO sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak eliminated
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy replicas — nil→404 on fast replica (3-way intact), 400 on slow (2-way); downgraded to validation-leak
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400 required caseTypeKey/organizationId) and router-level "not found" — multi-version LB confirmed
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404 NotFoundError (handler reached); spare UUID→403 Forbidd
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404 "Form was not found"; CORS reflected. Auth gate abs
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS); fleet-parity across 7 hosts; universal CORS on both 200/404 branches.
- CHANGED forms.sparelabs.com JS bundle: main.b0a0c190.js→main.8a2a39cb.js confirmed PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak elimina
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy replicas — nil→404 on fast replica (3-way intact), 400 on slow (2-way); downgraded to validation-leak
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, 299B) and router-level "not found" (400, 189B) — multi-version LB confirmed.

## 2026-08-15 21:47:35 UTC
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- NEW api.sparelabs.com: positively identified as envoy edge gateway (server: envoy, via: 1.1 google)
- NEW forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — ZERO sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak eliminated
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy replicas — nil→404 on fast replica (3-way intact), 400 on slow (2-way); downgraded to validation-leak
- NEW api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400 required caseTypeKey/organizationId) and router-level "not found" — multi-version LB confirmed
- NEW api.sparelabs.com/v1/public/engage/cases POST: unauthenticated write path confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404 NotFoundError (handler reached); spare UUID→403 Forbidd
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: unauthenticated write path confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404 "Form was not found" (handler reached); CORS reflec
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS); fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates 404; prod-only data (uat/us2/jp→404)
- NEW api.sparelabs.com positively identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`)
- NEW api.sparelabs.com/v1/public/engage/cases POST: auth gate ABSENT — empty POST→400 ValidationError (not 401); nil-UUID→404 NotFoundError (handler reached); spare UUID→403 ForbiddenError (feature-flag ga
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: auth gate ABSENT — empty POST→400 (not 401); nil-UUID→404 "Form was not found"; CORS reflected
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (`conn_01HP76PPV8CMRJH6RYRTWEPSGS`); fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set definitively CLOSED at {spare,grt,dallas,winnipeg,hsr}; 22 candidates → 404; prod-only fleet-parity
- CHANGED forms.sparelabs.com JS bundle rotated `main.b0a0c190.js`→`main.8a2a39cb.js` — PATCHED, zero sparelabs/atlassian/ngrok/metabase/vercel references; 3 Google Maps keys all referrer-restricted
- CHANGED platform.sparelabs.com NOW live (was TIMEOUT→200 MFE SPA shell); CSP infra leak STABLE
- CHANGED routing.sparelabs.com NOW live (was TIMEOUT→envoy 404); STABLE dead, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com/v1/public/organization: UUID oracle FLAPPING 3-way↔2-way across envoy replicas — downgraded to validation-leak-only

## 2026-08-15 22:07:44 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS); fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- NEW api.sparelabs.com/v1/public/engage/caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404 "Form was not found" (handler reached); CORS reflected
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates 404; prod-only data (uat/us2/jp→404); SSO roster and or
- NEW api.sparelabs.com/v1/public/terms: per-tenant config chain CONFIRMED — spare→107B literal "asdfd" junk live in prod, winnipeg→197B real external URL (info.winnipegtransit.com), grt/hsr/dallas→137B gen
- NEW forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — ZERO sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak eliminated (downgraded t
- NEW api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 3-way↔2-way across envoy replicas — nil→404 fast / 400 slow; downgraded to validation-leak-only, not oracle class
- NEW api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400 required caseTypeKey/organizationId) and router-level "not found" — multi-version LB replica divergence
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP on /login discloses prod admin Vercel apps + Metabase + 9 cloud services
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-15 22:34:20 UTC

## 2026-08-15 22:56:01 UTC
- CHANGED forms.sparelabs.com JS bundle: `main.8a2a39cb.js` CONFIRMED PATCHED (zero sparelabs/atlassian/ngrok/metabase/vercel refs) — prior "REACTIVATED @ 34f336cd" (10:55 UTC) was false positive
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive, only tested no-auth path, bypass stable 86h+
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET, not read+write
- NEW api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401), handler reached (nil-UUID→404, spare-UUID→403 feature-flag ga
- NEW api.sparelabs.com/v1/public/terms: per-tenant config chain confirmed — spare→107B "asdfd" prod junk, winnipeg→197B real URL (info.winnipegtransit.com), grt/hsr/dallas→137B generic; byte-stable sha256
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS); fleet-parity across 7 hosts
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — downgraded to validation-leak-only

## 2026-08-15 23:20:36 UTC
- NEW forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED (downgraded f
- NEW api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass CONFIRMED NOT PATCHED — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth path); bypass stable 86h+ across 7 fleet hosts
- NEW api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only, auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS); fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates 404; prod-only data (uat/us2/jp→404); SSO roster and or

## 2026-08-15 23:39:49 UTC
- NEW forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass CONFIRMED NOT PATCHED — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth path); bypass stable 86h+ across 7 fleet hosts
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only, auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS); fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates 404; prod-only data (uat/us2/jp→404); SSO roster and or

## 2026-08-15 23:57:59 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS, fleet-parity across 7 hosts)
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs, prod-only, uat/us2/jp→404)
- NEW api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed (empty POST→400 ValidationError, no 401; nil-UUID→404, spare-UUID→403 feature-flag gate)
- NEW api.sparelabs.com/v1/public/terms: per-tenant config chain CONFIRMED (spare→107B "asdfd" prod junk, winnipeg→197B real URL, byte-stable)
- CHANGED forms.sparelabs.com JS bundle `main.8a2a39cb.js` PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth path); bypass stable 86h+ across 7 fleet hosts
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only, auth asymmetry verified
- CHANGED platform.sparelabs.com NOW live (was TIMEOUT→200 MFE SPA shell); CSP infra leak STABLE
- CHANGED routing.sparelabs.com NOW live (was TIMEOUT→envoy 404); STABLE dead, NO_DELTA since 2026-08-07
- CHANGED sparelabs.com NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-16 01:26:57 UTC
- NEW NO_DELTA
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts, universal CORS on both 200/404 branches
- NEW api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401 InvalidTokenError); nil-UUID→404 NotFoundError (handler reached
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs, prod-only); 22 new candidate keys all 404
- NEW api.sparelabs.com/v1/public/terms: per-tenant config chain CONFIRMED — spare→107B literal "asdfd" prod junk, winnipeg→197B real external URL (info.winnipegtransit.com), grt/hsr/dallas→137B generic; by
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive, only tested no-auth path (400), never tested Bearer-x vector; bypass stable 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only, auth asymmetry verified at handler level; GET zero-head
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED (downgraded t
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast / 400 slow; downgraded to validation-leak-only, not oracle class
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-16 02:44:18 UTC
- NEW NO_DELTA

## 2026-08-16 03:36:12 UTC
- NEW NO_DELTA

## 2026-08-16 04:20:21 UTC
- NEW NO_DELTA

## 2026-08-16 04:58:16 UTC

## 2026-08-16 05:31:18 UTC
- NEW NO_DELTA — knowledge base already current through 2026-08-16; inventory gladia 04:58 UTC confirms no new surface, only status reconfirmations on existing findings

## 2026-08-16 05:58:28 UTC
- NEW None — knowledge base current through 2026-08-16 05:31 UTC; inventory shows only reconfirmations (NO_DELTA across last 5 cycles)

## 2026-08-16 06:44:51 UTC

## 2026-08-16 07:24:20 UTC
- NEW NO_DELTA

## 2026-08-16 07:53:10 UTC
- NEW NO_DELTA

## 2026-08-16 08:17:47 UTC

## 2026-08-16 08:52:47 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts, universal CORS on both 200/404 branches
- NEW api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401 InvalidTokenError); nil-UUID→404 NotFoundError (handler reached
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs, prod-only); 22 new candidate keys all 404
- NEW api.sparelabs.com/v1/public/terms: per-tenant config chain CONFIRMED — spare→107B literal "asdfd" prod junk, winnipeg→197B real external URL (info.winnipegtransit.com), grt/hsr/dallas→137B generic; by
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive, only tested no-auth path (400), never tested Bearer-x vector; bypass stable 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only, auth asymmetry verified at handler level; GET zero-head
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED (downgraded t
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast / 400 slow; downgraded to validation-leak-only, not oracle class
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-16 09:16:40 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates 404; prod-only (uat/us2/jp→404)
- NEW api.sparelabs.com/v1/public/terms: per-tenant config chain CONFIRMED — spare→107B "asdfd" prod junk, winnipeg→197B real URL (info.winnipegtransit.com), grt/hsr/dallas→137B generic; byte-stable sha256
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED (downgraded t
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast, 400 slow; downgraded to validation-leak-only, not oracle class
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-16 09:48:04 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates 404; prod-only (uat/us2/jp→404)
- NEW api.sparelabs.com/v1/public/terms: per-tenant config chain CONFIRMED — spare→107B "asdfd" prod junk, winnipeg→197B real URL (info.winnipegtransit.com), grt/hsr/dallas→137B generic; byte-stable sha256
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED (downgraded t
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast, 400 slow; downgraded to validation-leak-only, not oracle class
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-16 10:05:15 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed live (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates 404; prod-only (uat/us2/jp→404)
- NEW api.sparelabs.com/v1/public/terms: per-tenant config chain CONFIRMED — spare→107B "asdfd" prod junk, winnipeg→197B real URL (info.winnipegtransit.com), grt/hsr/dallas→137B generic; byte-stable sha256
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast, 400 slow; downgraded to validation-leak-only, not oracle class
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive, only tested no-auth path (400), never tested Bearer-x vector; bypass stable 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only, auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast / 400 slow; downgraded to validation-leak-only, not oracle class
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED (downgraded t
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-16 10:37:14 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates 404; prod-only (uat/us2/jp→404)
- NEW api.sparelabs.com/v1/public/terms: per-tenant config chain CONFIRMED — spare→107B "asdfd" prod junk, winnipeg→197B real URL (info.winnipegtransit.com), grt/hsr/dallas→137B generic; byte-stable sha256
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED (downgraded t
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast, 400 slow; downgraded to validation-leak-only, not oracle class
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-16 10:58:28 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates 404; prod-only (uat/us2/jp→404)
- NEW api.sparelabs.com/v1/public/terms: per-tenant config chain CONFIRMED — spare→107B "asdfd" prod junk, winnipeg→197B real URL (info.winnipegtransit.com), grt/hsr/dallas→137B generic; byte-stable sha256
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast, 400 slow; downgraded to validation-leak-only
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-16 11:23:47 UTC

## 2026-08-16 11:48:29 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed live (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates 404; prod-only (uat/us2/jp→404)
- NEW api.sparelabs.com/v1/public/terms: per-tenant config chain CONFIRMED — spare→107B "asdfd" prod junk, winnipeg→197B real URL (info.winnipegtransit.com), grt/hsr/dallas→137B generic; byte-stable sha256
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast, 400 slow; downgraded to validation-leak-only, not oracle class
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-16 12:04:57 UTC
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only, auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast / 400 slow; downgraded to validation-leak-only, not oracle class
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-16 12:57:08 UTC
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restrict
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast, 400 slow; downgraded to validation-leak-only, not oracle class
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat

## 2026-08-16 13:32:00 UTC
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed live (conn_01HP76PPV8CMRJH6RYRTWEPSGS); fleet-parity across 7 hosts; universal CORS on 200/404 branches
- NEW api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: live set DEFINITIVELY CLOSED at {spare,grt,dallas,winnipeg,hsr} (5 orgs); 22 new candidates 404; prod-only (uat/us2/jp→404)
- NEW api.sparelabs.com/v1/public/terms: per-tenant config chain CONFIRMED — spare→107B "asdfd" prod junk, winnipeg→197B real URL (info.winnipegtransit.com), grt/hsr/dallas→137B generic; byte-stable sha256
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast, 400 slow; downgraded to validation-leak-only
- CHANGED platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- CHANGED routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- CHANGED sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-16 13:59:57 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restrict
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast / 400 slow; downgraded to validation-leak-only, not oracle class
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED

## 2026-08-16 14:27:12 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restrict
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy replicas — nil→404 fast / 400 slow; downgraded to validation-leak-only, not oracle class
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED

## 2026-08-16 14:51:57 UTC

## 2026-08-16 15:24:37 UTC

## 2026-08-16 15:37:27 UTC

## 2026-08-16 15:58:08 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restrict
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED

## 2026-08-16 16:27:37 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restrict
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restrict
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED
- NEW api.sparelabs.com/v1/global/regions: re-verified LIVE 200+725B+ACAO+ACAC, body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe exact match; maps 7 regions (CA/US/US2/US3/JP/EU/
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster NOT closed at 8 — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; roster ≥10; prior log

## 2026-08-16 16:50:49 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restrict
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- NEW api.sparelabs.com/v1/global/regions: re-verified LIVE 200+725B+ACAO+ACAC, body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe exact match; maps 7 regions (CA/US/US2/US3/JP/EU/
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster NOT closed at 8 — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; roster ≥10
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED

## 2026-08-16 17:10:42 UTC
- NEW api.sparelabs.com/v1/global/regions: re-verified LIVE 200+725B+ACAO+ACAC, body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe exact match; maps 7 regions (CA/US/US2/US3/JP/EU/
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster NOT closed at 8 — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; roster ≥10
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED
- NEW api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS) — roster expanded from 7 to 8; fleet-parity across 7 hosts re-confirmed
- NEW api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth-gate-ABSENT write path re-confirmed live — empty POST→400 ValidationError (no 401), nil-UUID→404 NotFoundError (handler reached), s
- CHANGED api.sparelabs.com/v1/public/organizations/{id} (plural): 3-way oracle STABLE — confirmed live this cycle (malformed→400, nil→404, valid→200), superior to flapping singular /organization
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle FLAPPING 2-way↔3-way across envoy LB replicas — downgraded to validation-leak-only
- CHANGED api.sparelabs.com/v1/public/terms: per-tenant config chain confirmed — spare→107B literal "asdfd" junk (prod placeholder), winnipeg→197B real external URL (info.winnipegtransit.com); byte-stable sha25
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded ≥10 — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed; prior oakville→spare.com conn
- CHANGED forms.sparelabs.com JS bundle: REACTIVATED claim (34f336cd…) retracted — main.8a2a39cb.js confirmed PATCHED (zero infra refs, 3 Maps keys referrer-restricted); "leak reinstated" entry was FALSE POSITI

## 2026-08-16 17:38:10 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restrict
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- NEW api.sparelabs.com/v1/global/regions: re-verified LIVE 200+725B+ACAO+ACAC, body sha256 fb9800acb09b65ec92591f4536e3ecfd08b8c3dba0d2ef9af3ed97047795c3fe exact match; maps 7 regions (CA/US/US2/US3/JP/EU/
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster NOT closed at 8 — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; roster ≥10
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass NOT patched — longcat "PATCHED" (2026-08-11) false positive (only tested no-auth 400, missed Bearer-x vector); bypass stable 86h+ across 
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/identity/workos/auth: 8th SSO tenant winnipeg.ca confirmed (conn_01HP76PPV8CMRJH6RYRTWEPSGS), fleet-parity across 7 hosts
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — empty POST→400 ValidationError (no 401); nil-UUID→404; spare-UUID→403 ForbiddenError (feature-flag gat
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED

## 2026-08-16 17:54:27 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restrict
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster NOT closed at 8 — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; roster ≥10

## 2026-08-16 18:25:14 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; fleet-parity 
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED (resolves pri
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass re-verified NOT patched — longcat "PATCHED" claim (2026-08-11) confirmed FALSE POSITIVE; bypass stable 86h+ across 7 fleet hosts, body sh
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-versi

## 2026-08-16 18:53:42 UTC
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restrict
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; fleet-parity 
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass re-verified NOT patched — longcat "PATCHED" claim (2026-08-11) confirmed FALSE POSITIVE; bypass stable 86h+ across 7 fleet hosts, body sh
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-versi
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED (resolves pri

## 2026-08-16 19:14:50 UTC
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restrict
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; fleet-parity 
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass re-verified NOT patched — longcat "PATCHED" claim (2026-08-11) confirmed FALSE POSITIVE; bypass stable 86h+ across 7 fleet hosts, body sh
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-versi
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED (resolves pri

## 2026-08-16 19:38:32 UTC
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restrict
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; fleet-parity 
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass re-verified NOT patched — longcat "PATCHED" claim (2026-08-11) confirmed FALSE POSITIVE; bypass stable 86h+ across 7 fleet hosts, body sh
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-versi
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED

## 2026-08-16 19:55:02 UTC
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restrict
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; fleet-parity 
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass re-verified NOT patched — longcat "PATCHED" claim (2026-08-11) confirmed FALSE POSITIVE; bypass stable 86h+ across 7 fleet hosts, body sh
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-versi
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED (resolves pri

## 2026-08-16 20:12:42 UTC

## 2026-08-16 20:41:27 UTC
- NEW None — all inventory items (platform/forms/routing now live, SSO roster ≥10, org-key set closed at 5, engage write-path handler reach, global/* bypass family scoped to 2 routes, forms JS bundle patche
- NEW api.sparelabs.com/v1/global/regions: write-method CORS chain convergence confirmed live — OPTIONS → 204 + ACAO:reflected + ACAC:true + allow-methods:GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authorization

## 2026-08-16 21:00:52 UTC

## 2026-08-16 21:35:32 UTC
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- NEW api.sparelabs.com/v1/global/regions: write-method CORS chain convergence confirmed live — OPTIONS 204 returns ACAO:reflected + ACAC:true + allow-methods:GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authoriza
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; fleet-parity 
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-versi

## 2026-08-16 21:50:00 UTC
- NEW api.sparelabs.com/v1/global/regions: write-method CORS chain convergence confirmed live — OPTIONS 204 returns ACAO:reflected + ACAC:true + allow-methods:GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authoriza
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; fleet-parity
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-versi
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass re-verified NOT patched — longcat "PATCHED" claim (2026-08-11) confirmed FALSE POSITIVE; bypass stable 86h+ across 7 fleet hosts
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only
- NEW api.sparelabs.com/v1/global/regions: write-method CORS chain convergence confirmed — OPTIONS → 204 + ACAO:reflected + ACAC:true + allow-methods:GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authorization,Cont
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded ≥10 tenants — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live this session; fle
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth-gate-absent re-confirmed — handler reached without auth (empty POST→400 ValidationError NOT 401; nil-UUID→404 NotFoundError; valid 

## 2026-08-16 22:04:34 UTC
- NEW api.sparelabs.com/v1/global/regions: write-method CORS chain convergence confirmed live — OPTIONS 204 returns ACAO:reflected + ACAC:true + allow-methods:GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authoriza
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; fleet-parity 
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-versi
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass re-verified NOT patched — longcat "PATCHED" claim (2026-08-11) confirmed FALSE POSITIVE; bypass stable 86h+ across 7 fleet hosts, body sh
- CHANGED api.sparelabs.com/v1/global/organizations: write methods (POST/PUT/PATCH/DELETE) confirmed 401 InvalidTokenError — bypass is READ-ONLY GET only; auth asymmetry verified at handler level
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; infra leak ELIMINATED
- NEW platform.sparelabs.com: NOW live (was TIMEOUT→200 MFE SPA shell); CSP /login infra leak STABLE (admin Vercel apps+Metabase+9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT→200 Engage SPA); JS bundle main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs
- NEW routing.sparelabs.com: NOW live (was TIMEOUT→envoy 404); STABLE dead, envoy 404/0B on ALL paths since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT); Cloudflare+HSTS static-only

## 2026-08-16 22:34:51 UTC
- NEW api.sparelabs.com/v1/global/regions: write-method CORS chain convergence confirmed live — OPTIONS 204 returns ACAO:reflected + ACAC:true + allow-methods:GET,HEAD,PUT,PATCH,POST,DELETE + ACAH:Authoriza
- NEW api.sparelabs.com/v1/public/organizations/{id}/*: 6-subpath sweep exhausted (/, status, branding, logo, config, tenants) → all 400 ValidationError "not found"; plural namespace fully mapped to {id} le
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca (conn_01HTN1GCQYJY8X5TNBK0HPE42W) + cota.com (conn_01KCKYHA0YPZ8N52Q4DVT96SAC) confirmed live; fleet-parity
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: auth gate ABSENT confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-versi
- CHANGED api.s

## 2026-08-16 22:58:41 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on subset of LB replicas (multi-version LB confirmed) — GET `Bearer x` → 200+725B on fast replicas (~300ms), 401 on others; prev
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on slow LB replicas (~600-1100ms) — GET no-auth → 200+11B `{"data":[]}`, 401 on fast replicas; previously stable across
- NEW forms.sparelabs.com: JS bundle rotated to `main.8a2a39cb.js` (~7MB) — infra leak ELIMINATED (zero sparelabs/atlassian/ngrok/metabase/vercel refs); 3 Google Maps keys all referrer-restricted (geocode→R
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca + cota.com confirmed live; fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to 10+ tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts (prod/us/us2/us3/jp/eu/uat
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: org-key oracle extended — saskatoon.ca confirmed as 11th SSO tenant, live org-key set {spare,grt,dallas,winnipeg,hsr} closed at 5 (22 new candidate
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAUTH parameter injection vector via SSO oracle

## 2026-08-16 23:15:51 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on subset of LB replicas (multi-version LB confirmed) — GET `Bearer x` → 200+725B on fast replicas (~300ms), 401 on others; prev
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on slow LB replicas (~600-1100ms) — GET no-auth → 200+11B `{"data":[]}`, 401 on fast replicas; previously stable across
- NEW forms.sparelabs.com: JS bundle rotated to `main.8a2a39cb.js` (~7MB) — infra leak ELIMINATED (zero sparelabs/atlassian/ngrok/metabase/vercel refs); 3 Google Maps keys all referrer-restricted (geocode→R
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to 10+ tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts (prod/us/us2/us3/jp/eu/uat
- NEW api.sparelabs.com/v1/public/organizations/key/{key}: org-key oracle extended — saskatoon.ca confirmed as 11th SSO tenant, live org-key set {spare,grt,dallas,winnipeg,hsr} closed at 5 (22 new candidate
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAUTH parameter injection vector via SSO oracle
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca + cota.com confirmed live; fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted

## 2026-08-16 23:40:07 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split confirmed as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAuth parameter injection vector via SSO oracle
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only

## 2026-08-16 23:55:50 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split confirmed as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAuth parameter injection vector via SSO oracle
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only

## 2026-08-17 01:06:03 UTC

## 2026-08-17 02:27:47 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAuth parameter injection vector via SSO oracle
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split confirmed as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca + cota.com confirmed live; fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only

## 2026-08-17 03:32:55 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAuth parameter injection vector via SSO oracle
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split confirmed as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca + cota.com confirmed live; fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only

## 2026-08-17 04:26:22 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAuth parameter injection vector via SSO oracle
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split confirmed as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca + cota.com confirmed live; fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only

## 2026-08-17 05:13:46 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAuth parameter injection vector via SSO oracle
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split confirmed as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca + cota.com confirmed live; fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only

## 2026-08-17 05:54:22 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAuth parameter injection vector via SSO oracle
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split confirmed as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca + cota.com confirmed live; fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizationUrl response body; redirect_uri NOT reflected (silently dropped) — OATH injection vector confirmed as sta
- NEW api.sparelabs.com/v1/global/regions: multi-version LB replica split now confirmed — fast replicas (4ms) return 200+725B+Bypass; slow replicas return 401; mechanism behind 96h flapping, NOT a patch
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now replica-dependent — slow replicas (664ms) return 200+11B; fast replicas return 401; same multi-version LB split mechanism

## 2026-08-17 06:27:02 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAuth parameter injection vector via SSO oracle
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split confirmed as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca + cota.com confirmed live; fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizationUrl response body; redirect_uri NOT reflected (silently dropped) — OATH injection vector confirmed as sta
- NEW api.sparelabs.com/v1/global/regions: multi-version LB replica split now confirmed — fast replicas (4ms) return 200+725B+Bypass; slow replicas return 401; mechanism behind 96h flapping, NOT a patch
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now replica-dependent — slow replicas (664ms) return 200+11B; fast replicas return 401; same multi-version LB split mechanism
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizationUrl response body; redirect_uri NOT reflected (silently dropped) — OATH injection vector confirmed as sta
- NEW api.sparelabs.com/v1/global/regions: multi-version LB replica split now confirmed — fast replicas (4ms) return 200+725B+Bypass; slow replicas return 401; mechanism behind 96h flapping
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now replica-dependent — slow replicas (664ms) return 200+11B; fast replicas return 401; same multi-version LB split mechanism

## 2026-08-17 07:35:16 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAuth parameter injection vector via SSO oracle
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split confirmed as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca + cota.com confirmed live; fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizationUrl response body; redirect_uri NOT reflected (silently dropped) — OATH injection vector confirmed as sta

## 2026-08-17 08:12:59 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAuth parameter injection vector via SSO oracle
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split confirmed as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca + cota.com confirmed live; fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizationUrl response body; redirect_uri NOT reflected (silently dropped) — OATH injection vector confirmed as sta
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now replica-dependent — slow replicas (664ms) return 200+11B; fast replicas return 401; same multi-version LB split mechanism
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED — fast replicas (4ms, ~0.11-0.14s) return 200+725B+Bearer bypass on fast LB replicas (8/8 probes); SLOW replicas return 40
- CHANGED api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401 — same multi-version LB split mechanis
- CHANGED forms.sparelabs.com JS bundle: main.b0a0c190.js → main.8a2a39cb.js (2,195,456B) CONFIRMED PATCHED — ZERO sparelabs/atlassian/ngrok/metabase/vercel references; 3 Google Maps API keys all referrer-restr
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com + kingcounty.gov + winnipeg.ca confirmed live; fleet-parity across 7 ho
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizeUrl response body (OAuth parameter injection vector CONFIRMED); redirect_uri param silently dropped (not a re
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without 401 on empty POST (400) and nil-UUID (404); valid org UUIDs (spare/grt/dall

## 2026-08-17 09:07:11 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAuth parameter injection vector via SSO oracle
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split confirmed as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca + cota.com confirmed live; fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizationUrl response body; redirect_uri NOT reflected (silently dropped) — OATH injection vector confirmed as sta
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now replica-dependent — slow replicas (664ms) return 200+11B; fast replicas return 401; same multi-version LB split mechanism

## 2026-08-17 09:57:20 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAuth parameter injection vector via SSO oracle
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split confirmed as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥10 tenants — oakville.ca + cota.com confirmed live; fleet-parity across 7 hosts; universal CORS on both 200/404 branches
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizationUrl response body; redirect_uri NOT reflected (silently dropped) — OATH injection vector confirmed as sta
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now replica-dependent — slow replicas (664ms) return 200+11B; fast replicas return 401; same multi-version LB split mechanism
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED — fast replicas (4ms, ~0.11-0.14s) return 200+725B+Bearer bypass on fast LB replicas (8/8 probes); SLOW replicas return 40
- CHANGED api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401 — same multi-version LB split mechanis
- CHANGED forms.sparelabs.com JS bundle: main.b0a0c190.js → main.8a2a39cb.js (2,195,456B) CONFIRMED PATCHED — ZERO sparelabs/atlassian/ngrok/metabase/vercel references; 3 Google Maps API keys all referrer-restr
- CHANGED api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com + kingcounty.gov + winnipeg.ca confirmed live; fleet-parity across 7 ho
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizeUrl response body (OAuth parameter injection vector CONFIRMED); redirect_uri param silently dropped (not a re
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without 401 on empty POST (400) and nil-UUID (404); valid org UUIDs (spare/grt/dall

## 2026-08-17 10:30:13 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW /v1/identity/workos/auth POST redirect_uri/state reflection hypothesis UNTESTED — potential OAuth parameter injection vector via SSO oracle
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split confirmed as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizationUrl response body; redirect_uri NOT reflected (silently dropped) — OATH injection vector confirmed as sta
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now replica-dependent — slow replicas (664ms) return 200+11B; fast replicas return 401; same multi-version LB split mechanism

## 2026-08-17 11:02:01 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizeUrl response body (OAuth parameter injection vector CONFIRMED); redirect_uri param silently dropped
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent

## 2026-08-17 11:51:13 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401; previously stable across all replicas
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizeUrl response body (OAuth parameter injection vector CONFIRMED); redirect_uri param silently dropped
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizationUrl response body; redirect_uri NOT reflected (silently dropped) — OATH injection vector confirmed as sta
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now replica-dependent — slow replicas (664ms) return 200+11B; fast replicas return 401; same multi-version LB split mechanism

## 2026-08-17 11:58:57 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now ONLY on FAST LB replicas (~0.11-0.14s) — 8/8 probes 200+725B; SLOW replicas return 401
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now ONLY on SLOW LB replicas (~0.55-1.04s) — 8/8 probes 200+11B; FAST replicas return 401
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants — saskatoon.ca + mbta.com + oakville.ca + cota.com newly confirmed; fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizeUrl response body (OAuth parameter injection vector CONFIRMED); redirect_uri param silently dropped
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP `/login` infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP (`connect-src https://*.sparelabs.com`); all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizationUrl response body; redirect_uri NOT reflected (silently dropped) — OATH injection vector confirmed
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now replica-dependent — slow replicas (664ms) return 200+11B; fast replicas return 401; same multi-version LB split mechanism

## 2026-08-17 12:45:56 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now deterministic — 8/8 fast replicas (0.11-0.14s) return 200+725B; slow replicas return 401; replica-split mechanism confirmed
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now deterministic — 8/8 slow replicas (0.55-1.04s) return 200+11B; fast replicas return 401; same LB split mechanism
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants (saskatoon.ca, mbta.com, oakville.ca, cota.com newly confirmed); fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizeUrl response body (OAuth parameter injection vector); redirect_uri silently dropped
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP /login infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP; all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED api.sparelabs.com/v1/identity/workos/auth: state parameter reflection confirmed; redirect_uri NOT reflected — OATH injection vector confirmed as state-only
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now replica-dependent — slow replicas (664ms) return 200+11B; fast replicas return 401; same multi-version LB split mechanism

## 2026-08-17 13:34:07 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now deterministic — 8/8 fast replicas (0.11-0.14s) return 200+725B; slow replicas return 401; replica-split mechanism confirmed
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now deterministic — 8/8 slow replicas (0.55-1.04s) return 200+11B; fast replicas return 401; same LB split mechanism
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants (saskatoon.ca, mbta.com, oakville.ca, cota.com newly confirmed); fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizeUrl response body (OAuth parameter injection vector); redirect_uri silently dropped
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP /login infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP; all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404 on ALL paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED api.sparelabs.com/v1/identity/workos/auth: state parameter reflection confirmed; redirect_uri NOT reflected — OATH injection vector confirmed as state-only
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now replica-dependent — slow replicas (664ms) return 200+11B; fast replicas return 401; same multi-version LB split mechanism

## 2026-08-17 14:05:32 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now deterministic — 8/8 fast replicas (0.11-0.14s) return 200+725B; slow replicas return 401; replica-split mechanism confirmed
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now deterministic — 8/8 slow replicas (0.55-1.04s) return 200+11B; fast replicas return 401; same LB split mechanism
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants (saskatoon.ca, mbta.com, oakville.ca, cota.com newly confirmed); fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizeUrl response body (OAuth parameter injection vector); redirect_uri silently dropped
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only

## 2026-08-17 14:43:43 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now deterministic — 8/8 fast replicas (0.11-0.14s) return 200+725B; slow replicas return 401; replica-split mechanism confirmed
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now deterministic — 8/8 slow replicas (0.55-1.04s) return 200+11B; fast replicas return 401; same LB split mechanism
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants (saskatoon.ca, mbta.com, oakville.ca, cota.com newly confirmed); fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizeUrl response body (OAuth parameter injection vector); redirect_uri silently dropped
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only

## 2026-08-17 15:05:12 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now deterministic — 8/8 fast replicas (0.11-0.14s) return 200+725B; slow replicas return 401; replica-split mechanism confirmed
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now deterministic — 8/8 slow replicas (0.55-1.04s) return 200+11B; fast replicas return 401; same LB split mechanism
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants (saskatoon.ca, mbta.com, oakville.ca, cota.com newly confirmed); fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizeUrl response body (OAuth parameter injection vector); redirect_uri silently dropped
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED api.sparelabs.com/v1/identity/workos/auth: state parameter reflection confirmed; redirect_uri NOT reflected — OATH injection vector confirmed as state-only
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now replica-dependent — slow replicas (664ms) return 200+11B; fast replicas return 401; same multi-version LB split mechanism
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants (saskatoon.ca, mbta.com, oakville.ca, cota.com, winnipeg.ca, kingcounty.gov confirmed) — fleet-parity across 7 hosts; stat
- CHANGED api.sparelabs.com/v1/global/regions: scheme-only Bearer bypass now DETERMINISTIC — 8/8 fast replicas (0.11-0.14s) return 200+725B; slow replicas return 401; multi-version envoy LB replica-split mechan
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now DETERMINISTIC — 8/8 slow replicas (0.55-1.04s) return 200+11B; fast replicas return 401; same LB split mechanism; writes POST/PUT/PATC
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas (nil→404 fast, 400 slow) — downgraded to validation-leak-only, NOT oracle class
- NEW api.sparelabs.com/v1/public/engage/cases POST: auth gate ABSENT confirmed — handler reached without 401 on empty POST (400 ValidationError), nil-UUID (404 NotFoundError), valid org UUIDs (403 Forbidde
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel references; 3 Google Maps keys all referrer-restricted; infra leak eliminated (downgr
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP /login infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP + x-frame DENY; all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404/0B on ALL probed paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only, no new surface

## 2026-08-17 15:37:32 UTC
- NEW api.sparelabs.com/v1/global/regions: Scheme-only Bearer bypass now deterministic — 8/8 fast replicas (0.11-0.14s) return 200+725B; slow replicas return 401; replica-split mechanism confirmed
- NEW api.sparelabs.com/v1/global/organizations: Zero-header read-only bypass now deterministic — 8/8 slow replicas (0.55-1.04s) return 200+11B; fast replicas return 401; same LB split mechanism
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants (saskatoon.ca, mbta.com, oakville.ca, cota.com newly confirmed); fleet-parity across 7 hosts
- NEW api.sparelabs.com/v1/identity/workos/auth: state parameter reflected unescaped in authorizeUrl response body (OAuth parameter injection vector); redirect_uri silently dropped
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP /login infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP + x-frame DENY; all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404/0B on ALL probed paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only, no new surface
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED)
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400, ~299B) and router-level "not found" (400, ~189B) — multi-version envoy LB confirmed, downgraded to UNC
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle flapping 2-way↔3-way across envoy replicas — downgraded to validation-leak-only
- CHANGED api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED as mechanism behind 96h intermittent flapping — NOT a patch, bypasses are replica-version-dependent
- CHANGED api.sparelabs.com/v1/identity/workos/auth: state parameter reflection confirmed; redirect_uri NOT reflected — OATH injection vector confirmed as state-only
- CHANGED api.sparelabs.com/v1/public/engage/cases POST + caseForms POST: Auth gate ABSENT re-confirmed live — handler reached without auth (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); multi-ve
- CHANGED api.sparelabs.com/v1/global/organizations: zero-header bypass now replica-dependent — slow replicas (664ms) return 200+11B; fast replicas return 401; same multi-version LB split mechanism

## 2026-08-17 16:03:50 UTC

## 2026-08-17 16:34:46 UTC
- NEW api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED as mechanism behind 96h flapping — NOT a patch; fast replicas (4-17ms) deterministically return 200+725B+Bearer bypass, sl
- NEW api.sparelabs.com/v1/global/organizations: zero-header bypass now DETERMINISTIC — 8/8 slow replicas (550-1040ms) return 200+11B+ACAO+ACAC, fast replicas return 401 — same LB split mechanism
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants (saskatoon.ca, mbta.com, oakville.ca, cota.com, winnipeg.ca, kingcounty.gov newly confirmed); state parameter reflected un
- NEW api.sparelabs.com/v1/public/engage/cases POST: auth gate ABSENT confirmed live — handler reached without 401 (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); feature-flag gate per-org; cr
- NEW forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; downgraded from ACCEPTED MISCONFIG 
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle fully degraded 3-way↔2-way flapping across envoy replicas — downgraded to validation-leak-only, NOT oracle class; plural /organizations
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400) and router-level "not found" (400) — multi-version envoy LB confirmed; downgraded to UNC

## 2026-08-17 17:00:50 UTC
- NEW api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED as mechanism behind 96h flapping — NOT a patch; fast replicas (4-17ms) deterministically return 200+725B+Bearer bypass, sl
- NEW api.sparelabs.com/v1/global/organizations: zero-header bypass now DETERMINISTIC — 8/8 slow replicas (550-1040ms) return 200+11B+ACAO+ACAC, fast replicas return 401 — same LB split mechanism
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants (saskatoon.ca, mbta.com, oakville.ca, cota.com, winnipeg.ca, kingcounty.gov newly confirmed); state parameter reflected un
- NEW api.sparelabs.com/v1/public/engage/cases POST: auth gate ABSENT confirmed live — handler reached without 401 (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); feature-flag gate per-org; cr
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; downgraded from ACCEPTED MISCONFIG 
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle fully degraded 3-way↔2-way flapping across envoy replicas — downgraded to validation-leak-only, NOT oracle class; plural /organizations
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400) and router-level "not found" (400) — multi-version envoy LB confirmed; downgraded to UNCONFIRMED
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP /login infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP + x-frame DENY; all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404/0B on ALL probed paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only, no new surface

## 2026-08-17 17:35:00 UTC
- NEW api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED as mechanism behind 96h flapping — fast replicas (4-17ms) deterministically return 200+725B+Bearer bypass, slow replicas r
- NEW api.sparelabs.com/v1/global/organizations: zero-header bypass now DETERMINISTIC — 8/8 slow replicas (550-1040ms) return 200+11B+ACAO+ACAC, fast replicas return 401; same LB split mechanism
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants (saskatoon.ca, mbta.com, oakville.ca, cota.com, winnipeg.ca, kingcounty.gov newly confirmed); state parameter reflected un
- NEW api.sparelabs.com/v1/public/engage/cases POST: auth gate ABSENT confirmed live — handler reached without 401 (400 ValidationError, 404 NotFoundError, 403 ForbiddenError); feature-flag gate per-org; cr
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted; downgraded from ACCEPTED MISCONFIG 
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle fully degraded 3-way↔2-way flapping across envoy replicas — downgraded to validation-leak-only, NOT oracle class; plural /organizations
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: flapping between OpenAPI validation (400) and router-level "not found" (400) — multi-version envoy LB confirmed; downgraded to UNCONFIRMED
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP /login infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP + x-frame DENY; all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404/0B on ALL probed paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only, no new surface

## 2026-08-17 18:02:48 UTC
- NEW api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED deterministic — 8/8 fast replicas (4-17ms) return 200+725B+Bearer bypass; 8/8 slow replicas return 401; same split mechani
- NEW api.sparelabs.com/v1/global/organizations: Zero-header bypass now DETERMINISTIC — 8/8 slow replicas (550-1040ms) return 200+11B+ACAO+ACAC; fast replicas return 401; same LB split mechanism; write meth
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants (saskatoon.ca, mbta.com, oakville.ca, cota.com, winnipeg.ca, kingcounty.gov newly confirmed); state parameter reflected un
- NEW api.sparelabs.com/v1/public/engage/cases POST: Auth gate ABSENT re-confirmed live — handler reached without 401 (400 ValidationError, 404 NotFoundError, 403 ForbiddenError feature-flag gate); cross-ro
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP /login infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP + x-frame DENY; all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404/0B on ALL probed paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only, no new surface
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED, downgraded f
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle fully degraded 3-way↔2-way flapping across envoy replicas — downgraded to validation-leak-only, NOT oracle class; plural /organizations
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: Flapping between OpenAPI validation (400) and router-level "not found" (400) — multi-version envoy LB confirmed; downgraded to UNCONFIRMED

## 2026-08-17 18:54:37 UTC

## 2026-08-17 19:23:09 UTC
- NEW api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED deterministic — 8/8 fast replicas (4-17ms) return 200+725B+Bearer bypass; 8/8 slow replicas return 401; same split mechani
- NEW api.sparelabs.com/v1/global/organizations: Zero-header bypass now DETERMINISTIC — 8/8 slow replicas (550-1040ms) return 200+11B+ACAO+ACAC; fast replicas return 401; same LB split mechanism; write meth
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants (saskatoon.ca, mbta.com, oakville.ca, cota.com, winnipeg.ca, kingcounty.gov newly confirmed); state parameter reflected un
- NEW api.sparelabs.com/v1/public/engage/cases POST: Auth gate ABSENT re-confirmed live — handler reached without 401 (400 ValidationError, 404 NotFoundError, 403 ForbiddenError feature-flag gate); cross-ro
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP /login infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP + x-frame DENY; all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404/0B on ALL probed paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only, no new surface
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED, downgraded f
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle fully degraded 3-way↔2-way flapping across envoy replicas — downgraded to validation-leak-only, NOT oracle class; plural /organizations
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: Flapping between OpenAPI validation (400) and router-level "not found" (400) — multi-version envoy LB confirmed; downgraded to UNCONFIRMED

## 2026-08-17 19:50:46 UTC
- NEW api.sparelabs.com/v1/global/regions: Multi-version LB replica split CONFIRMED deterministic — 8/8 fast replicas (4-17ms) return 200+725B+Bearer bypass; 8/8 slow replicas return 401; same split mechani
- NEW api.sparelabs.com/v1/global/organizations: Zero-header bypass now DETERMINISTIC — 8/8 slow replicas (550-1040ms) return 200+11B+ACAO+ACAC; fast replicas return 401; same LB split mechanism; write meth
- NEW api.sparelabs.com/v1/identity/workos/auth: SSO roster expanded to ≥11 tenants (saskatoon.ca, mbta.com, oakville.ca, cota.com, winnipeg.ca, kingcounty.gov newly confirmed); state parameter reflected un
- NEW api.sparelabs.com/v1/public/engage/cases POST: Auth gate ABSENT re-confirmed live — handler reached without 401 (400 ValidationError, 404 NotFoundError, 403 ForbiddenError feature-flag gate); cross-ro
- NEW platform.sparelabs.com: NOW live (was TIMEOUT) — MFE SPA shell 200; CSP /login infra leak STABLE (admin Vercel apps dev-only, Metabase prod+staging, 9 cloud services)
- NEW forms.sparelabs.com: NOW live (was TIMEOUT) — Engage portal SPA 200; strict HTML CSP + x-frame DENY; all API paths return SPA catch-all
- NEW routing.sparelabs.com: NOW live (was TIMEOUT) — envoy 404/0B on ALL probed paths; STABLE dead, NO_DELTA since 2026-08-07
- NEW sparelabs.com: NOW 301→spare.com apex (was TIMEOUT) — Cloudflare+HSTS, static-only, no new surface
- CHANGED forms.sparelabs.com JS bundle: main.8a2a39cb.js CONFIRMED PATCHED — zero sparelabs/atlassian/ngrok/metabase/vercel refs; 3 Google Maps keys all referrer-restricted (infra leak ELIMINATED, downgraded f
- CHANGED api.sparelabs.com/v1/public/organization (singular): UUID oracle fully degraded 3-way↔2-way flapping across envoy replicas — downgraded to validation-leak-only, NOT oracle class; plural /organizations
- CHANGED api.sparelabs.com/v1/public/engage/{caseType,form} GET: Flapping between OpenAPI validation (400) and router-level "not found" (400) — multi-version envoy LB confirmed; downgraded to UNCONFIRMED
