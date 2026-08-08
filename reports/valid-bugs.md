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

- 3 lead(s) marked VALID at 2026-08-08 04:31:32 UTC
  - | Q5 Novel? | **NO** — already VALID since 01:50 UTC report |
  - **Verdict: Already VALID — reconfirmation only, no delta**
  - | **Already VALID** | 1 | Controller auth omission (reconfirmation, no delta) |

- 10 lead(s) marked VALID at 2026-08-08 08:06:31 UTC
  - **Verdict: ✅ VALID**
  - **Verdict: ✅ VALID**
  - | Q3 Impact | **LIMITED** — 400 ValidationError (malformed UUID) vs 404 NotFoundError (valid UUID not found) vs 200 (found). Enables UUID enumeration. But the model itself notes real org UUIDs are not
  - | Q7 Triager accept | **BORDERLINE** — acceptable as a MEDIUM info-disclosure / enumeration finding; many programs accept this as a low-end valid |
  - **Verdict: ✅ VALID (low)**
  - | Q2 Reachable | **PARTIAL** — route-level 401 guards confirmed; IDOR requires valid Bearer token |
  - | Q4 Proof passive | **NO** — requires AUTH_HELPED (valid test token); rules say no_account_creation without program approval |
  - | 1 | CORS reflect-any-origin + credentials on /v1/** | ✅ VALID | 8.1 High | Spare security |
  - | 2 | Auth-free data-bearing /v1/global (regions 725B) | ✅ VALID | 5.3 Medium | Spare security |
  - | 3 | UUID org enumeration oracle /v1/public/organization | ✅ VALID (low) | 5.3 Medium | Spare security |

- 3 lead(s) marked VALID at 2026-08-08 09:03:35 UTC
  - | 1 | CORS reflect-any-origin + credentials on /v1/** | ✅ VALID | 8.1 High | Spare security |
  - | 2 | Auth-free data-bearing /v1/global (regions 725B) | ✅ VALID | 5.3 Medium | Spare security |
  - | 3 | UUID org enumeration oracle /v1/public/organization | ✅ VALID (low) | 5.3 Medium | Spare security |

- 17 lead(s) marked VALID at 2026-08-08 11:47:09 UTC
  - | Q5 Novel | ❌ **Already VALID** since 01:50 UTC 2026-08-08 (CVSS 8.1 High). Reconfirmed 8+ times today. |
  - **Verdict: ✅ VALID (reconfirmation only — no delta)**
  - | Q5 Novel | ❌ **Already VALID** since 08:06 UTC 2026-08-08 (CVSS 5.3 Medium). Confirmed STABLE. |
  - **Verdict: ✅ VALID (reconfirmation — scheme characterization refined: middleware validates header scheme only, never token)**
  - | Q3 Impact | ✅ 400 ValidationError (malformed UUID) vs 404 NotFoundError (valid UUID not found) vs 200 (found) = reliable UUID enumeration oracle without auth |
  - | Q5 Novel | ❌ **Already VALID** since 01:50 UTC 2026-08-08 (CVSS 5.3). Reconfirmed. |
  - **Verdict: ✅ VALID (reconfirmation)**
  - | Q5 Novel | ❌ **Already VALID** since 22:59 UTC 2026-08-08 (CVSS 5.3) — controller-wide scope confirmed. |
  - **Verdict: ✅ VALID (reconfirmation — empty payload persists, no new data-bearing subroute found)**
  - | Q2 Reachable | ⚠️ Public SPA shell, but IDOR requires ≥2 valid tokens (cross-tenant test) |
  - | Q4 Passive proof | ❌ **Requires AUTH_HELPED.** Rules say `no_account_creation` without program approval. No valid test token available. ID params/UUID shape extracted from bundle but cross-tenant re
  - **Verdict: ✅ VALID (note on existing finding) — New parameter vector on already-accepted auth-free data disclosure. Append to Lead 2 report.**
  - | 1 | CORS reflect-any-origin+creds on /v1/** | ✅ VALID | Already accepted, reconfirmed STABLE |
  - | 2 | Auth-free data-bearing /v1/global/regions (scheme-only) | ✅ VALID | Already accepted, scheme characterized |
  - | 3 | UUID enumeration oracle /v1/public/organization | ✅ VALID | Already accepted, reconfirmed |
  - | 4 | /v1/global/organizations fail-open (empty payload) | ✅ VALID | Already accepted, persists |
  - | 17 | /v1/public/terms?mobileAppId= (new param) | ✅ VALID (note) | Variant of Lead 2; append to report |

- 26 leads triaged at 2026-08-08 13:13 UTC — **CONSOLIDATED**
  - | **VALID** | 5 | CORS reflect-any-origin+creds (CVSS 8.1), scheme-only auth bypass /v1/global/regions (CVSS 5.3), UUID enumeration oracle (CVSS 5.3), /v1/global/organizations fail-open (CVSS 5.3), /v1/public/terms parameter-vector disclosure (CVSS 5.3) |
  - | **HOLD** | 6 | Auth-free org-record read /v1/global/organizations/{id} (oracle confirmed, data needs AUTH_HELPED), write-method escalation on orgs controller (merged), superAdmin token-minting (speculative, 401-gated), rider PIN brute-force (needs test creds), Engage portal IDOR (needs AUTH_HELPED), org-settings host injection (parked, confidence 35) |
  - | **INVALID** | 15 | Email-reset chain (refuted, 401-gated), MFE-manifest XSS (sink scan negative), CSP/JS info disclosure (Q6), refuted object-store (Q4), dead routing (Q2), speculative SSRF (Q4), absent OpenAPI (Q2), correlationId leak (Q6), XFO variance (Q6), HSTS config (Q6), OOS subdomain (Q1), marketing site (Q3), reposcan (0 hits), empty seed files |
  - Key update: Lead 9 (email-reset ATO) REJECTED — live probe confirms 401-gated. Lead 10 (PIN brute-force) newly surfaced but needs test creds. Lead 6 (org-record read) new subroute on accepted controller — oracle confirmed, data needs AUTH_HELPED. No new reportable findings beyond the 5 already accepted.
  - Reporting channel: Spare security channel (per scope.yml, TBD)

- 1 lead(s) marked VALID at 2026-08-08 13:18:01 UTC
  - | **VALID** | 5 | CORS reflect-any-origin+creds (8.1), scheme-only bypass /v1/global/regions (5.3), UUID enumeration oracle (5.3), /v1/global/organizations fail-open (5.3), /v1/public/terms param-vect
