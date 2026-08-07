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
