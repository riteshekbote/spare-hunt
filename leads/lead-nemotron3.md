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
