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
