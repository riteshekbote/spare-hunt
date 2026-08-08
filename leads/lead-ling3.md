# LEADS ling3 (seed)
- SEED: no model output yet; pipeline starts on first run.
## 2026-08-07 18:28:57 UTC [forms] (model ling3)
## 2026-08-07 18:46:46 UTC [forms] (model ling3)
## 2026-08-07 19:11:59 UTC [forms] (model ling3)
## 2026-08-07 20:00:25 UTC [forms] (model ling3)
## 2026-08-07 20:53:03 UTC [forms] (model ling3)
## 2026-08-07 21:29:22 UTC [forms] (model ling3)
## 2026-08-07 22:06:53 UTC [forms] (model ling3)
## 2026-08-07 22:51:34 UTC [forms] (model ling3)
## 2026-08-07 23:25:21 UTC [forms] (model ling3)
## 2026-08-07 23:55:39 UTC [forms] (model ling3)
## 2026-08-08 00:59:54 UTC [forms] (model ling3)
## 2026-08-08 02:55:52 UTC [forms] (model ling3)
## 2026-08-08 04:06:47 UTC [forms] (model ling3)
## 2026-08-08 05:07:32 UTC [forms] (model ling3)
## 2026-08-08 05:53:08 UTC [forms] (model ling3)
## 2026-08-08 06:35:21 UTC [forms] (model ling3)
## 2026-08-08 07:32:28 UTC [forms] (model ling3)
## 2026-08-08 08:10:02 UTC [forms] (model ling3)
## 2026-08-08 08:57:39 UTC [forms] (model ling3)
## 2026-08-08 09:34:15 UTC [forms] (model ling3)
## 2026-08-08 10:05:05 UTC [forms] (model ling3)
## 2026-08-08 10:45:35 UTC [forms] (model ling3)
## 2026-08-08 11:11:33 UTC [forms] (model ling3)
## 2026-08-08 11:44:43 UTC [forms] (model ling3)
## 2026-08-08 12:03:17 UTC [forms] (model ling3)
## 2026-08-08 13:07:34 UTC [forms] (model ling3)
## 2026-08-08 13:53:32 UTC [forms] (model ling3)
## 2026-08-08 14:23:12 UTC [forms] (model ling3)
## 2026-08-08 14:56:00 UTC [forms] (model ling3)
## 2026-08-08 15:21:51 UTC [forms] (model ling3)
## 2026-08-08 15:54:00 UTC [forms] (model ling3)
## 2026-08-08 16:21:06 UTC [forms] (model ling3)
## 2026-08-08 17:20:04 UTC [forms] (model ling3)
## 2026-08-08 17:40:59 UTC [forms] (model ling3)
## 2026-08-08 18:04:35 UTC [forms] (model ling3)
[PRIO] api.sparelabs.com/v1/**, score 8, axis: attack_surface=9, business_value=9, tech_exposure=8, gate_ease=7, cloud_surface=7, freshness=10
[PRIO] platform.sparelabs.com/login, score 6, axis: attack_surface=6, business_value=7, tech_exposure=6, gate_ease=9, cloud_surface=4, freshness=5
[PRIO] forms.sparelabs.com, score 6, axis: attack_surface=5, business_value=6, tech_exposure=7, gate_ease=7, cloud_surface=5, freshness=8
[PRIO] routing.sparelabs.com, score 0, axis: attack_surface=1, business_value=0, tech_exposure=0, gate_ease=1, cloud_surface=0, freshness=0
[PRIO] spare.com/sparelabs.com, score 2, axis: attack_surface=2, business_value=2, tech_exposure=2, gate_ease=3, cloud_surface=2, freshness=2
[HYP] API CORS credential reflection with fail-open global organizations endpoint
class: MISCONFIG
asset: api.sparelabs.com/v1/**
confidence: 95
reasoning: CORS reflect-any-origin with credentials confirmed on all /v1 endpoints; global/organizations returns 200 with {"data":[]} without auth, allowing unauthenticated read access to 11B JSON payload
evidence_needed: Live OPTIONS 204 response with ACAO:https://evil.example.com + ACAC:true + methods GET/HEAD/PUT/PATCH/POST/DELETE + Authorization on OPTIONS 204; GET on /v1/global/organizations returning 200 + {"data":[]}
verify_steps: OPTIONS https://api.sparelabs.com/v1/global/organizations; GET https://api.sparelabs.com/v1/global/organizations; OPTIONS https://api.sparelabs.com/v1/public/terms; GET https://api.sparelabs.com/v1/public/terms
impact: Unauthenticated read access to 11B JSON payload; potential read→write escalation via CORS credential reflection
testability: PASSIVE
[HYP] CSP + /login prefetch script leaking production admin Vercel apps
class: MISCONFIG
asset: platform.sparelabs.com/login
confidence: 95
reasoning: CSP header and /login prefetch script confirmed leaking production admin Vercel apps (admin-eam-app.vercel.app, admin-fixed-route-app.vercel.app) plus staging variants and Metabase
evidence_needed: CSP header analysis showing production admin host URLs; /login prefetch script enumeration of Vercel and other infra hosts
verify_steps: GET https://platform.sparelabs.com/login; CSP header analysis on platform.sparelabs.com
impact: Production admin apps exposed via CSP; potential unauthorized access to admin panel
testability: PASSIVE
[HYP] JS bundle leaking staging+prod infra and authentication surface
class: MISCONFIG
asset: forms.sparelabs.com
confidence: 85
reasoning: JS bundle main.71d52314.js confirmed leaking api.staging.sparelabs.com, api.staging.us.sparelabs.com, forms.staging.sparelabs.com, forms.staging.us.sparelabs.com, api.us.sparelabs.com, atlassian.net, and ngrok.io
evidence_needed: JavaScript bundle analysis confirming leaked API endpoints and infrastructure URLs
verify_steps: Passive retrieval of forms.sparelabs.com main.71d52314.js bundle; cross-reference leaked URLs against known infrastructure
impact: Unauthenticated access to internal API endpoints; potential data exposure via leaked credentials
testability: PASSIVE
## 2026-08-08 18:54:25 UTC [forms] (model ling3)
## 2026-08-08 19:27:29 UTC [forms] (model ling3)
## 2026-08-08 19:56:00 UTC [forms] (model ling3)
## 2026-08-08 20:32:38 UTC [forms] (model ling3)
## 2026-08-08 21:02:41 UTC [forms] (model ling3)
## 2026-08-08 21:41:04 UTC [forms] (model ling3)
## 2026-08-08 22:03:25 UTC [forms] (model ling3)
## 2026-08-08 22:42:56 UTC [forms] (model ling3)
## 2026-08-08 23:11:30 UTC [forms] (model ling3)
