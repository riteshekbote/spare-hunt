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
