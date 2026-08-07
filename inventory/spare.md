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
