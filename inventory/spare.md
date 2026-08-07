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
