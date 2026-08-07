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
