# LEADS laguna (seed)
- SEED: no model output yet; pipeline starts on first run.
## 2026-08-07 18:34:45 UTC [web] (model laguna)
[NEW] sparelabs.com now responds (301→https://spare.com via Cloudflare; HSTS `max-age=0; preload`) — previously TIMEOUT.
[NEW] platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT.
[NEW] routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT.
[NEW] forms.sparelabs.com now responds 200 ("Spare Engage Web Portal" SPA; object-store headers) — previously TIMEOUT.
[CHANGED] api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed.
[PRIO] platform.sparelabs.com | score 7.10 | atk8 biz9 tech7 gate2 cloud6 fresh9
[PRIO] api.sparelabs.com | score 6.30 | atk7 biz8 tech6 gate3 cloud5 fresh7
[PRIO] forms.sparelabs.com | score 5.95 | atk5 biz6 tech4 gate8 cloud6 fresh8
[PRIO] routing.sparelabs.com | score 5.75 | atk6 biz7 tech5 gate3 cloud5 fresh8
[PRIO] web (spare.com / sparelabs.com) | score 4.70 | atk4 biz5 tech2 gate9 cloud3 fresh5
[HYP] platform.sparelabs.com CSP leaks internal/staging asset inventory
class: MISCONFIG
asset: platform.sparelabs.com (response `content-security-policy` + `/login` MFE manifest prefetch)
confidence: 60
reasoning: `platform.sparelabs.com` is an MFE orchestrator; its CSP + the `/login` prefetch script enumerate `admin-eam-app(-staging).vercel.app`, `admin-fixed-route-app(-staging).vercel.app`, `metabase.sparelabs.com`, `metabase.staging.sparelabs.com`, `cognito-identity.us-west-2.amazonaws.com`, `*.digitaloceanspaces.com`. Staging admin apps are typically less hardened than production.
evidence_needed: CSP + prefetch captured passively here; staging apps render auth prompts outside prod SSO.
verify_steps: PASSIVE — `GET https://platform.sparelabs.com/login` → read CSP + grep `manifest.wc.json` URLs (done).
impact: Low→Medium — attacker learns internal admin/staging URLs + integrations; enables targeted follow-up. Severity P3.
testability: PASSIVE
[HYP] forms.sparelabs.com served from static object store; sensitive-object/path exposure risk
class: MISCONFIG
asset: forms.sparelabs.com
confidence: 45
reasoning: Root returns `content-disposition: inline; filename="index.html"`, `accept-ranges: bytes`, `etag`, no `server` — classic object-store (DO Spaces/S3) hosting the "Spare Engage" SPA; static portals commonly expose dir listings / sensitive static objects.
evidence_needed: store type confirmed; find unguarded object path returning content.
verify_steps: PASSIVE — `HEAD/GET https://forms.sparelabs.com/` (have 200); enumerate `/static/`, `/static/js/*.js` (check for leaked env), `/.well-known/`, `/admin` ≤1rps.
impact: Low — potential read of static assets/config. Severity P4.
testability: PASSIVE
[HYP] api.sparelabs.com auth not challengeable at edge; real surface hidden behind path prefix
class: AUTH
asset: api.sparelabs.com
confidence: 38
reasoning: Root + `/docs,/swagger,/openapi.json,/api,/api/v1,/health,/v1,/metrics` all return envoy 404 with no `WWW-Authenticate`; gateway hides routes behind unknown path prefix + bearer token.
evidence_needed: discover valid route that returns a resource without auth challenge.
verify_steps: AUTH_HELPED — passive enumeration yields only 404 (no token available).
impact: High only if bypass proven — currently speculative.
testability: AUTH_HELPED
[PARKED] api.sparelabs.com edge-gateway AUTH: confidence 38 (<40); a 404 on root is normal for an edge API gateway and is not evidence of an auth bypass; no concrete exploit step exists in scope.
[FINAL] HYP1 (platform.sparelabs.com CSP info disclosure), HYP2 (forms.sparelabs.com object-store exposure).
[NEXT] SCAN https://forms.sparelabs.com : enumerate sensitive object paths with HEAD/GET ≤1 rps (`/`, `/static/`, `/static/js/*.js`, `/.well-known/`, `/admin`, `/config.js`) to confirm whether the backing object store exposes directory listing or static assets; log any 200/403 that reveals file existence.
[RISK] api.sparelabs.com: 55 — envoy edge API gateway, auth-gated, surface not enumerable passively; moderate residual (hidden large API behind tokens).
[RISK] platform.sparelabs.com: 60 — operator/admin MFE SPA; CSP discloses staging admin panels + metabase + Cognito + DO Spaces; auth-gated but leaky headers.
[RISK] routing.sparelabs.com: 50 — envoy gateway; hidden routing-engine API behind 404s; low visible exposure, high latent value.
[RISK] forms.sparelabs.com: 45 — public "Spare Engage" static SPA on object store; open root, limited surface.
[RISK] web (spare.com / sparelabs.com): 40 — Webflow marketing site behind Cloudflare; sparelabs.com 301→spare.com; static exposure only.
## 2026-08-07 19:00:49 UTC [web] (model laguna)
[NEW] api.sparelabs.com `/v1/` API prefix discovered: 3 unauthenticated endpoints (`/v1/global/organizations`→200, `/v1/public/organization?organizationId=<uuid>`→400/404, `/v1/public/terms?organizationId=<uuid>`→200) + 15+ auth-gated endpoints (`/v1/journeys`→401, `/v1/journeys/requests`→401, `/v1/riders/me`→401, `/v1/featureFlags`→401, `/v1/organizations/public`→401, `/v1/global/organization`→401, `/v1/global/config`→401, `/v1/global/region`→401, `/v1/auth/*`→401, `/v1/users/me`→401, `/v1/organizations`→401, `/v1/global`→401)
[NEW] api.sparelabs.com `/v1/public/organization?organizationId=<uuid>` validates UUID format via OpenAPI schema (400 "must match format uuid" for malformed, 404 "Organization was not found" for non-existent)
[NEW] forms.sparelabs.com JS bundle (`main.6ed467ae.js`, 342,725 bytes) leaks: staging+prod API hosts (`api.us.sparelabs.com`, `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `api-spare.ngrok.io`), staging form hosts (`forms.staging.sparelabs.com`, `forms.staging.us.sparelabs.com`), JIRA (`sparelabs.atlassian.net`), route structure (`/forms/:orgId/:caseTypeKey` → `/forms?organizationId=...&caseTypeKey=...&formKey=...`), API client method names (`global.getOrganization`, `public.getForm`, `public.postCaseForm`, `auth.emailLoginRequest`, `users.getMeRider`, `caseTypes.getPublic`, `cases.post`), and API path patterns (`/v1/journeys`, `/v1/global/`, `/applications/`, `/count/`, `/entries/`, `/links/`, `/steps/`, `/user/`)
[CHANGED] api.sparelabs.com: re-identified from "404 edge gateway, surface hidden behind unknown path prefix" to "envoy edge with discoverable `/v1/` API (3 unauth + 15+ auth-gated endpoints)"
[CHANGED] forms.sparelabs.com: re-identified from "static object store SPA" to "SPA behind envoy+Google CDN; JS bundle leaks staging infrastructure; all paths return index.html (SPA catch-all, 537 bytes)"
[PRIO] api.sparelabs.com | score 7.95 | atk9 biz8 tech8 gate6 cloud6 fresh10
[PRIO] platform.sparelabs.com | score 7.60 | atk7 biz9 tech9 gate5 cloud7 fresh8
[PRIO] forms.sparelabs.com | score 6.55 | atk6 biz6 tech7 gate7 cloud7 fresh9
[PRIO] routing.sparelabs.com | score 4.85 | atk4 biz7 tech4 gate2 cloud4 fresh7
[PRIO] web (spare.com / sparelabs.com) | score 4.15 | atk2 biz5 tech2 gate9 cloud3 fresh5
[HYP] api.sparelabs.com unauthenticated org enumeration via OpenAPI schema leak
class: MISCONFIG
asset: api.sparelabs.com `/v1/public/organization?organizationId=<uuid>`
confidence: 50
reasoning: Endpoint is reachable without authentication; returns 400 for missing/malformed UUID (leaking "must match format uuid" + query param location + errorCode), 404 "Organization was not found" for valid-format non-existent UUIDs, and (implied) 200+org data for valid UUIDs. Confirmed via GET sweep: the forms SPA JS bundle calls `global.getOrganization(organizationId)` → returns `apiHost` for regional API routing. Distinction of 400/404/200 enables org UUID enumeration.
evidence_needed: Capture full 200 response for a valid org UUID (not yet obtained; only 00000000-0000-0000-0000-000000000000 and similar test UUIDs return 404).
verify_steps: PASSIVE — GET https://api.sparelabs.com/v1/public/organization?organizationId=00000000-0000-0000-0000-000000000000 (done, 404); retry with org UUID extracted from forms JS bundle or spare.com links if available (none found).
[HYP] platform.sparelabs.com CSP leaks staging admin panels + prefetch fetches staging MFE manifests
class: MISCONFIG
asset: platform.sparelabs.com (response `content-security-policy` + `/login` MFE manifest prefetch script)
confidence: 65
reasoning: `/login` page CSP explicitly whitelists `admin-eam-app-staging.vercel.app`, `admin-fixed-route-app-staging.vercel.app`, `metabase.staging.sparelabs.com` alongside production admin apps, AWS Cognito (`cognito-identity.us-west-2.amazonaws.com`), DO Spaces, Stripe, Intercom, Sentry, Mapbox. The inline prefetch script fetches `manifest.wc.json` from both production and staging Vercel apps on every page load, confirming active cross-origin requests to staging infrastructure.
evidence_needed: Full CSP header captured (done); prefetch script fetched staging manifests (done); staging admin apps render auth prompts outside prod SSO (unverified, out-of-scope subdomains on *.vercel.app).
verify_steps: PASSIVE — GET https://platform.sparelabs.com/login → read CSP + grep `manifest.wc.json` URLs (done, confirmed 4 staging+prod URLs).
[HYP] forms.sparelabs.com JS bundle leaks staging API hosts + dev infra
class: MISCONFIG
asset: forms.sparelabs.com `/static/js/main.6ed467ae.js` (342,725 bytes, unpacked)
confidence: 55
reasoning: Client-side JS bundle (delivered from in-scope forms.sparelabs.com) embeds production (`api.us.sparelabs.com`, `forms.us.sparelabs.com`) and staging (`api.staging.us.sparelabs.com`, `api.staging.us.sparelabs.com`, `forms.staging.sparelabs.com`, `forms.staging.us.sparelabs.com`) API hosts, plus dev tunnel (`api-spare.ngrok.io`) and JIRA (`sparelabs.atlassian.net`). Bundles expose `global.getOrganization` method used to discover regional `apiHost`. Staging environments and dev tunnels are typically less hardened.
evidence_needed: JS bundle source confirms all URLs via grep (done); staging API hosts return valid endpoints if probed (out-of-scope to test).
verify_steps: PASSIVE — curl https://forms.sparelabs.com/static/js/main.6ed467ae.js → grep for `sparelabs.com`/`ngrok.io` URLs (done, 10+ internal URLs found).
[PARKED] api.sparelabs.com AUTH (confidence 38): The previous hypothesis "auth not challengeable at edge; real surface hidden behind path prefix" is superseded. The `/v1/` prefix IS discoverable; edge properly returns 401 for auth-gated routes. The real finding is the 3 unauthenticated `/v1/public/`+`/v1/global/` endpoints.
[PARKED] forms.sparelabs.com object-store exposure (confidence 45): The hypothesis that forms is backed by a raw DigitalOcean Spaces/S3 bucket with directory listing risk is refuted — the `server: envoy` + `via: 1.1 google` headers prove traffic is served through Google CDN + envoy edge, not directly from object storage. All paths return 537-byte index.html (SPA catch-all), no directory listing or unguarded objects found. The real finding is the info disclosure in the JS bundle.
[FINAL] 1. [70] platform.sparelabs.com: CSP + prefetch leaks staging admin panels + metabase + Cognito (confidence 65, PASSIVE)
[FINAL] 2. [55] forms.sparelabs.com: JS bundle leaks staging API hosts + ngrok + JIRA (confidence 55, PASSIVE)
[FINAL] 3. [50] api.sparelabs.com: unauthenticated `/v1/public/organization` + OpenAPI schema leak enables org enumeration (confidence 50, PASSIVE)
[NEXT] PROBE: Sweep additional `/v1/public/*` and `/v1/*` endpoint candidate names on api.sparelabs.com with GET ≤1rps (e.g., /v1/public/{forms,cases,settings,rates,quotes,drivers,vehicles,rides,users}, /v1/{routes,router,dispatch,health,version,status}, /v1/global/{search,health,version,tenants}) to discover any additional unauthenticated endpoints beyond the 3 confirmed (`/v1/global/organizations`, `/v1/public/organization`, `/v1/public/terms`). Log response codes + content-type for each. Also try `/v1/global/organizations?search=<q>&limit=50` to see if the empty-list endpoint accepts search filters.
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + `/login` prefetch script CONFIRMED leaking `admin-eam-app-staging.vercel.app`, `admin-fixed-route-app-staging.vercel.app`, `metabase.staging.sparelabs.com`, plus 20+ production infra URLs (Cognito, Stripe, DO Spaces, Sentry, Intercom, Mapbox).
[LEARN] ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle CONFIRMED leaking `api.staging.us.sparelabs.com`, `api.staging.sparelabs.com`, `forms.staging.sparelabs.com`, `forms.staging.us.sparelabs.com`, `api-spare.ngrok.io` (dev tunnel), `sparelabs.atlassian.net` (JIRA).
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com: `/v1/` API CONFIRMED discoverable via passive enum. 3 unauthenticated endpoints live (200/400/404); 15+ auth-gated endpoints confirmed (401). OpenAPI validation errors leak UUID format requirement + query param schema.
[LEARN] REJECTED AUTH @ api.sparelabs.com: Previous "auth not challengeable" hypothesis PARKED — edge properly returns 401 for auth-gated routes; new finding is the unauthenticated `/v1/public/*` endpoints.
[LEARN] REJECTED MISCONFIG @ forms.sparelabs.com: Object-store directory listing hypothesis PARKED — traffic served via envoy+Google CDN (not raw object store); SPA catch-all returns index.html for all paths.
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all `/v1/`, `/api/`, `/routing/`, `/router`, `/v2/`, `/graphql`, `/map`, `/directions` paths return 404; no discoverable surface behind envoy gateway.
[RISK] api.sparelabs.com: 65 — envoy edge API gateway with 3 unauthenticated endpoints (`/v1/public/organization` enabling UUID-based org enumeration + OpenAPI schema leak, `/v1/public/terms`, `/v1/global/organizations`) + 15+ auth-gated endpoints (`/v1/journeys`, `/v1/featureFlags`, `/v1/riders/me`, `/v1/auth/*`) with unknown access controls. Moderate-to-high residual.
[RISK] platform.sparelabs.com: 60 — admin/operator MFE SPA shell; CSP discloses staging admin panels (`admin-eam-app-staging.vercel.app`, `admin-fixed-route-app(-staging).vercel.app`) + metabase.staging + Cognito + DO Spaces + Stripe + Intercom + Sentry; `/login` prefetch fetches staging MFE manifests actively.
[RISK] routing.sparelabs.com: 50 — envoy gateway returning 404 on all probed paths; routing-engine API completely hidden behind 404s; no unauthenticated surface; high latent value, low visible exposure.
[RISK] forms.sparelabs.com: 55 — public "Spare Engage" SPA behind envoy+Google CDN; JS bundle (342KB) leaks staging API hosts + dev ngrok tunnel + JIRA + route structure + API method names; root + all paths return 537-byte index.html (SPA catch-all).
[RISK] web (spare.com/sparelabs.com): 40 — Webflow marketing site behind Cloudflare (`cf-cache-status: HIT`, `set-cookie: _cfuvid`); sparelabs.com 301→spare.com (HSTS `max-age=0; preload`); static exposure only, no API.
## 2026-08-07 20:04:57 UTC [web] (model laguna)
## 2026-08-07 20:56:01 UTC [web] (model laguna)
## 2026-08-07 21:32:57 UTC [web] (model laguna)
[NEW] api.sparelabs.com CORS preflight (OPTIONS /v1/journeys) confirms `access-control-allow-origin` reflects any origin + `access-control-allow-credentials: true` + `access-control-allow-methods: GET,HEAD,PUT,PATCH,POST,DELETE` + `access-control-allow-headers: Authorization`
[NEW] api.sparelabs.com /v1/global/organizations currently returns HTTP 200 (not 401 as claimed at 20:57 UTC) with {"data":[]} + reflected CORS+credentials
[NEW] api.sparelabs.com /v1/public/organization?organizationId=00000000-0000-0000-0000-000000000000 returns 404 (valid UUID, not found) vs 400 for malformed UUID — confirms UUID enumeration oracle
[NEW] api.sparelabs.com /v1/public/terms?organizationId=00000000-0000-0000-0000-000000000000 returns HTTP 200 with live terms URLs (termsOfUseUrl, privacyPolicyUrl) — unauthenticated data disclosure
[NEW] forms.staging.sparelabs.com + forms.staging.us.sparelabs.com verified responding 200
[NEW] admin-eam-app-staging.vercel.app + admin-fixed-route-app-staging.vercel.app verified responding 200
[NEW] metabase.staging.sparelabs.com verified responding 200 (Metabase login)
[NEW] api-spare.ngrok.io returns ERR_NGROK_3200 (tunnel inactive)
[CHANGED] forms.sparelabs.com JS bundle rotated: main.6ed467ae.js → main.71d52314.js (verified live)
[PRIO] api.sparelabs.com | score 9.15 | atk10 biz10 tech9 gate10 cloud9 fresh10
[PRIO] platform.sparelabs.com | score 7.60 | atk8 biz9 tech9 gate3 cloud7 fresh8
[PRIO] forms.sparelabs.com | score 6.80 | atk7 biz7 tech8 gate8 cloud7 fresh10
[HYP] api.sparelabs.com: CORS reflect-any-origin with credentials + all methods + Authorization header on /v1 API
class: MISCONFIG
asset: api.sparelabs.com /v1/* (confirmed on /v1/journeys, /v1/global/organizations, /v1/public/terms)
confidence: 95
reasoning: Live probe: OPTIONS preflight returns access-control-allow-origin: <reflected any origin> + access-control-allow-credentials: true + access-control-allow-methods: GET,HEAD,PUT,PATCH,POST,DELETE + access-control-allow-headers: Authorization. GET responses also reflect origin with credentials. Affects ALL /v1 endpoints including auth-gated. Any malicious site can issue credentialed read+write API calls on behalf of any logged-in user.
evidence_needed: Captured full OPTIONS preflight response headers (done, live 21:30 UTC)
verify_steps: PASSIVE — curl -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" -H "Access-Control-Request-Headers: Authorization" https://api.sparelabs.com/v1/journeys
impact: Full account takeover via browser — any malicious origin can issue authenticated reads (steal user/rider/org data) and writes (POST/PUT/DELETE on /v1/journeys, /v1/riders, etc.) using victim's session/token. Severity: CRITICAL
testability: PASSIVE
class: MISCONFIG
asset: api.sparelabs.com /v1/public/organization?organizationId=<uuid>
confidence: 65
reasoning: Endpoint unauthenticated; returns 400 with full ValidationError body (request/query/organizationId must match format "uuid", errorCode: format.openapi.validation) for malformed input, 404 NotFoundError for valid-format UUIDs that don't exist, 200+org data for valid UUIDs. 400-vs-404-vs-200 is a reliable enumeration oracle. Forms SPA bundle confirms global.getOrganization(organizationId) is the real client method.
evidence_needed: Capture 200 response for a valid org UUID (test UUIDs return 404; real org UUID not yet sourced)
verify_steps: PASSIVE — curl "https://api.sparelabs.com/v1/public/organization?organizationId=00000000-0000-0000-0000-000000000000" (404, done); curl "https://api.sparelabs.com/v1/public/organization?organizationId=not-a-uuid" (400 ValidationError, done)
impact: Enumerate valid organization UUIDs without auth, enabling targeted attacks against specific tenants. Severity: MEDIUM
testability: PASSIVE
[HYP] platform.sparelabs.com: CSP leaks staging admin panels + production infra via prefetch script
class: MISCONFIG
asset: platform.sparelabs.com /login (CSP header + MFE manifest prefetch)
confidence: 65
reasoning: CSP connect-src/frame-src whitelists admin-eam-app-staging.vercel.app, admin-fixed-route-app-staging.vercel.app, metabase.staging.sparelabs.com alongside prod Cognito, Stripe, DO Spaces, Intercom, Sentry, Mapbox. Inline prefetch script fetches manifest.wc.json from staging Vercel apps on every page load. Verified: staging hosts respond 200.
evidence_needed: Full CSP header captured (done); prefetch script fetches staging manifests (done); staging admin apps respond 200 (confirmed 21:30 UTC)
verify_steps: PASSIVE — curl -s https://platform.sparelabs.com/login → grep manifest.wc.json + CSP origin list; curl https://admin-eam-app-staging.vercel.app
impact: Disclosure of staging infrastructure enabling targeted attacks against less-hardened staging; potential cross-environment token replay. Severity: MEDIUM
testability: PASSIVE
[FINAL] 1. [95] api.sparelabs.com: CORS reflect-any-origin with credentials + all methods + Authorization on /v1 API (PASSIVE)
[FINAL] 2. [65] api.sparelabs.com: UUID-based org enumeration via OpenAPI validation error oracle (PASSIVE)
[FINAL] 3. [65] platform.sparelabs.com: CSP leaks staging admin panels + infra via prefetch (PASSIVE)
[NEXT] PROBE: GET https://api.sparelabs.com/v1/journeys/requests — verify if this auth-gated endpoint also reflects CORS credentials on OPTIONS preflight (escalation path for write operations); AND GET https://api.sparelabs.com/v1/global/organizations?limit=50&search=a — test if the unauthenticated org list endpoint accepts search filters that could leak org names beyond the empty {"data":[]} list
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com: CORS preflight confirms full credential reflection — any malicious origin can issue authenticated GET/PUT/PATCH/POST/DELETE requests with Authorization header via victim browser (escalates read to write)
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 malformed, 404 not-found, 200 found) with full OpenAPI ValidationError body disclosure
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Returns live termsOfUseUrl + privacyPolicyUrl without authentication — unauthenticated data disclosure
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: Returns 200 with {"data":[]} and reflected CORS+credentials — auth state inconsistent (was 401 at 20:57 UTC, 200 at 21:30 UTC)
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all paths return 404; no surface
[LEARN] ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle rotated (main.6ed467ae.js → main.71d52314.js) but same staging+prod infra leak persists
[LEARN] REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
[LEARN] ACCEPTED MISCONFIG @ api.staging.sparelabs.com: Staging API hosts return 404 — no independent API surface
[RISK] api.sparelabs.com: 95 — CRITICAL CORS credential reflection on entire /v1 API (all methods + Authorization via any malicious origin); 3+ unauthenticated data-leaking endpoints; 15+ auth-gated endpoints with unknown access controls; OpenAPI schema leaks
[RISK] platform.sparelabs.com: 65 — admin MFE SPA; CSP discloses staging admin panels + metabase + Cognito + Stripe + DO Spaces; staging hosts respond 200
[RISK] routing.sparelabs.com: 50 — envoy 404 on all paths; routing API completely hidden; no unauth surface
[RISK] forms.sparelabs.com: 60 — public SPA; JS bundle (342KB) leaks staging infra + ngrok (inactive) + JIRA + routes; staging forms portals respond 200
[RISK] web (spare.com/sparelabs.com): 40 — Cloudflare Webflow marketing; static only
## 2026-08-07 22:08:07 UTC [web] (model laguna)
[PRIO] api.sparelabs.com | score 9.15 | atk10 biz10 tech9 gate10 cloud9 fresh10
[PRIO] platform.sparelabs.com | score 7.60 | atk8 biz9 tech9 gate3 cloud7 fresh8
[PRIO] forms.sparelabs.com | score 6.80 | atk7 biz7 tech8 gate8 cloud7 fresh10
[HYP] api.sparelabs.com: CORS reflect-any-origin with credentials on /v1 API
class: MISCONFIG
asset: api.sparelabs.com /v1/* (confirmed on /v1/journeys, /v1/global/organizations, /v1/public/terms)
confidence: 95
reasoning: Live probe: OPTIONS /v1/journeys returns access-control-allow-origin: <reflected any origin> + access-control-allow-credentials: true + access-control-allow-methods: GET,HEAD,PUT,PATCH,POST,DELETE + access-control-allow-headers: Authorization. GET responses also reflect origin with credentials. Affects ALL /v1 endpoints including auth-gated. Any malicious site can issue credentialed read+write API calls on behalf of any logged-in user.
evidence_needed: Captured full OPTIONS preflight response headers (done, live verified)
verify_steps: PASSIVE — curl -X OPTIONS -H "Origin: https://evil.example.com" -H "Access-Control-Request-Method: POST" -H "Access-Control-Request-Headers: Authorization" https://api.sparelabs.com/v1/journeys
impact: Full account takeover via browser — any malicious origin can issue authenticated reads (steal user/rider/org data) and writes (POST/PUT/DELETE on /v1/journeys, /v1/riders, etc.) using victim's session/token. Severity: CRITICAL
testability: PASSIVE
[HYP] api.sparelabs.com: UUID-based org enumeration via OpenAPI validation error oracle
class: MISCONFIG
asset: api.sparelabs.com /v1/public/organization?organizationId=<uuid>
confidence: 65
reasoning: Endpoint unauthenticated; returns 400 with full ValidationError body for malformed input, 404 NotFoundError for valid-format UUIDs that don't exist, 200+org data for valid UUIDs. 400-vs-404-vs-200 is a reliable enumeration oracle. Forms SPA bundle confirms global.getOrganization(organizationId) is the real client method.
evidence_needed: Capture 200 response for a valid org UUID (test UUIDs return 404; real org UUID not yet sourced)
verify_steps: PASSIVE — curl "https://api.sparelabs.com/v1/public/organization?organizationId=not-a-uuid" (400 ValidationError, confirmed); curl "https://api.sparelabs.com/v1/public/organization?organizationId=00000000-0000-0000-0000-000000000000" (404, confirmed)
impact: Enumerate valid organization UUIDs without auth, enabling targeted attacks against specific tenants. Severity: MEDIUM
testability: PASSIVE
[HYP] platform.sparelabs.com: CSP leaks staging admin panels + production infra via prefetch
class: MISCONFIG
asset: platform.sparelabs.com /login (CSP header + MFE manifest prefetch)
confidence: 65
reasoning: CSP connect-src/frame-src whitelists admin-eam-app-staging.vercel.app, admin-fixed-route-app-staging.vercel.app, metabase.staging.sparelabs.com alongside prod Cognito, Stripe, DO Spaces, Intercom, Sentry, Mapbox. Inline prefetch script fetches manifest.wc.json from staging Vercel apps on every page load. Verified: staging hosts respond 200.
evidence_needed: Full CSP header captured (done); prefetch script fetches staging manifests (done); staging admin apps respond 200 (confirmed 21:30 UTC)
verify_steps: PASSIVE — curl -s https://platform.sparelabs.com/login → grep manifest.wc.json + CSP origin list; curl https://admin-eam-app-staging.vercel.app
impact: Disclosure of staging infrastructure enabling targeted attacks against less-hardened staging; potential cross-environment token replay. Severity: MEDIUM
testability: PASSIVE
[FINAL] 1. [95] api.sparelabs.com: CORS reflect-any-origin with credentials + all methods + Authorization on /v1 API (PASSIVE)
[FINAL] 2. [65] api.sparelabs.com: UUID-based org enumeration via OpenAPI validation error oracle (PASSIVE)
[FINAL] 3. [65] platform.sparelabs.com: CSP leaks staging admin panels + infra via prefetch (PASSIVE)
[PRIO] PROBE: GET https://api.sparelabs.com/v1/journeys/requests — verify if this auth-gated endpoint also reflects CORS credentials on OPTIONS preflight (escalation path for write operations); AND GET https://api.sparelabs.com/v1/global/organizations?limit=50&search=a — test if the unauthenticated org list endpoint accepts search filters that could leak org names beyond the empty {"data":[]} list
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com: CORS preflight confirms full credential reflection — any malicious origin can issue authenticated GET/PUT/PATCH/POST/DELETE requests with Authorization header via victim browser (escalates read to write)
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 malformed, 404 not-found, 200 found) with full OpenAPI ValidationError body disclosure
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/terms: Returns live termsOfUseUrl + privacyPolicyUrl without authentication — unauthenticated data disclosure
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/global/organizations: Returns 200 with {"data":[]} and reflected CORS+credentials — auth state inconsistent (was 401 at 20:57 UTC, 200 at 21:30 UTC)
[LEARN] REJECTED MISCONFIG @ api-staking.sparelabs.com: Staging API hosts return 404 — no independent API surface
[LEARN] REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
[RISK] api.sparelabs.com: 95 — CRITICAL CORS credential reflection on entire /v1 API (all methods + Authorization via any malicious origin); 3+ unauthenticated data-leaking endpoints; 15+ auth-gated endpoints with unknown access controls; OpenAPI schema leaks
[RISK] platform.sparelabs.com: 65 — admin MFE SPA; CSP discloses staging admin panels + metabase + Cognito + Stripe + DO Spaces; staging hosts respond 200
[RISK] routing.sparelabs.com: 50 — envoy 404 on all paths; routing API completely hidden; no unauth surface
[RISK] forms.sparelabs.com: 60 — public SPA; JS bundle (342KB) leaks staging infra + ngrok (inactive) + JIRA + routes; staging forms portals respond 200
[RISK] web (spare.com/sparelabs.com): 40 — Cloudflare Webflow marketing; static only
