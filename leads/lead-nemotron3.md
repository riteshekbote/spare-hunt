# LEADS nemotron3 (seed)
- SEED: no model output yet; pipeline starts on first run.
## 2026-08-07 18:30:32 UTC [platform] (model nemotron3)
[PRIO] api.sparelabs.com, 7.8, attack=9 business=8 tech=8 gate=9 cloud=6 fresh=5
[PRIO] platform.sparelabs.com, 6.1, attack=7 business=9 tech=6 gate=3 cloud=7 fresh=5
[PRIO] routing.sparelabs.com, 5.8, attack=6 business=7 tech=7 gate=3 cloud=7 fresh=5
[PRIO] forms.sparelabs.com, 5.5, attack=6 business=6 tech=6 gate=3 cloud=6 fresh=5
[PRIO] sparelabs.com, 5.2, attack=5 business=6 tech=5 gate=3 cloud=6 fresh=5
[PRIO] spare.com, 4.8, attack=5 business=5 tech=4 gate=8 cloud=4 fresh=5
[PRIO] github.com/sparelabs (first-party repos), 3.9, attack=4 business=4 tech=5 gate=10 cloud=3 fresh=4
[HYP] api.sparelabs.com exposes undocumented API endpoints via missing OpenAPI spec
class: MISCONFIG
asset: api.sparelabs.com
confidence: 70
reasoning: Root returns 404 (not 401/403), suggesting API exists but lacks root documentation; common for internal APIs to have swagger at /docs, /swagger, /openapi.json, /api-docs
evidence_needed: 200 response on any docs/spec endpoint with endpoint enumeration
verify_steps: GET /docs, GET /swagger, GET /openapi.json, GET /api-docs, GET /v1/docs, GET /api/v1/docs (passive, ≤1 rps)
impact: Full API surface enumeration → potential IDOR, BOLA, data exposure; severity HIGH if auth bypass found
testability: PASSIVE
[HYP] platform.sparelabs.com CDN/WAF timeout masks origin SSRF via internal metadata endpoints
class: SSRF
asset: platform.sparelabs.com
confidence: 45
reasoning: Consistent timeouts on https suggest CDN/WAF gating; if origin is reachable via alternate paths (e.g., HTTP, internal headers), cloud metadata (169.254.169.254) may be accessible
evidence_needed: Successful response from origin (non-CDN) with server header indicating internal infrastructure
verify_steps: GET http://platform.sparelabs.com (HTTP), GET https with Host: localhost, GET with X-Forwarded-For: 127.0.0.1 (passive, ≤1 rps)
impact: Cloud credential theft, internal network mapping; severity CRITICAL
testability: PASSIVE
[HYP] routing.sparelabs.com processes user-supplied coordinates without validation enabling route manipulation
class: BUSLOGIC
asset: routing.sparelabs.com
confidence: 40
reasoning: Routing service likely accepts lat/lng or address params; if unvalidated, could manipulate dispatch logic, pricing, or driver assignment
evidence_needed: Identify API schema (POST /route, /optimize, /dispatch) and test parameter bounds/injection
verify_steps: GET / (when reachable), then POST /route with extreme coords, negative values, string injection (AUTH_HELPED if auth required)
impact: Fare manipulation, DoS via compute exhaustion, driver misrouting; severity MEDIUM-HIGH
testability: AUTH_HELPED
[PARKED] routing.sparelabs.com processes user-supplied coordinates without validation enabling route manipulation: confidence 40 < 40 threshold (borderline), no concrete verify_steps without auth, asset currently unreachable
[FINAL] 1. api.sparelabs.com exposes undocumented API endpoints via missing OpenAPI spec (confidence 70)
[FINAL] 2. platform.sparelabs.com CDN/WAF timeout masks origin SSRF via internal metadata endpoints (confidence 45)
[NEXT] PROBE: GET https://api.sparelabs.com/docs, GET https://api.sparelabs.com/swagger, GET https://api.sparelabs.com/openapi.json, GET https://api.sparelabs.com/api-docs (sequential, ≤1 rps)
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: asset unreachable, confidence below threshold, no auth context available
[RISK] api.sparelabs.com: 75 reason — 404 root with likely large undocumented API surface, no auth on docs endpoints common, high business value
[RISK] platform.sparelabs.com: 60 reason — Timeout suggests CDN/WAF; if origin reachable, SSRF risk to cloud metadata; high business value as core platform
[RISK] routing.sparelabs.com: 45 reason — Unreachable; routing logic high impact if exposed but no signal yet
[RISK] forms.sparelabs.com: 40 reason — Unreachable; forms often have file upload/XSS but zero visibility
[RISK] web (spare.com/sparelabs.com): 35 reason — spare.com returns 200 (marketing), sparelabs.com times out; low attack surface visible
## 2026-08-07 18:48:55 UTC [platform] (model nemotron3)
[NEW] sparelabs.com now responds (301→https://spare.com via Cloudflare; HSTS `max-age=0; preload`) — previously TIMEOUT  
[NEW] platform.sparelabs.com now responds 200 — Micro-frontend SPA shell; previously TIMEOUT  
[NEW] routing.sparelabs.com now responds 404 (`server: envoy`, `via: 1.1 google`) — previously TIMEOUT  
[NEW] forms.sparelabs.com now responds 200 ("Spare Engage Web Portal" SPA; object-store headers) — previously TIMEOUT  
[CHANGED] api.sparelabs.com positively re-identified as envoy edge gateway (`server: envoy`, `via: 1.1 google`); was only "404" in seed  
[NEW] api.sparelabs.com/v1/** live surface: `/v1/journeys` returns 401 InvalidTokenError (no auth header); `/v1/journeyNotifications/*` enumerated  
[NEW] platform.sparelabs.com MFE orchestration: CSP + `/login` prefetch enumerates staging admin apps (`admin-eam-app(-staging).vercel.app`, `admin-fixed-route-app(-staging).vercel.app`), `metabase.sparelabs.com`, `metabase.staging.sparelabs.com`, `cognito-identity.us-west-2.amazonaws.com`, `*.digitaloceanspaces.com`  
[NEW] forms.sparelabs.com served from object store (DO Spaces/S3): `content-disposition: inline`, `accept-ranges: bytes`, `etag`, no `server` header  
[PRIO] api.sparelabs.com, 7.15, attack=8 business=8 tech=7 gate=6 cloud=6 fresh=8  
[PRIO] platform.sparelabs.com, 6.85, attack=7 business=9 tech=7 gate=3 cloud=7 fresh=9  
[PRIO] forms.sparelabs.com, 5.95, attack=5 business=6 tech=4 gate=8 cloud=6 fresh=8  
[PRIO] routing.sparelabs.com, 5.75, attack=6 business=7 tech=5 gate=3 cloud=5 fresh=8  
[PRIO] sparelabs.com, 4.70, attack=4 business=5 tech=2 gate=9 cloud=3 fresh=5  
[PRIO] spare.com, 4.10, attack=3 business=4 tech=2 gate=9 cloud=2 fresh=4  
[HYP] api.sparelabs.com inconsistent auth enforcement across /v1/* endpoints  
class: MISCONFIG  
asset: api.sparelabs.com/v1/**  
confidence: 65  
reasoning: Live probe shows /v1/journeys returns 401 InvalidTokenError without auth header; single-header gate observed on one route only; large v1 surface may have inconsistent guard coverage  
evidence_needed: A /v1/* route returning 2xx without auth, or 500/stacktrace instead of 401  
verify_steps: PASSIVE. GET (no Authorization) /v1/config, /v1/health, /v1/journeyNotifications, /v1/nonexistent (control); classify 401/200/404/500; ≤1 rps, 4 requests  
impact: Unauthenticated read of operational/journey data if any route misses the guard; severity MEDIUM-HIGH  
testability: PASSIVE  
[HYP] platform.sparelabs.com CSP + MFE manifest leaks staging admin inventory  
class: MISCONFIG  
asset: platform.sparelabs.com (response `content-security-policy` + `/login` MFE manifest prefetch)  
confidence: 60  
reasoning: CSP + `/login` prefetch script enumerate `admin-eam-app(-staging).vercel.app`, `admin-fixed-route-app(-staging).vercel.app`, `metabase.sparelabs.com`, `metabase.staging.sparelabs.com`, `cognito-identity.us-west-2.amazonaws.com`, `*.digitaloceanspaces.com`; staging admin apps typically less hardened than production  
evidence_needed: Staging apps render auth prompts outside prod SSO; confirm CSP directives allow framing/script from staging origins  
verify_steps: PASSIVE — GET https://platform.sparelabs.com/login → read CSP + grep `manifest.wc.json` URLs; verify staging hosts respond  
impact: Attacker learns internal admin/staging URLs + integrations; enables targeted follow-up; severity P3  
testability: PASSIVE  
[HYP] forms.sparelabs.com object-store static hosting exposes directory listing or sensitive static objects  
class: MISCONFIG  
asset: forms.sparelabs.com  
confidence: 45  
reasoning: Root returns `content-disposition: inline; filename="index.html"`, `accept-ranges: bytes`, `etag`, no `server` — classic object-store (DO Spaces/S3) hosting the "Spare Engage" SPA; static portals commonly expose dir listings / sensitive static objects  
evidence_needed: Store type confirmed; find unguarded object path returning content (e.g., config.js, .env, directory index)  
verify_steps: PASSIVE — HEAD/GET https://forms.sparelabs.com/ (have 200); enumerate `/static/`, `/static/js/*.js` (check for leaked env), `/.well-known/`, `/admin`, `/config.js` ≤1rps  
impact: Potential read of static assets/config; severity P4  
testability: PASSIVE  
[PARKED] forms.sparelabs.com object-store static hosting exposes directory listing or sensitive static objects: confidence 45, but object-store directory listings are rare on DO Spaces/S3 by default; verify_steps may yield only 404/403 without actionable signal  
[FINAL] 1. api.sparelabs.com inconsistent auth enforcement across /v1/* endpoints (confidence 65)  
[FINAL] 2. platform.sparelabs.com CSP + MFE manifest leaks staging admin inventory (confidence 60)  
[NEXT] PROBE: GET https://api.sparelabs.com/v1/config, GET https://api.sparelabs.com/v1/health, GET https://api.sparelabs.com/v1/journeyNotifications, GET https://api.sparelabs.com/v1/nonexistent (sequential, ≤1 rps, no Authorization header)  
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1: live probe confirms /v1/journeys returns explicit 401 without auth, proving API surface exists behind edge gateway and auth enforcement is at least partially active  
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + MFE manifest enumeration of staging admin assets confirmed passively  
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: asset returns envoy 404, no routing API surface visible, confidence below threshold, no auth context available  
[RISK] api.sparelabs.com: 70 reason — envoy edge gateway hiding large /v1/ API surface; partial auth enforcement proven; inconsistent guards likely across many endpoints; high business value as core API  
[RISK] platform.sparelabs.com: 65 reason — MFE SPA shell with CSP leaking staging admin apps, Metabase, Cognito, DO Spaces; auth-gated but headers disclose inventory; high business value as operator console  
[RISK] routing.sparelabs.com: 50 reason — envoy gateway returning 404; hidden routing-engine API behind edge; low visible exposure, high latent value if routing logic exposed  
[RISK] forms.sparelabs.com: 45 reason — public "Spare Engage" static SPA on object store; open root, limited surface; IDOR risk only if shared /v1 API has cross-tenant flaws  
[RISK] web (spare.com/sparelabs.com): 40 reason — Webflow marketing site behind Cloudflare; sparelabs.com 301→spare.com; static exposure only
## 2026-08-07 19:13:42 UTC [platform] (model nemotron3)
[PRIO] api.sparelabs.com, 7.15, attack=8 business=8 tech=7 gate=6 cloud=6 fresh=8
[PRIO] platform.sparelabs.com, 6.85, attack=7 business=9 tech=7 gate=3 cloud=7 fresh=9
[PRIO] forms.sparelabs.com, 5.95, attack=5 business=6 tech=4 gate=8 cloud=6 fresh=8
[PRIO] routing.sparelabs.com, 5.75, attack=6 business=7 tech=5 gate=3 cloud=5 fresh=8
[PRIO] sparelabs.com, 4.70, attack=4 business=5 tech=2 gate=9 cloud=3 fresh=5
[PRIO] spare.com, 4.10, attack=3 business=4 tech=2 gate=9 cloud=2 fresh=4
[HYP] api.sparelabs.com inconsistent auth enforcement across /v1/* endpoints
class: MISCONFIG
asset: api.sparelabs.com/v1/**
confidence: 65
reasoning: Live probe shows /v1/journeys returns 401 InvalidTokenError without auth header; single-header gate observed on one route only; large v1 surface may have inconsistent guard coverage. 3 unauthenticated endpoints confirmed (/v1/global/organizations→200, /v1/public/organization→400/404, /v1/public/terms→400/404); 15+ auth-gated endpoints return 401.
evidence_needed: A /v1/* route returning 2xx without auth, or 500/stacktrace instead of 401
verify_steps: PASSIVE. GET (no Authorization) /v1/config, /v1/health, /v1/journeyNotifications, /v1/nonexistent (control); classify 401/200/404/500; ≤1 rps, 4 requests
impact: Unauthenticated read of operational/journey data if any route misses the guard; severity MEDIUM-HIGH
testability: PASSIVE
[HYP] platform.sparelabs.com CSP + MFE manifest leaks staging admin inventory
class: MISCONFIG
asset: platform.sparelabs.com (response content-security-policy + /login MFE manifest prefetch)
confidence: 60
reasoning: CSP + /login prefetch script enumerate admin-eam-app(-staging).vercel.app, admin-fixed-route-app(-staging).vercel.app, metabase.sparelabs.com, metabase.staging.sparelabs.com, cognito-identity.us-west-2.amazonaws.com, *.digitaloceanspaces.com; staging admin apps typically less hardened than production
evidence_needed: Staging apps render auth prompts outside prod SSO; confirm CSP directives allow framing/script from staging origins
verify_steps: PASSIVE — GET https://platform.sparelabs.com/login → read CSP + grep manifest.wc.json URLs; verify staging hosts respond
impact: Attacker learns internal admin/staging URLs + integrations; enables targeted follow-up; severity P3
testability: PASSIVE
[HYP] forms.sparelabs.com JS bundle leaks staging API endpoints and internal infrastructure
class: MISCONFIG
asset: forms.sparelabs.com (main.6ed467ae.js)
confidence: 55
reasoning: JS bundle (342,725 bytes) leaks staging+prod API hosts (api.us.sparelabs.com, api.staging.us.sparelabs.com, api.staging.sparelabs.com, api-spare.ngrok.io), forms.staging.*, sparelabs.atlassian.net (JIRA); SPA catch-all returns index.html for all paths behind envoy+Google CDN
evidence_needed: Confirm leaked endpoints respond and expose debug/info endpoints; verify ngrok tunnel is active
verify_steps: PASSIVE — HEAD/GET leaked staging hosts (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, api-spare.ngrok.io) ≤1 rps; check for /health, /docs, /openapi.json
impact: Exposure of staging infrastructure, dev tunnels, internal tooling; enables targeted attacks on less-hardened environments; severity P3
testability: PASSIVE
[PARKED] forms.sparelabs.com object-store directory listing: confidence 45 but object-store directory listings are rare on DO Spaces/S3 by default; verify_steps may yield only 404/403 without actionable signal; also REJECTED in knowledge base
[FINAL] 1. api.sparelabs.com inconsistent auth enforcement across /v1/* endpoints (confidence 65)
[FINAL] 2. platform.sparelabs.com CSP + MFE manifest leaks staging admin inventory (confidence 60)
[FINAL] 3. forms.sparelabs.com JS bundle leaks staging API endpoints and internal infrastructure (confidence 55)
[NEXT] PROBE: GET https://api.sparelabs.com/v1/config, GET https://api.sparelabs.com/v1/health, GET https://api.sparelabs.com/v1/journeyNotifications, GET https://api.sparelabs.com/v1/nonexistent (sequential, ≤1 rps, no Authorization header)
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1: live probe confirms /v1/journeys returns explicit 401 without auth, proving API surface exists behind edge gateway and auth enforcement is at least partially active
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + MFE manifest enumeration of staging admin assets confirmed passively
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: asset returns envoy 404, no routing API surface visible, confidence below threshold, no auth context available
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login prefetch script CONFIRMED leaking admin-eam-app-staging.vercel.app, admin-fixed-route-app-staging.vercel.app, metabase.staging.sparelabs.com, plus 20+ production infra URLs
[LEARN] ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle CONFIRMED leaking api.staging.us.sparelabs.com, api.staging.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, api-spare.ngrok.io, sparelabs.atlassian.net
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com: /v1/ API CONFIRMED discoverable via passive enum. 3 unauthenticated endpoints live (200/400/404); 15+ auth-gated endpoints confirmed (401). OpenAPI validation errors leak UUID format requirement + query param schema
[LEARN] REJECTED AUTH @ api.sparelabs.com: Previous "auth not challengeable" hypothesis PARKED — edge properly returns 401 for auth-gated routes; new finding is the unauthenticated /v1/public/* endpoints
[LEARN] REJECTED MISCONFIG @ forms.sparelabs.com: Object-store directory listing hypothesis PARKED — traffic served via envoy+Google CDN (not raw object store); SPA catch-all returns index.html for all paths
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql, /map, /directions paths return 404; no discoverable surface behind envoy gateway
[RISK] api.sparelabs.com: 70 reason — envoy edge gateway hiding large /v1/ API surface; partial auth enforcement proven; inconsistent guards likely across many endpoints; high business value as core API
[RISK] platform.sparelabs.com: 65 reason — MFE SPA shell with CSP leaking staging admin apps, Metabase, Cognito, DO Spaces; auth-gated but headers disclose inventory; high business value as operator console
[RISK] routing.sparelabs.com: 50 reason — envoy gateway returning 404; hidden routing-engine API behind edge; low visible exposure, high latent value if routing logic exposed
[RISK] forms.sparelabs.com: 45 reason — public "Spare Engage" static SPA on object store; open root, limited surface; IDOR risk only if shared /v1 API has cross-tenant flaws
[RISK] web (spare.com/sparelabs.com): 40 reason — Webflow marketing site behind Cloudflare; sparelabs.com 301→spare.com; static exposure only
## 2026-08-07 20:03:50 UTC [platform] (model nemotron3)
[PRIO] api.sparelabs.com, 7.15, attack=8 business=8 tech=7 gate=6 cloud=6 fresh=8
[PRIO] platform.sparelabs.com, 6.85, attack=7 business=9 tech=7 gate=3 cloud=7 fresh=9
[PRIO] forms.sparelabs.com, 5.95, attack=5 business=6 tech=4 gate=8 cloud=6 fresh=8
[PRIO] routing.sparelabs.com, 5.75, attack=6 business=7 tech=5 gate=3 cloud=5 fresh=8
[PRIO] sparelabs.com, 4.70, attack=4 business=5 tech=2 gate=9 cloud=3 fresh=5
[PRIO] spare.com, 4.10, attack=3 business=4 tech=2 gate=9 cloud=2 fresh=4
[HYP] api.sparelabs.com inconsistent auth enforcement across /v1/* endpoints
class: MISCONFIG
asset: api.sparelabs.com/v1/**
confidence: 65
reasoning: Live probe shows /v1/journeys returns 401 InvalidTokenError without auth header; single-header gate observed on one route only; large v1 surface may have inconsistent guard coverage. 3 unauthenticated endpoints confirmed (/v1/global/organizations→200, /v1/public/organization→400/404, /v1/public/terms→400/404); 15+ auth-gated endpoints return 401.
evidence_needed: A /v1/* route returning 2xx without auth, or 500/stacktrace instead of 401
verify_steps: PASSIVE. GET (no Authorization) /v1/config, /v1/health, /v1/journeyNotifications, /v1/nonexistent (control); classify 401/200/404/500; ≤1 rps, 4 requests
impact: Unauthenticated read of operational/journey data if any route misses the guard; severity MEDIUM-HIGH
testability: PASSIVE
[HYP] platform.sparelabs.com CSP + MFE manifest leaks staging admin inventory
class: MISCONFIG
asset: platform.sparelabs.com (response content-security-policy + /login MFE manifest prefetch)
confidence: 60
reasoning: CSP + /login prefetch script enumerate admin-eam-app(-staging).vercel.app, admin-fixed-route-app(-staging).vercel.app, metabase.sparelabs.com, metabase.staging.sparelabs.com, cognito-identity.us-west-2.amazonaws.com, *.digitaloceanspaces.com; staging admin apps typically less hardened than production
evidence_needed: Staging apps render auth prompts outside prod SSO; confirm CSP directives allow framing/script from staging origins
verify_steps: PASSIVE — GET https://platform.sparelabs.com/login → read CSP + grep manifest.wc.json URLs; verify staging hosts respond
impact: Attacker learns internal admin/staging URLs + integrations; enables targeted follow-up; severity P3
testability: PASSIVE
[HYP] forms.sparelabs.com JS bundle leaks staging API endpoints and internal infrastructure
class: MISCONFIG
asset: forms.sparelabs.com (main.6ed467ae.js)
confidence: 55
reasoning: JS bundle (342,725 bytes) leaks staging+prod API hosts (api.us.sparelabs.com, api.staging.us.sparelabs.com, api.staging.sparelabs.com, api-spare.ngrok.io), forms.staging.*, sparelabs.atlassian.net (JIRA); SPA catch-all returns index.html for all paths behind envoy+Google CDN
evidence_needed: Confirm leaked endpoints respond and expose debug/info endpoints; verify ngrok tunnel is active
verify_steps: PASSIVE — HEAD/GET leaked staging hosts (api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, api-spare.ngrok.io) ≤1 rps; check for /health, /docs, /openapi.json
impact: Exposure of staging infrastructure, dev tunnels, internal tooling; enables targeted attacks on less-hardened environments; severity P3
testability: PASSIVE
[FINAL] 1. api.sparelabs.com inconsistent auth enforcement across /v1/* endpoints (confidence 65)
[FINAL] 2. platform.sparelabs.com CSP + MFE manifest leaks staging admin inventory (confidence 60)
[FINAL] 3. forms.sparelabs.com JS bundle leaks staging API endpoints and internal infrastructure (confidence 55)
[NEXT] PROBE: GET https://api.sparelabs.com/v1/config, GET https://api.sparelabs.com/v1/health, GET https://api.sparelabs.com/v1/journeyNotifications, GET https://api.sparelabs.com/v1/nonexistent (sequential, ≤1 rps, no Authorization header)
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1: live probe confirms /v1/journeys returns explicit 401 without auth, proving API surface exists behind edge gateway and auth enforcement is at least partially active
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + MFE manifest enumeration of staging admin assets confirmed passively
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: asset returns envoy 404, no routing API surface visible, confidence below threshold, no auth context available
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login prefetch script CONFIRMED leaking admin-eam-app-staging.vercel.app, admin-fixed-route-app-staging.vercel.app, metabase.staging.sparelabs.com, plus 20+ production infra URLs
[LEARN] ACCEPTED MISCONFIG @ forms.sparelabs.com: JS bundle CONFIRMED leaking api.staging.us.sparelabs.com, api.staging.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, api-spare.ngrok.io, sparelabs.atlassian.net
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com: /v1/ API CONFIRMED discoverable via passive enum. 3 unauthenticated endpoints live (200/400/404); 15+ auth-gated endpoints confirmed (401). OpenAPI validation errors leak UUID format requirement + query param schema
[LEARN] REJECTED AUTH @ api.sparelabs.com: Previous "auth not challengeable" hypothesis PARKED — edge properly returns 401 for auth-gated routes; new finding is the unauthenticated /v1/public/* endpoints
[LEARN] REJECTED MISCONFIG @ forms.sparelabs.com: Object-store directory listing hypothesis PARKED — traffic served via envoy+Google CDN (not raw object store); SPA catch-all returns index.html for all paths
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; no discoverable surface behind envoy gateway
[RISK] api.sparelabs.com: 70 reason — envoy edge gateway hiding large /v1/ API surface; partial auth enforcement proven; inconsistent guards likely across many endpoints; high business value as core API
[RISK] platform.sparelabs.com: 65 reason — MFE SPA shell with CSP leaking staging admin apps, Metabase, Cognito, DO Spaces; auth-gated but headers disclose inventory; high business value as operator console
[RISK] routing.sparelabs.com: 50 reason — envoy gateway returning 404; hidden routing-engine API behind edge; low visible exposure, high latent value if routing logic exposed
[RISK] forms.sparelabs.com: 45 reason — public "Spare Engage" static SPA on object store; open root, limited surface; IDOR risk only if shared /v1 API has cross-tenant flaws
[RISK] web (spare.com/sparelabs.com): 40 reason — Webflow marketing site behind Cloudflare; sparelabs.com 301→spare.com; static exposure only
## 2026-08-07 20:57:28 UTC [platform] (model nemotron3)
[CHANGED] api.sparelabs.com `/v1/global/organizations` now returns 401 (was 200) but body returns `{"data":[]}` — data returned despite 401 status
[CHANGED] api.sparelabs.com `/v1/public/organization?organizationId=<uuid>` now returns 401 (was 400/404) with `NotFoundError` body — auth gate added but error info leaks
[CHANGED] api.sparelabs.com `/v1/public/terms?organizationId=<uuid>` now returns 401 (was 400/404) but body returns full terms URLs — **data returned despite 401 status**
[NEW] api.sparelabs.com CORS `access-control-allow-origin` reflects **any Origin** with `access-control-allow-credentials: true` on **all /v1 endpoints** (including auth-gated `/v1/journeys`)
[CHANGED] forms.sparelabs.com JS bundle filename rotated (`main.6ed467ae.js` → `main.71d52314.js`) but **same leaked endpoints persist**: `api.staging.sparelabs.com`, `api.staging.us.sparelabs.com`, `api-spare.ngrok.io`, `sparelabs.atlassian.net`, `forms.staging.*`
[NEW] `forms.staging.sparelabs.com` and `forms.staging.us.sparelabs.com` now **respond 200** (same SPA catch-all, 537 bytes, envoy+Google CDN)
[NEW] `api.staging.sparelabs.com` and `api.staging.us.sparelabs.com` respond **404** (envoy gateway, same as prod)
[NEW] `admin-eam-app-staging.vercel.app` and `admin-fixed-route-app-staging.vercel.app` **respond 200** (Vercel, CORS `*`, minimal HTML)
[NEW] `metabase.staging.sparelabs.com` **responds 200** (envoy gateway, Metabase login page, frame-ancestors 'none')
[NEW] `api-spare.ngrok.io` returns **ngrok 404 (ERR_NGROK_3200)** — tunnel inactive
[PRIO] api.sparelabs.com/v1/**, 8.95, attack=10 business=9 tech=10 gate=10 cloud=7 fresh=9
[PRIO] platform.sparelabs.com, 7.30, attack=8 business=9 tech=8 gate=5 cloud=7 fresh=9
[PRIO] forms.sparelabs.com, 5.95, attack=6 business=6 tech=5 gate=8 cloud=6 fresh=8
[PRIO] admin-eam-app-staging.vercel.app, 5.80, attack=7 business=7 tech=6 gate=9 cloud=5 fresh=9
[PRIO] admin-fixed-route-app-staging.vercel.app, 5.80, attack=7 business=7 tech=6 gate=9 cloud=5 fresh=9
[PRIO] metabase.staging.sparelabs.com, 5.65, attack=6 business=8 tech=6 gate=7 cloud=6 fresh=9
[PRIO] forms.staging.sparelabs.com, 5.10, attack=5 business=5 tech=4 gate=8 cloud=5 fresh=8
[PRIO] routing.sparelabs.com, 4.50, attack=4 business=6 tech=4 gate=5 cloud=4 fresh=6
[PRIO] sparelabs.com, 3.85, attack=3 business=4 tech=2 gate=9 cloud=2 fresh=5
[PRIO] spare.com, 3.60, attack=2 business=3 tech=2 gate=9 cloud=2 fresh=4
[HYP] api.sparelabs.com CORS reflect-any-origin with credentials on entire /v1 API surface
class: MISCONFIG
asset: api.sparelabs.com/v1/**
confidence: 95
reasoning: Live probe confirms `access-control-allow-origin: https://evil.com` + `access-control-allow-credentials: true` on `/v1/journeys` (auth-gated), `/v1/global/organizations`, `/v1/public/terms`, `/v1/public/organization`. Envoy gateway reflects arbitrary Origin unconditionally.
evidence_needed: Victim with valid session cookie/token visits attacker page → attacker reads authenticated responses via fetch(credentials: 'include')
verify_steps: PASSIVE — curl -H "Origin: https://evil.com" -I https://api.sparelabs.com/v1/journeys (already done); AUTH_HELPED — with valid token, verify cookie/session attaches cross-origin
impact: Full account takeover if any auto-attached credential exists (cookie, client cert, HTTP auth); severity CRITICAL
testability: PASSIVE (CORS headers confirmed); AUTH_HELPED (exploit verification)
[HYP] api.sparelabs.com /v1/public/* endpoints return sensitive data despite 401 status code
class: MISCONFIG
asset: api.sparelabs.com/v1/public/terms, /v1/global/organizations, /v1/public/organization
confidence: 85
reasoning: `/v1/public/terms` returns 401 but body contains `termsOfUseUrl`, `privacyPolicyUrl`; `/v1/global/organizations` returns 401 with `{"data":[]}`; `/v1/public/organization` returns 401 with `NotFoundError` revealing org existence. Status code misleading; data returned without auth.
evidence_needed: Confirm other `/v1/public/*` or `/v1/global/*` endpoints return data on 401; verify no auth header required for data access
verify_steps: PASSIVE — GET /v1/public/terms?organizationId=valid-uuid (capture body), GET /v1/global/organizations, GET /v1/public/organization?organizationId=valid-uuid; classify status vs body
impact: Unauthenticated enumeration of org terms, org list (empty but confirmed endpoint), org existence via 404 vs 400; severity MEDIUM
testability: PASSIVE
[HYP] platform.sparelabs.com CSP + MFE manifest leaks accessible staging admin apps (Vercel) and Metabase
class: MISCONFIG
asset: platform.sparelabs.com (CSP + /login MFE prefetch script)
confidence: 90
reasoning: CSP + /login script enumerates `admin-eam-app-staging.vercel.app`, `admin-fixed-route-app-staging.vercel.app`, `metabase.staging.sparelabs.com`. Live probes confirm all three respond 200: Vercel apps with CORS `*`, Metabase behind envoy with login page. Staging apps typically less hardened.
evidence_needed: Verify staging apps accept unauthenticated access or have weaker auth; check for debug endpoints, source maps, exposed admin APIs
verify_steps: PASSIVE — GET https://admin-eam-app-staging.vercel.app, GET https://admin-fixed-route-app-staging.vercel.app, GET https://metabase.staging.sparelabs.com; inspect for auth prompts, debug info, API endpoints
impact: Attacker gains direct access to staging admin consoles and BI tool; enables targeted follow-up on less-hardened environments; severity HIGH
testability: PASSIVE
[PARKED] api.sparelabs.com inconsistent auth enforcement across /v1/* endpoints: Confidence 65 in prior run, but live probes show auth gate now active on previously unauthenticated endpoints (all return 401). However, data still returned on 401 — covered by newer hypothesis above. Dropped: superseded by more precise finding (data-on-401).
[PARKED] forms.sparelabs.com JS bundle leaks staging API endpoints: Confidence 55, but staging API endpoints (`api.staging.*`) return 404 (no surface). Leaked `forms.staging.*` are live but same SPA. `api-spare.ngrok.io` inactive. `sparelabs.atlassian.net` out of scope. Dropped: no exploitable surface on leaked API hosts; staging forms already covered by forms.sparelabs.com risk.
[FINAL] 1. api.sparelabs.com CORS reflect-any-origin with credentials on entire /v1 API surface (confidence 95)
[FINAL] 2. api.sparelabs.com /v1/public/* endpoints return sensitive data despite 401 status code (confidence 85)
[FINAL] 3. platform.sparelabs.com CSP + MFE manifest leaks accessible staging admin apps and Metabase (confidence 90)
[NEXT] AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with `access-control-allow-credentials: true` allows cross-origin authenticated requests to `/v1/journeys` or other auth-gated endpoints — i.e., does the victim's browser auto-attach credentials (cookie/Bearer) when attacker's page calls `fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})`?
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on all /v1 endpoints (including auth-gated) via live probe
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/*: Endpoints return response data (terms URLs, org list, org existence) despite 401 status code — misleading status, data accessible without auth
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking staging admin apps (2x Vercel) and Metabase; all three staging hosts respond 200 and are accessible
[LEARN] REJECTED MISCONFIG @ api.staging.sparelabs.com: Leaked staging API hosts return 404 behind same envoy gateway — no independent API surface
[LEARN] REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
[LEARN] ACCEPTED MISCONFIG @ forms.staging.sparelabs.com / forms.staging.us.sparelabs.com: Staging forms portals live (200, same SPA catch-all behind envoy+Google CDN)
[RISK] api.sparelabs.com: 95 reason — Envoy edge gateway reflects any Origin with credentials on entire /v1 API; /v1/public/* endpoints return data despite 401; core API with high business value; critical CORS misconfig
[RISK] platform.sparelabs.com: 85 reason — MFE SPA shell leaks accessible staging admin apps (Vercel, CORS *) and Metabase (envoy, login page); auth-gated prod but staging inventory exposed and live
[RISK] routing.sparelabs.com: 40 reason — Envoy gateway returning 404; no discoverable routing API surface; low visible exposure
[RISK] forms.sparelabs.com: 50 reason — Public SPA on object store/CDN; JS bundle leaks staging infra (forms.staging.* live, api.staging.* 404, ngrok dead, JIRA OOS); IDOR risk only if shared /v1 API has cross-tenant flaws
[RISK] web (spare.com/sparelabs.com): 35 reason — Webflow marketing site behind Cloudflare; sparelabs.com 301→spare.com; static exposure only
## 2026-08-07 21:31:05 UTC [platform] (model nemotron3)
[NEW] None — all in-scope assets respond identically to 2026-08-07 20:57:44 UTC baseline (api CORS reflect-any-origin+creds on /v1/**, /v1/public/* data-on-401, platform CSP leaks staging admin/Metabase, forms staging portals live, routing 404, spare.com/sparelabs.com Cloudflare marketing)
[PRIO] api.sparelabs.com/v1/**, 8.95, attack=10 business=9 tech=10 gate=10 cloud=7 fresh=9
[PRIO] platform.sparelabs.com, 7.30, attack=8 business=9 tech=8 gate=5 cloud=7 fresh=9
[PRIO] admin-eam-app-staging.vercel.app, 5.80, attack=7 business=7 tech=6 gate=9 cloud=5 fresh=9
[PRIO] admin-fixed-route-app-staging.vercel.app, 5.80, attack=7 business=7 tech=6 gate=9 cloud=5 fresh=9
[PRIO] metabase.staging.sparelabs.com, 5.65, attack=6 business=8 tech=6 gate=7 cloud=6 fresh=9
[PRIO] forms.sparelabs.com, 5.10, attack=5 business=6 tech=5 gate=8 cloud=6 fresh=8
[PRIO] forms.staging.sparelabs.com, 4.95, attack=4 business=5 tech=4 gate=8 cloud=5 fresh=8
[PRIO] routing.sparelabs.com, 4.50, attack=4 business=6 tech=4 gate=5 cloud=4 fresh=6
[PRIO] sparelabs.com, 3.85, attack=3 business=4 tech=2 gate=9 cloud=2 fresh=5
[PRIO] spare.com, 3.60, attack=2 business=3 tech=2 gate=9 cloud=2 fresh=4
[HYP] api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests
class: MISCONFIG
asset: api.sparelabs.com/v1/**
confidence: 95
reasoning: Live probe confirms `access-control-allow-origin: https://evil.com` + `access-control-allow-credentials: true` on all /v1 endpoints including auth-gated `/v1/journeys`. Envoy gateway reflects arbitrary Origin unconditionally.
evidence_needed: Victim with valid session cookie/token visits attacker page → attacker reads authenticated responses via `fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})`
verify_steps: AUTH_HELPED: With authorized test account, obtain session cookie/token; host attacker page calling `fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})` and observe if response data (journeys) is readable cross-origin
impact: Full account takeover if any auto-attached credential exists (cookie, client cert, HTTP auth); severity CRITICAL
testability: AUTH_HELPED
[HYP] api.sparelabs.com /v1/public/* endpoints return sensitive data despite 401 status code
class: MISCONFIG
asset: api.sparelabs.com/v1/public/terms, /v1/global/organizations, /v1/public/organization
confidence: 85
reasoning: `/v1/public/terms` returns 401 but body contains `termsOfUseUrl`, `privacyPolicyUrl`; `/v1/global/organizations` returns 401 with `{"data":[]}`; `/v1/public/organization` returns 401 with `NotFoundError` revealing org existence. Status code misleading; data returned without auth.
evidence_needed: Confirm other `/v1/public/*` or `/v1/global/*` endpoints return data on 401; verify no auth header required for data access
verify_steps: PASSIVE: GET /v1/public/terms?organizationId=00000000-0000-0000-0000-000000000000 (capture body), GET /v1/global/organizations, GET /v1/public/organization?organizationId=00000000-0000-0000-0000-000000000000; classify status vs body
impact: Unauthenticated enumeration of org terms, org list (empty but confirmed endpoint), org existence via 404 vs 400; severity MEDIUM
testability: PASSIVE
[HYP] platform.sparelabs.com CSP + MFE manifest leaks accessible staging admin apps (Vercel) and Metabase
class: MISCONFIG
asset: platform.sparelabs.com (CSP + /login MFE prefetch script)
confidence: 90
reasoning: CSP + /login script enumerates `admin-eam-app-staging.vercel.app`, `admin-fixed-route-app-staging.vercel.app`, `metabase.staging.sparelabs.com`. Live probes confirm all three respond 200: Vercel apps with CORS `*`, Metabase behind envoy with login page. Staging apps typically less hardened.
evidence_needed: Verify staging apps accept unauthenticated access or have weaker auth; check for debug endpoints, source maps, exposed admin APIs
verify_steps: PASSIVE: GET https://admin-eam-app-staging.vercel.app (inspect for auth prompts, debug info, API endpoints), GET https://admin-fixed-route-app-staging.vercel.app, GET https://metabase.staging.sparelabs.com; check for exposed /api/, /debug/, source maps (.map)
impact: Attacker gains direct access to staging admin consoles and BI tool; enables targeted follow-up on less-hardened environments; severity HIGH
testability: PASSIVE
[PARKED] api.sparelabs.com inconsistent auth enforcement across /v1/* endpoints: Superseded by more precise findings (CORS reflect-any-origin + data-on-401 hypotheses cover the actual risk); original confidence 65, but auth gate now active on all endpoints per live probes
[PARKED] forms.sparelabs.com JS bundle leaks staging API endpoints: Staging API hosts (`api.staging.*`) return 404 (no independent surface); leaked `forms.staging.*` are live but same SPA catch-all; `api-spare.ngrok.io` inactive; `sparelabs.atlassian.net` out of scope — no exploitable surface on leaked API hosts
[PARKED] routing.sparelabs.com hidden routing API behind envoy: CONFIRMED dead — all `/v1/`, `/api/`, `/routing/`, `/router`, `/v2/`, `/graphql`, `/map`, `/directions` paths return 404; no discoverable surface behind envoy gateway
[FINAL] 1. api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (confidence 95)
[FINAL] 2. platform.sparelabs.com CSP + MFE manifest leaks accessible staging admin apps and Metabase (confidence 90)
[FINAL] 3. api.sparelabs.com /v1/public/* endpoints return sensitive data despite 401 status code (confidence 85)
[NEXT] AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with `access-control-allow-credentials: true` allows cross-origin authenticated requests to `/v1/journeys` or other auth-gated endpoints — i.e., does the victim's browser auto-attach credentials (cookie/Bearer) when attacker's page calls `fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})`?
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on all /v1 endpoints (including auth-gated) via live probe
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/*: Endpoints return response data (terms URLs, org list, org existence) despite 401 status code — misleading status, data accessible without auth
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking staging admin apps (2x Vercel) and Metabase; all three staging hosts respond 200 and are accessible
[LEARN] REJECTED MISCONFIG @ api.staging.sparelabs.com: Leaked staging API hosts return 404 behind same envoy gateway — no independent API surface
[LEARN] REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
[LEARN] ACCEPTED MISCONFIG @ forms.staging.sparelabs.com / forms.staging.us.sparelabs.com: Staging forms portals live (200, same SPA catch-all behind envoy+Google CDN)
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; no discoverable surface behind envoy gateway
[RISK] api.sparelabs.com: 95 reason — Envoy edge gateway reflects any Origin with credentials on entire /v1 API; /v1/public/* endpoints return data despite 401; core API with high business value; critical CORS misconfig
[RISK] platform.sparelabs.com: 85 reason — MFE SPA shell leaks accessible staging admin apps (Vercel, CORS *) and Metabase (envoy, login page); auth-gated prod but staging inventory exposed and live
[RISK] routing.sparelabs.com: 40 reason — Envoy gateway returning 404; no discoverable routing API surface; low visible exposure
[RISK] forms.sparelabs.com: 50 reason — Public SPA on object store/CDN; JS bundle leaks staging infra (forms.staging.* live, api.staging.* 404, ngrok dead, JIRA OOS); IDOR risk only if shared /v1 API has cross-tenant flaws
[RISK] web (spare.com/sparelabs.com): 35 reason — Webflow marketing site behind Cloudflare; sparelabs.com 301→spare.com; static exposure only
## 2026-08-07 22:08:11 UTC [platform] (model nemotron3)
[PRIO] api.sparelabs.com/v1/**, 8.95, attack=10 business=9 tech=10 gate=10 cloud=7 fresh=9
[PRIO] platform.sparelabs.com, 7.30, attack=8 business=9 tech=8 gate=5 cloud=7 fresh=9
[PRIO] admin-eam-app-staging.vercel.app, 5.80, attack=7 business=7 tech=6 gate=9 cloud=5 fresh=9
[PRIO] admin-fixed-route-app-staging.vercel.app, 5.80, attack=7 business=7 tech=6 gate=9 cloud=5 fresh=9
[PRIO] metabase.staging.sparelabs.com, 5.65, attack=6 business=8 tech=6 gate=7 cloud=6 fresh=9
[PRIO] forms.sparelabs.com, 5.10, attack=5 business=6 tech=5 gate=8 cloud=6 fresh=8
[PRIO] forms.staging.sparelabs.com, 4.95, attack=4 business=5 tech=4 gate=8 cloud=5 fresh=8
[PRIO] routing.sparelabs.com, 4.50, attack=4 business=6 tech=4 gate=5 cloud=4 fresh=6
[PRIO] sparelabs.com, 3.85, attack=3 business=4 tech=2 gate=9 cloud=2 fresh=5
[PRIO] spare.com, 3.60, attack=2 business=3 tech=2 gate=9 cloud=2 fresh=4
[HYP] api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests
class: MISCONFIG
asset: api.sparelabs.com/v1/**
confidence: 95
reasoning: Live probe confirms `access-control-allow-origin` reflects arbitrary Origin + `access-control-allow-credentials: true` on all /v1 endpoints including auth-gated `/v1/journeys`. Envoy gateway reflects unconditionally. Preflight allows GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS + Authorization header.
evidence_needed: Victim with valid session visits attacker page → attacker reads/writes authenticated responses via `fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})`
verify_steps: AUTH_HELPED: With authorized test account, obtain session cookie/token; host attacker page calling `fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})` and `fetch('https://api.sparelabs.com/v1/journeys', {method:'POST', credentials:'include', headers:{Authorization:'Bearer <token>'}})`; observe if response data is readable/writable cross-origin
impact: Full account takeover if any auto-attached credential exists (cookie, client cert, HTTP auth); escalates read to write via reflected methods; severity CRITICAL
testability: AUTH_HELPED
[HYP] platform.sparelabs.com CSP + MFE manifest leaks accessible staging admin apps and Metabase
class: MISCONFIG
asset: platform.sparelabs.com (CSP + /login MFE prefetch script)
confidence: 90
reasoning: CSP + /login script enumerates `admin-eam-app-staging.vercel.app`, `admin-fixed-route-app-staging.vercel.app`, `metabase.staging.sparelabs.com`. Live probes confirm all three respond 200: Vercel apps with CORS `*`, Metabase behind envoy with login page. Staging apps typically less hardened.
evidence_needed: Verify staging apps accept unauthenticated access or have weaker auth; check for debug endpoints, source maps, exposed admin APIs
verify_steps: PASSIVE: GET https://admin-eam-app-staging.vercel.app (inspect for auth prompts, debug info, API endpoints), GET https://admin-fixed-route-app-staging.vercel.app, GET https://metabase.staging.sparelabs.com; check for exposed /api/, /debug/, source maps (.map), unauthenticated access to admin functions
impact: Attacker gains direct access to staging admin consoles and BI tool; enables targeted follow-up on less-hardened environments; severity HIGH
testability: PASSIVE
[HYP] api.sparelabs.com /v1/public/* endpoints return sensitive data despite 401 status code
class: MISCONFIG
asset: api.sparelabs.com/v1/public/terms, /v1/global/organizations, /v1/public/organization
confidence: 85
reasoning: `/v1/public/terms` returns 200 with `termsOfUseUrl`, `privacyPolicyUrl`; `/v1/global/organizations` returns 200 with `{"data":[]}`; `/v1/public/organization` returns 404/400 distinguishing org existence. All with reflected CORS+credentials. Status code inconsistent (was 401, now 200/404) but data accessible without auth.
evidence_needed: Confirm other `/v1/public/*` or `/v1/global/*` endpoints return data without auth; verify no auth header required for data access
verify_steps: PASSIVE: GET /v1/public/terms?organizationId=00000000-0000-0000-0000-000000000000 (capture body), GET /v1/global/organizations, GET /v1/public/organization?organizationId=00000000-0000-0000-0000-000000000000; classify status vs body; test additional /v1/public/* paths from JS bundle enumeration
impact: Unauthenticated enumeration of org terms, org list, org existence via 404 vs 400 oracle; severity MEDIUM
testability: PASSIVE
[FINAL] 1. api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (confidence 95)
[FINAL] 2. platform.sparelabs.com CSP + MFE manifest leaks accessible staging admin apps and Metabase (confidence 90)
[FINAL] 3. api.sparelabs.com /v1/public/* endpoints return sensitive data despite 401 status code (confidence 85)
[NEXT] AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with `access-control-allow-credentials: true` allows cross-origin authenticated requests to `/v1/journeys` or other auth-gated endpoints — i.e., does the victim's browser auto-attach credentials (cookie/Bearer) when attacker's page calls `fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})`?
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on all /v1 endpoints (including auth-gated) via live probe
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/*: Endpoints return response data (terms URLs, org list, org existence) despite 401 status code — misleading status, data accessible without auth
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking staging admin apps (2x Vercel) and Metabase; all three staging hosts respond 200 and are accessible
[LEARN] REJECTED MISCONFIG @ api.staging.sparelabs.com: Leaked staging API hosts return 404 behind same envoy gateway — no independent API surface
[LEARN] REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
[LEARN] ACCEPTED MISCONFIG @ forms.staging.sparelabs.com / forms.staging.us.sparelabs.com: Staging forms portals live (200, same SPA catch-all behind envoy+Google CDN)
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; no discoverable surface behind envoy gateway
[RISK] api.sparelabs.com: 95 reason — Envoy edge gateway reflects any Origin with credentials on entire /v1 API; /v1/public/* endpoints return data despite 401; core API with high business value; critical CORS misconfig
[RISK] platform.sparelabs.com: 85 reason — MFE SPA shell leaks accessible staging admin apps (Vercel, CORS *) and Metabase (envoy, login page); auth-gated prod but staging inventory exposed and live
[RISK] routing.sparelabs.com: 40 reason — Envoy gateway returning 404; no discoverable routing API surface; low visible exposure
[RISK] forms.sparelabs.com: 50 reason — Public SPA on object store/CDN; JS bundle leaks staging infra (forms.staging.* live, api.staging.* 404, ngrok dead, JIRA OOS); IDOR risk only if shared /v1 API has cross-tenant flaws
[RISK] web (spare.com/sparelabs.com): 35 reason — Webflow marketing site behind Cloudflare; sparelabs.com 301→spare.com; static exposure only
## 2026-08-07 22:52:54 UTC [platform] (model nemotron3)
[PRIO] api.sparelabs.com/v1/**, 8.95, attack=10 business=9 tech=10 gate=10 cloud=7 fresh=9
[PRIO] platform.sparelabs.com, 7.30, attack=8 business=9 tech=8 gate=5 cloud=7 fresh=9
[PRIO] admin-eam-app-staging.vercel.app, 5.80, attack=7 business=7 tech=6 gate=9 cloud=5 fresh=9
[PRIO] admin-fixed-route-app-staging.vercel.app, 5.80, attack=7 business=7 tech=6 gate=9 cloud=5 fresh=9
[PRIO] metabase.staging.sparelabs.com, 5.65, attack=6 business=8 tech=6 gate=7 cloud=6 fresh=9
[PRIO] forms.sparelabs.com, 5.10, attack=5 business=6 tech=5 gate=8 cloud=6 fresh=8
[PRIO] forms.staging.sparelabs.com, 4.95, attack=4 business=5 tech=4 gate=8 cloud=5 fresh=8
[PRIO] routing.sparelabs.com, 4.50, attack=4 business=6 tech=4 gate=5 cloud=4 fresh=6
[PRIO] sparelabs.com, 3.85, attack=3 business=4 tech=2 gate=9 cloud=2 fresh=5
[PRIO] spare.com, 3.60, attack=2 business=3 tech=2 gate=9 cloud=2 fresh=4
[HYP] api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests
class: MISCONFIG
asset: api.sparelabs.com/v1/**
confidence: 95
reasoning: Live probe confirms `access-control-allow-origin` reflects arbitrary Origin + `access-control-allow-credentials: true` on all /v1 endpoints including auth-gated `/v1/journeys`. Envoy gateway reflects unconditionally. Preflight allows GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS + Authorization header.
evidence_needed: Victim with valid session visits attacker page → attacker reads/writes authenticated responses via `fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})`
verify_steps: AUTH_HELPED: With authorized test account, obtain session cookie/token; host attacker page calling `fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})` and `fetch('https://api.sparelabs.com/v1/journeys', {method:'POST', credentials:'include', headers:{Authorization:'Bearer <token>'}})`; observe if response data is readable/writable cross-origin
impact: Full account takeover if any auto-attached credential exists (cookie, client cert, HTTP auth); escalates read to write via reflected methods; severity CRITICAL
testability: AUTH_HELPED
[HYP] platform.sparelabs.com CSP + MFE manifest leaks accessible staging admin apps and Metabase
class: MISCONFIG
asset: platform.sparelabs.com (CSP + /login MFE prefetch script)
confidence: 90
reasoning: CSP + /login script enumerates `admin-eam-app-staging.vercel.app`, `admin-fixed-route-app-staging.vercel.app`, `metabase.staging.sparelabs.com`. Live probes confirm all three respond 200: Vercel apps with CORS `*`, Metabase behind envoy with login page. Staging apps typically less hardened.
evidence_needed: Verify staging apps accept unauthenticated access or have weaker auth; check for debug endpoints, source maps, exposed admin APIs
verify_steps: PASSIVE: GET https://admin-eam-app-staging.vercel.app (inspect for auth prompts, debug info, API endpoints), GET https://admin-fixed-route-app-staging.vercel.app, GET https://metabase.staging.sparelabs.com; check for exposed /api/, /debug/, source maps (.map), unauthenticated access to admin functions
impact: Attacker gains direct access to staging admin consoles and BI tool; enables targeted follow-up on less-hardened environments; severity HIGH
testability: PASSIVE
[HYP] api.sparelabs.com /v1/public/* endpoints return sensitive data despite 401 status code
class: MISCONFIG
asset: api.sparelabs.com/v1/public/terms, /v1/global/organizations, /v1/public/organization
confidence: 85
reasoning: `/v1/public/terms` returns 200 with `termsOfUseUrl`, `privacyPolicyUrl`; `/v1/global/organizations` returns 200 with `{"data":[]}`; `/v1/public/organization` returns 404/400 distinguishing org existence. All with reflected CORS+credentials. Status code inconsistent (was 401, now 200/404) but data accessible without auth.
evidence_needed: Confirm other `/v1/public/*` or `/v1/global/*` endpoints return data without auth; verify no auth header required for data access
verify_steps: PASSIVE: GET /v1/public/terms?organizationId=00000000-0000-0000-0000-000000000000 (capture body), GET /v1/global/organizations, GET /v1/public/organization?organizationId=00000000-0000-0000-0000-000000000000; classify status vs body; test additional /v1/public/* paths from JS bundle enumeration
impact: Unauthenticated enumeration of org terms, org list, org existence via 404 vs 400 oracle; severity MEDIUM
testability: PASSIVE
[FINAL] 1. api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (confidence 95)
[FINAL] 2. platform.sparelabs.com CSP + MFE manifest leaks accessible staging admin apps and Metabase (confidence 90)
[FINAL] 3. api.sparelabs.com /v1/public/* endpoints return sensitive data despite 401 status code (confidence 85)
[NEXT] AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with `access-control-allow-credentials: true` allows cross-origin authenticated requests to `/v1/journeys` or other auth-gated endpoints — i.e., does the victim's browser auto-attach credentials (cookie/Bearer) when attacker's page calls `fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})`?
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on all /v1 endpoints (including auth-gated) via live probe
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/*: Endpoints return response data (terms URLs, org list, org existence) despite 401 status code — misleading status, data accessible without auth
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking staging admin apps (2x Vercel) and Metabase; all three staging hosts respond 200 and are accessible
[LEARN] REJECTED MISCONFIG @ api.staging.sparelabs.com: Leaked staging API hosts return 404 behind same envoy gateway — no independent API surface
[LEARN] REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
[LEARN] ACCEPTED MISCONFIG @ forms.staging.sparelabs.com / forms.staging.us.sparelabs.com: Staging forms portals live (200, same SPA catch-all behind envoy+Google CDN)
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; no discoverable surface behind envoy gateway
[RISK] api.sparelabs.com: 95 reason — Envoy edge gateway reflects any Origin with credentials on entire /v1 API; /v1/public/* endpoints return data despite 401; core API with high business value; critical CORS misconfig
[RISK] platform.sparelabs.com: 85 reason — MFE SPA shell leaks accessible staging admin apps (Vercel, CORS *) and Metabase (envoy, login page); auth-gated prod but staging inventory exposed and live
[RISK] routing.sparelabs.com: 40 reason — Envoy gateway returning 404; no discoverable routing API surface; low visible exposure
[RISK] forms.sparelabs.com: 50 reason — Public SPA on object store/CDN; JS bundle leaks staging infra (forms.staging.* live, api.staging.* 404, ngrok dead, JIRA OOS); IDOR risk only if shared /v1 API has cross-tenant flaws
[RISK] web (spare.com/sparelabs.com): 35 reason — Webflow marketing site behind Cloudflare; sparelabs.com 301→spare.com; static exposure only
## 2026-08-07 23:26:25 UTC [platform] (model nemotron3)
[NEW] NO_DELTA — all in-scope assets stable since 2026-08-07 22:55:14 UTC; no new surface changes observed
[PRIO] api.sparelabs.com/v1/**, 8.95, attack=10 business=9 tech=10 gate=10 cloud=7 fresh=9
[PRIO] platform.sparelabs.com, 7.30, attack=8 business=9 tech=8 gate=5 cloud=7 fresh=9
[PRIO] admin-eam-app-staging.vercel.app, 5.80, attack=7 business=7 tech=6 gate=9 cloud=5 fresh=9
[PRIO] admin-fixed-route-app-staging.vercel.app, 5.80, attack=7 business=7 tech=6 gate=9 cloud=5 fresh=9
[PRIO] metabase.staging.sparelabs.com, 5.65, attack=6 business=8 tech=6 gate=7 cloud=6 fresh=9
[PRIO] forms.sparelabs.com, 5.10, attack=5 business=6 tech=5 gate=8 cloud=6 fresh=8
[PRIO] forms.staging.sparelabs.com, 4.95, attack=4 business=5 tech=4 gate=8 cloud=5 fresh=8
[PRIO] routing.sparelabs.com, 4.50, attack=4 business=6 tech=4 gate=5 cloud=4 fresh=6
[PRIO] sparelabs.com, 3.85, attack=3 business=4 tech=2 gate=9 cloud=2 fresh=5
[PRIO] spare.com, 3.60, attack=2 business=3 tech=2 gate=9 cloud=2 fresh=4
[HYP] api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests
class: MISCONFIG
asset: api.sparelabs.com/v1/**
confidence: 95
reasoning: Live probe confirms `access-control-allow-origin` reflects arbitrary Origin + `access-control-allow-credentials: true` on all /v1 endpoints including auth-gated `/v1/journeys`. Envoy gateway reflects unconditionally. Preflight allows GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS + Authorization header.
evidence_needed: Victim with valid session visits attacker page → attacker reads/writes authenticated responses via `fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})`
verify_steps: AUTH_HELPED: With authorized test account, obtain session cookie/token; host attacker page calling `fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})` and `fetch('https://api.sparelabs.com/v1/journeys', {method:'POST', credentials:'include', headers:{Authorization:'Bearer <token>'}})`; observe if response data is readable/writable cross-origin
impact: Full account takeover if any auto-attached credential exists (cookie, client cert, HTTP auth); escalates read to write via reflected methods; severity CRITICAL
testability: AUTH_HELPED
[HYP] platform.sparelabs.com CSP + MFE manifest leaks accessible staging admin apps and Metabase
class: MISCONFIG
asset: platform.sparelabs.com (CSP + /login MFE prefetch script)
confidence: 90
reasoning: CSP + /login script enumerates `admin-eam-app-staging.vercel.app`, `admin-fixed-route-app-staging.vercel.app`, `metabase.staging.sparelabs.com`. Live probes confirm all three respond 200: Vercel apps with CORS `*`, Metabase behind envoy with login page. Staging apps typically less hardened.
evidence_needed: Verify staging apps accept unauthenticated access or have weaker auth; check for debug endpoints, source maps, exposed admin APIs
verify_steps: PASSIVE: GET https://admin-eam-app-staging.vercel.app (inspect for auth prompts, debug info, API endpoints), GET https://admin-fixed-route-app-staging.vercel.app, GET https://metabase.staging.sparelabs.com; check for exposed /api/, /debug/, source maps (.map), unauthenticated access to admin functions
impact: Attacker gains direct access to staging admin consoles and BI tool; enables targeted follow-up on less-hardened environments; severity HIGH
testability: PASSIVE
[HYP] api.sparelabs.com /v1/public/* endpoints return sensitive data despite 401 status code
class: MISCONFIG
asset: api.sparelabs.com/v1/public/terms, /v1/global/organizations, /v1/public/organization
confidence: 85
reasoning: `/v1/public/terms` returns 200 with `termsOfUseUrl`, `privacyPolicyUrl`; `/v1/global/organizations` returns 200 with `{"data":[]}`; `/v1/public/organization` returns 404/400 distinguishing org existence. All with reflected CORS+credentials. Status code inconsistent but data accessible without auth.
evidence_needed: Confirm other `/v1/public/*` or `/v1/global/*` endpoints return data without auth; verify no auth header required for data access
verify_steps: PASSIVE: GET /v1/public/terms?organizationId=00000000-0000-0000-0000-000000000000 (capture body), GET /v1/global/organizations, GET /v1/public/organization?organizationId=00000000-0000-0000-0000-000000000000; classify status vs body; test additional /v1/public/* paths from JS bundle enumeration
impact: Unauthenticated enumeration of org terms, org list, org existence via 404 vs 400 oracle; severity MEDIUM
testability: PASSIVE
[PARKED] api.sparelabs.com /v1/global/* route-level auth omission (fail-open): confidence 55 but class overlaps with accepted MISCONFIG on same asset; verify_steps only PROBE differential without data-bearing proof; dropping to avoid duplicate hypothesis on same root cause
[FINAL] 1. api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (confidence 95)
[FINAL] 2. platform.sparelabs.com CSP + MFE manifest leaks accessible staging admin apps and Metabase (confidence 90)
[FINAL] 3. api.sparelabs.com /v1/public/* endpoints return sensitive data despite 401 status code (confidence 85)
[NEXT] AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with `access-control-allow-credentials: true` allows cross-origin authenticated requests to `/v1/journeys` or other auth-gated endpoints — i.e., does the victim's browser auto-attach credentials (cookie/Bearer) when attacker's page calls `fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})`?
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on all /v1 endpoints (including auth-gated) via live probe
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/*: Endpoints return response data (terms URLs, org list, org existence) despite 401 status code — misleading status, data accessible without auth
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking staging admin apps (2x Vercel) and Metabase; all three staging hosts respond 200 and are accessible
[LEARN] REJECTED MISCONFIG @ api.staging.sparelabs.com: Leaked staging API hosts return 404 behind same envoy gateway — no independent API surface
[LEARN] REJECTED MISCONFIG @ api-spare.ngrok.io: Ngrok dev tunnel inactive (ERR_NGROK_3200)
[LEARN] ACCEPTED MISCONFIG @ forms.staging.sparelabs.com / forms.staging.us.sparelabs.com: Staging forms portals live (200, same SPA catch-all behind envoy+Google CDN)
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: CONFIRMED dead — all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; no discoverable surface behind envoy gateway
[LEARN] ACCEPTED AUTH @ api.sparelabs.com/v1/global/organizations: fail-open now STABLE — 200 ×6 across ~2h incl. pagination variants (params ignored, hardcoded `{"data":[]}`), control route stable 401 → route-level auth omission confirmed as pattern, not flapping; severity remains capped while payload empty
[LEARN] REJECTED BUSLOGIC @ api.sparelabs.com: CORS reflect-any-origin+credentials re-confirmed on all /v1 (401, 404, and 200 paths) — uniformly applied API-scoped middleware, not path-conditional
[RISK] api.sparelabs.com: 95 reason — Envoy edge gateway reflects any Origin with credentials on entire /v1 API; /v1/public/* endpoints return data despite 401; core API with high business value; critical CORS misconfig
[RISK] platform.sparelabs.com: 85 reason — MFE SPA shell leaks accessible staging admin apps (Vercel, CORS *) and Metabase (envoy, login page); auth-gated prod but staging inventory exposed and live
[RISK] routing.sparelabs.com: 40 reason — Envoy gateway returning 404; no discoverable routing API surface; low visible exposure
[RISK] forms.sparelabs.com: 50 reason — Public SPA on object store/CDN; JS bundle leaks staging infra (forms.staging.* live, api.staging.* 404, ngrok dead, JIRA OOS); IDOR risk only if shared /v1 API has cross-tenant flaws
[RISK] web (spare.com/sparelabs.com): 35 reason — Webflow marketing site behind Cloudflare; sparelabs.com 301→spare.com; static exposure only
## 2026-08-07 23:57:09 UTC [platform] (model nemotron3)
[NEW] api.sparelabs.com /v1/** CORS reflect-any-origin with credentials confirmed on OPTIONS preflight for all methods (GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS) + Authorization header
[NEW] platform.sparelabs.com /login CSP now leaks production admin Vercel hosts (admin-eam-app.vercel.app, admin-fixed-route-app.vercel.app) in addition to staging
[PRIO] api.sparelabs.com/v1/**, 8.95, attack=10 business=9 tech=10 gate=10 cloud=7 fresh=9
[PRIO] platform.sparelabs.com, 7.30, attack=8 business=9 tech=8 gate=5 cloud=7 fresh=9
[PRIO] admin-eam-app-staging.vercel.app, 5.80, attack=7 business=7 tech=6 gate=9 cloud=5 fresh=9
[PRIO] admin-fixed-route-app-staging.vercel.app, 5.80, attack=7 business=7 tech=6 gate=9 cloud=5 fresh=9
[PRIO] metabase.staging.sparelabs.com, 5.65, attack=6 business=8 tech=6 gate=7 cloud=6 fresh=9
[PRIO] admin-eam-app.vercel.app, 5.50, attack=6 business=7 tech=5 gate=9 cloud=5 fresh=9
[PRIO] admin-fixed-route-app.vercel.app, 5.50, attack=6 business=7 tech=5 gate=9 cloud=5 fresh=9
[PRIO] forms.sparelabs.com, 5.10, attack=5 business=6 tech=5 gate=8 cloud=6 fresh=8
[PRIO] forms.staging.sparelabs.com, 4.95, attack=4 business=5 tech=4 gate=8 cloud=5 fresh=8
[PRIO] routing.sparelabs.com, 4.50, attack=4 business=6 tech=4 gate=5 cloud=4 fresh=6
[HYP] api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests
class: MISCONFIG
asset: api.sparelabs.com/v1/**
confidence: 95
reasoning: Live probe confirms access-control-allow-origin reflects arbitrary Origin + access-control-allow-credentials: true on all /v1 endpoints including auth-gated /v1/journeys. Preflight allows GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS + Authorization header.
evidence_needed: Victim with valid session visits attacker page → attacker reads/writes authenticated responses via fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})
verify_steps: AUTH_HELPED: With authorized test account, obtain session cookie/token; host attacker page calling fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'}) and fetch('https://api.sparelabs.com/v1/journeys', {method:'POST', credentials:'include', headers:{Authorization:'Bearer <token>'}}); observe if response data is readable/writable cross-origin
impact: Full account takeover if any auto-attached credential exists (cookie, client cert, HTTP auth); escalates read to write via reflected methods; severity CRITICAL
testability: AUTH_HELPED
[HYP] platform.sparelabs.com CSP + MFE manifest leaks accessible production admin apps alongside staging
class: MISCONFIG
asset: platform.sparelabs.com (/login CSP + MFE prefetch script)
confidence: 85
reasoning: CSP + /login script now enumerates both staging (admin-eam-app-staging.vercel.app, admin-fixed-route-app-staging.vercel.app) AND production (admin-eam-app.vercel.app, admin-fixed-route-app.vercel.app) Vercel apps. Live probes confirm staging respond 200 with CORS *; production hosts unprobed but enumerated in CSP.
evidence_needed: Verify production admin apps accept unauthenticated access or have weaker controls; check for debug endpoints, source maps, exposed admin APIs
verify_steps: PASSIVE: GET https://admin-eam-app.vercel.app, GET https://admin-fixed-route-app.vercel.app (inspect for auth prompts, debug info, API endpoints, source maps .map); compare hardening vs staging counterparts
impact: Attacker gains direct access to production admin consoles; enables targeted follow-up on less-hardened environments; severity HIGH
testability: PASSIVE
[HYP] api.sparelabs.com /v1/public/* endpoints return sensitive data despite 401 status code
class: MISCONFIG
asset: api.sparelabs.com/v1/public/terms, /v1/global/organizations, /v1/public/organization
confidence: 85
reasoning: /v1/public/terms returns 200 with termsOfUseUrl, privacyPolicyUrl; /v1/global/organizations returns 200 with {"data":[]}; /v1/public/organization returns 404/400 distinguishing org existence. All with reflected CORS+credentials. Status code inconsistent but data accessible without auth.
evidence_needed: Confirm other /v1/public/* or /v1/global/* endpoints return data without auth; verify no auth header required for data access
verify_steps: PASSIVE: GET /v1/public/terms?organizationId=00000000-0000-0000-0000-000000000000 (capture body), GET /v1/global/organizations, GET /v1/public/organization?organizationId=00000000-0000-0000-0000-000000000000; classify status vs body; test additional /v1/public/* paths from JS bundle enumeration
impact: Unauthenticated enumeration of org terms, org list, org existence via 404 vs 400 oracle; severity MEDIUM
testability: PASSIVE
[PARKED] api.sparelabs.com /v1/global/* route-level auth omission (fail-open): confidence 55 but class overlaps with accepted MISCONFIG on same asset; verify_steps only PROBE differential without data-bearing proof; dropping to avoid duplicate hypothesis on same root cause
[FINAL] 1. api.sparelabs.com CORS reflect-any-origin with credentials enables cross-origin authenticated requests (confidence 95)
[FINAL] 2. platform.sparelabs.com CSP + MFE manifest leaks accessible production admin apps alongside staging (confidence 85)
[FINAL] 3. api.sparelabs.com /v1/public/* endpoints return sensitive data despite 401 status code (confidence 85)
[NEXT] AUTH_HELPED: Obtain a valid session token/cookie for api.sparelabs.com (via authorized test account) and verify whether the reflected CORS with access-control-allow-credentials: true allows cross-origin authenticated requests to /v1/journeys or other auth-gated endpoints — i.e., does the victim's browser auto-attach credentials (cookie/Bearer) when attacker's page calls fetch('https://api.sparelabs.com/v1/journeys', {credentials: 'include'})?
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/**: CORS reflect-any-origin with credentials confirmed on OPTIONS preflight + GET responses for all /v1 endpoints (methods: GET,HEAD,PUT,PATCH,POST,DELETE; headers: Authorization)
[LEARN] ACCEPTED MISCONFIG @ platform.sparelabs.com: CSP + /login MFE manifest confirmed leaking production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-route-app.vercel.app) in addition to staging
[LEARN] ACCEPTED MISCONFIG @ api.sparelabs.com/v1/public/organization: UUID enumeration oracle confirmed (400 ValidationError for malformed, 404 NotFoundError for valid-but-unfound, 200 for valid org)
[LEARN] REJECTED MISCONFIG @ api.staging.sparelabs.com: staging API hosts return 404 behind envoy gateway, no independent API surface
[LEARN] REJECTED BUSLOGIC @ routing.sparelabs.com: all /v1/, /api/, /routing/, /router, /v2/, /graphql/, /map/, /directions/ paths return 404; envoy 404 on all paths, no surface — CONFIRMED dead
[RISK] api.sparelabs.com: 95 reason — Envoy edge gateway reflects any Origin with credentials on entire /v1 API; /v1/public/* endpoints return data despite 401; core API with high business value; critical CORS misconfig
[RISK] platform.sparelabs.com: 85 reason — MFE SPA shell leaks accessible staging AND production admin apps (Vercel, CORS *) and Metabase; auth-gated prod but staging inventory exposed and live
[RISK] routing.sparelabs.com: 40 reason — Envoy gateway returning 404; no discoverable routing API surface; low visible exposure
[RISK] forms.sparelabs.com: 50 reason — Public SPA on object store/CDN; JS bundle leaks staging infra (forms.staging.* live, api.staging.* 404, ngrok dead, JIRA OOS); IDOR risk only if shared /v1 API has cross-tenant flaws
[RISK] web (spare.com/sparelabs.com): 35 reason — Webflow marketing site behind Cloudflare; sparelabs.com 301→spare.com; static exposure only
