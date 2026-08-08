# Validated Bugs

- 2026-08-07 ~18:00 UTC - SEED STATE: 0 valid bugs. Pipeline not yet run; hypotheses are recon-based and UNVALIDATED.

- 3 lead(s) marked VALID at 2026-08-07 19:25:39 UTC
  - **Verdict: HOLD** — Valid research direction but no evidence of additional unauthenticated endpoints beyond the 3 already accepted. Continue passive enumeration; escalate only if a new 2xx/500 route i
  - | Q2 Attacker-reachable? | **PARTIAL** — portal is public, but testing cross-tenant access requires ≥2 valid tokens (AUTH_HELPED). |
  - | **VALID** | 0 | — |

- 2 lead(s) marked VALID at 2026-08-07 22:00:40 UTC
  - VALID   3
  - | **VALID** | 3 | CORS reflect-any-origin+creds (7.5), data-on-401 (5.3), UUID org enumeration (5.3) |

- 1 lead(s) marked VALID at 2026-08-07 22:59:31 UTC
  - | **VALID** | 3 | CORS reflect-any-origin+creds on /v1, auth bypass /v1/global/organizations, UUID org enumeration oracle |

- 14 leads triaged at 2026-08-07 23:50 UTC — **CONSOLIDATED**
  - | **VALID** | 3 | CORS reflect-any-origin+creds (CVSS 5.3), route-level auth omission /v1/global/organizations (CVSS 5.3), UUID org enumeration oracle (CVSS 5.3) |
  - | **HOLD** | 2 | MFE-manifest XSS (sink trace needed), IDOR (test token needed) |
  - | **INVALID** | 9 | CSP/JS info disclosure (Q6), refuted object-store (Q4), dead routing (Q2), speculative SSRF (Q4), absent OpenAPI (Q2), correlationId leak (Q6), XFO variance (Q6), HSTS config (Q6) |
  - Reporting channel: Spare security channel (per scope.yml, TBD)

- 1 lead(s) marked VALID at 2026-08-07 23:52:55 UTC
  - | **VALID** | 3 | CORS reflect-any-origin+creds (CVSS 5.3), auth bypass /v1/global/organizations (CVSS 5.3), UUID org enumeration (CVSS 5.3) |

- 17 leads triaged at 2026-08-08 01:50 UTC — **UPDATED**
  - | **VALID** | 3 | CORS reflect-any-origin+creds (CVSS 5.3), organizations controller-wide auth omission (CVSS 5.3, UPDATED scope), UUID org enumeration oracle (CVSS 5.3) |
  - | **HOLD** | 4 | Write exposure on orgs controller (merged into Lead 2), MFE-manifest XSS (sink trace needed), IDOR (test token needed), org-settings host injection (parked, confidence 35) |
  - | **INVALID** | 10 | CSP/JS info disclosure (Q6), refuted object-store (Q4), dead routing (Q2), speculative SSRF (Q4), absent OpenAPI (Q2), correlationId leak (Q6), XFO variance (Q6), HSTS config (Q6) |
  - Key update: Lead 2 promoted from "route-level" to "controller-wide" auth omission; OPTIONS preflight proves write methods advertised without auth — escalation note added.
  - Reporting channel: Spare security channel (per scope.yml, TBD)

- 2 lead(s) marked VALID at 2026-08-08 02:27:02 UTC
  - | **VALID** | 3 | CORS reflect-any-origin+creds (CVSS 5.3), organizations controller auth omission (CVSS 5.3), UUID org enumeration (CVSS 5.3) |
  - | **VALID** | 3 | CORS reflect-any-origin+creds (CVSS 5.3), organizations controller auth omission (CVSS 5.3), UUID org enumeration (CVSS 5.3) |
