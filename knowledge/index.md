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
