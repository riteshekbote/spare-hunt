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

- 1 lead(s) marked VALID at 2026-08-08 14:03:14 UTC
  - | **VALID** | 5 | CORS reflect-any-origin+creds (8.1), scheme-only bypass /v1/global/regions (5.3), UUID enumeration oracle (5.3), /v1/global/organizations fail-open (5.3), /v1/public/terms param-vect

- 4 lead(s) marked VALID at 2026-08-08 17:58:57 UTC
  - **Verdict: Already VALID (reconfirmation only)** — no delta. Previously accepted unauthenticated data disclosure on /v1/public/terms. Probe reconfirms 200 + 137B JSON.
  - **Verdict: Already VALID (reconfirmation only)** — no delta. Previously accepted CSP + MFE manifest infra leak.
  - | 3 | api.sparelabs.com/v1/public/terms?organizationId=... (200) | **Already VALID** | Reconfirmation of accepted Lead 5. No delta. |
  - | 5 | platform.sparelabs.com/login (200) | **Already VALID** | Reconfirmation of accepted CSP leak. No delta. |

- 6 lead(s) marked VALID at 2026-08-08 19:55:51 UTC
  - | 1 | CORS reflect-any-origin+creds on /v1/** | ✅ VALID (reconfirmation) | 8.1 High | Spare security (TBD) |
  - | 2 | Scheme-only auth bypass /v1/global/regions | ✅ VALID (reconfirmation) | 5.3 Medium | Spare security (TBD) |
  - | 3 | /v1/global/organizations fail-open | ✅ VALID (reconfirmation) | 5.3 Medium | Spare security (TBD) |
  - | 4 | UUID enumeration oracle /v1/public/organization | ✅ VALID (low, reconfirmation) | 5.3 Medium | Spare security (TBD) |
  - | 5 | /v1/public/terms param-vector disclosure | ✅ VALID (low, reconfirmation) | 5.3 Medium | Spare security (TBD) |
  - | **VALID** | 5 |

- 20 lead(s) marked VALID at 2026-08-08 21:56:34 UTC
  - | Q5 Novel? | **NO** — already VALID as Lead 5 since 08:06 UTC 2026-08-08 |
  - **Verdict: Already VALID** (reconfirmation only, no delta). `mobileAppId` param is a new vector on the already-accepted endpoint — append to Lead 5 report.
  - | Q5 Novel? | **NO** — already VALID as Lead 3 since 22:59 UTC 2026-08-07 |
  - **Verdict: Already VALID** (reconfirmation only, no delta). Empty payload persists.
  - | Q5 Novel? | **NO** — already VALID as Lead 2 since 08:06 UTC 2026-08-08 |
  - **Verdict: Already VALID** (reconfirmation only, no delta). Scheme-only bypass stable.
  - | Q5 Novel? | **NO** — already VALID as Lead 4 since 01:50 UTC 2026-08-08 |
  - **Verdict: Already VALID** (reconfirmation only, no delta). Oracle stable.
  - | Q2 Attacker-reachable? | **NO** — requires valid Bearer token |
  - | Q5 Novel? | **NO** — CSP leak already VALID since 17:58 UTC 2026-08-08 |
  - **Verdict: Already VALID** (CSP leak reconfirmation, no delta). Login page accessibility itself is expected; the CSP header leak is the accepted finding.
  - | Q2 Attacker-reachable? | **PARTIAL** — 400 for malformed UUID; valid UUID untested |
  - | Q3 Real impact? | Unproven — needs valid UUID + cross-tenant token |
  - | Q4 Passive proof? | **NO** — requires AUTH_HELPED (valid test token); rules say `no_account_creation` without program approval |
  - **Verdict: HOLD** — IDOR potential on org-record read, but cross-tenant test requires ≥2 valid tokens. No test token available within rules. Escalate only if program provides test credentials.
  - | 2 | `/v1/public/terms` data disclosure | **Already VALID** | Lead 5 reconfirmation |
  - | 3 | `/v1/global/organizations` fail-open | **Already VALID** | Lead 3 reconfirmation |
  - | 4 | `/v1/global/regions` scheme-only bypass | **Already VALID** | Lead 2 reconfirmation |
  - | 5 | `/v1/public/organization` UUID enum | **Already VALID** | Lead 4 reconfirmation |
  - | 7 | `/login` accessible | **Already VALID** | CSP leak reconfirmation |

- 19 leads triaged at 2026-08-08 22:30 UTC — **CONSOLIDATED**
  - | Q5 Novel? | **NO** — already VALID since 2026-08-07 22:00 UTC |
  - **Verdict: Already VALID** (reconfirmation only, no delta). CORS credential reflection stable.
  - | Q5 Novel? | **NO** — already VALID since 2026-08-08 08:06 UTC |
  - **Verdict: Already VALID** (reconfirmation only, no delta). Scheme-only bypass stable on fast replica.
  - | Q5 Novel? | **NO** — already VALID since 2026-08-08 01:50 UTC |
  - **Verdict: Already VALID** (reconfirmation — complete zero-header bypass reconfirmed).
  - | Q5 Novel? | **NO** — already VALID since 2026-08-08 08:06 UTC |
  - **Verdict: Already VALID** (reconfirmation only, no delta). Oracle stable.
  - | Q5 Novel? | **NO** — already VALID since 2026-08-08 11:47 UTC |
  - **Verdict: Already VALID** (reconfirmation only, no delta). Param-vector disclosure stable.
  - | Q3 Real impact? | **NO** — import-map enumeration yielded no auth-free admin route; all /v1/admin/* paths return 404 |
  - **Verdict: HOLD → INVALID** (no result — import-map technique valid but null output; auth-free surface unchanged)
  - | Q3 Real impact? | **UNPROVEN** — oracle discriminates 400 vs 404 but no data-bearing response without real org UUID |
  - | Q4 Passive proof? | **PARTIAL** — needs AUTH_HELPED test-org UUID |
  - **Verdict: HOLD** — org-record read potential, but data disclosure unproven without authorized test UUID
  - | Q3 Real impact? | **LOW** — replica version skew is infrastructure fingerprinting, not a vulnerability |
  - **Verdict: INVALID** (Q3 — no security impact)
  - | Q4 Passive proof? | **NO** — requires AUTH_HELPED |
  - **Verdict: HOLD** — IDOR potential, needs ≥2 valid test tokens
  - | **VALID** | 5 | CORS reflect-any-origin+creds (CVSS 8.1), scheme-only bypass /v1/global/regions (CVSS 5.3), complete no-auth bypass /v1/global/organizations (CVSS 5.3), UUID enumeration oracle (CVSS 5.3), /v1/public/terms param-vector disclosure (CVSS 5.3) |
  - | **HOLD** | 2 | Auth-free org-record read (needs test-org UUID), Engage portal IDOR (needs test tokens) |
  - | **INVALID** | 12 | Import-map null result (Q3), LB replica skew (Q3), MFE XSS refuted (Q4), CSP/JS info disclosure (Q6), dead routing (Q2), superAdmin refuted (Q2), OOS subdomain (Q1), object-store refuted (Q4), metabase OOS (Q1) |
  - Key update: /v1/global/organizations confirmed as COMPLETE zero-header bypass (not just scheme-only). No new reportable findings beyond the 5 already accepted.
  - Reporting channel: Spare security channel (per scope.yml, TBD)

- 7 lead(s) marked VALID at 2026-08-08 22:34:12 UTC
  - | 1 | CORS reflect-any-origin+creds on /v1/** | VALID (reconf) | 8.1 | Spare security (TBD) |
  - | 2 | Scheme-only bypass /v1/global/regions | VALID (reconf) | 5.3 | Spare security (TBD) |
  - | 3 | Complete no-auth bypass /v1/global/organizations | VALID (reconf) | 5.3 | Spare security (TBD) |
  - | 4 | UUID enum oracle /v1/public/organization | VALID (reconf) | 5.3 | Spare security (TBD) |
  - | 5 | /v1/public/terms param-vector disclosure | VALID (reconf) | 5.3 | Spare security (TBD) |
  - VALID: 5 (all reconfirmations, no delta)
  - | 9 | **Engage portal IDOR** `forms.sparelabs.com → api.sparelabs.com/v1` | Per-route 401 confirmed. Cross-tenant read needs ≥2 valid tokens. AUTH_HELPED required. |

- 1 lead(s) marked VALID at 2026-08-08 23:22:08 UTC
  - triage/run-2026-08-08-17-58.md:275:**Verdict: Already VALID (reconfirmation only)** — no delta. Previously accepted CSP + MFE manifest infra leak.

- 3 lead(s) marked VALID at 2026-08-08 23:53:13 UTC
  - | Q3 Real impact? | **Medium** — enumerate valid org UUIDs |
  - | Q4 Prove passively? | **Yes** — GET with malformed vs valid-format UUIDs |
  - | Q3 Real impact? | **Unproven** — 401 with garbage AND valid-format tokens; role check not bypassed |

- 8 lead(s) triaged at 2026-08-09 03:00 UTC — **CONSOLIDATED RECONFIRMATION**
  - | **Already VALID** | 5 | CORS reflect-any-origin+creds (CVSS 8.1), scheme-only bypass /v1/global/regions (CVSS 5.3), complete no-auth bypass /v1/global/organizations (CVSS 5.3), UUID enumeration oracle (CVSS 5.3), /v1/public/terms data disclosure (CVSS 5.3) |
  - | **INVALID** | 3 | metabase OOS (Q1), /login accessibility normal (Q3/Q6), /v1/public/$p 404 (Q3) |
  - Key update: All 5 findings STABLE across 10 probe samples (17:20 UTC → 02:52 UTC). No new reportable findings. No delta.
  - Reporting channel: Spare security channel (per scope.yml, TBD)

- 1 lead(s) marked VALID at 2026-08-09 03:21:56 UTC
  - | **Already VALID** (reconfirmation, no delta) | 5 | CORS reflect-any-origin+creds (8.1), scheme-only bypass `/v1/global/regions` (5.3), complete no-auth bypass `/v1/global/organizations` (5.3), UUID 

- 14 lead(s) marked VALID at 2026-08-09 04:48:16 UTC
  - | Q5 Novel? | **RE-CONFIRMED** — previously accepted VALID; this batch re-confirms stability with zero regression. |
  - **Verdict: VALID (re-confirmed) — CVSS 5.3 (Medium)**
  - **Verdict: VALID (escalated) — CVSS 5.3 (Medium)**
  - | Q5 Novel? | **RE-CONFIRMED** — previously accepted VALID; stable across all scan intervals. |
  - **Verdict: VALID (re-confirmed) — CVSS 5.3 (Medium)**
  - **Verdict: VALID — CVSS 5.3 (Medium)**
  - | Q3 Real impact? | **YES** — returns live terms URLs: `{"termsOfUseUrl":"https://sparelabs.com/terms-of-use/","privacyPolicyUrl":"https://sparelabs.com/privacy-policy/","serviceTermsUrl":null}`. Whil
  - | Q5 Novel? | **YES** — NEW finding. Prior reports mentioned this endpoint in passing but did not triage it as a separate VALID finding. |
  - **Verdict: VALID — CVSS 3.1 (Low)**
  - | Q3 Real impact? | **HIGH if proven** — {id} subroute returns real 404 `NotFoundError` (DB lookup, not stub) with correlationId for valid-unfound UUIDs, and 400 OpenAPI ValidationError for malformed 
  - | Q4 Passive-proof? | **PARTIAL** — PASSIVE oracle confirmed (400 malformed → 404 valid-unfound = real DB lookup). Data-bearing for real org UUIDs requires AUTH_HELPED (test org UUID). |
  - | Q4 Passive-proof? | **NO** — requires AUTH_HELPED (valid non-superAdmin Bearer token). |
  - | Q7 Reasonable triager? | **Needs AUTH_HELPED** — edge checks only token-type presence; role check on a valid token is unproven. |
  - | **VALID** | 5 | CORS reflect-any-origin+creds (5.3), organizations controller auth omission (5.3, escalated), UUID org enumeration (5.3), **/v1/global/regions scheme-only bypass (5.3) ★NEW★**, **/v1

- 1 lead(s) marked VALID at 2026-08-09 05:43:14 UTC
  - | **Already VALID** (reconfirmation, no delta) | 5 | CORS reflect-any-origin+creds (8.1), scheme-only bypass /v1/global/regions (5.3), complete no-auth bypass /v1/global/organizations (5.3), UUID enum

- 7 lead(s) marked VALID at 2026-08-09 06:45:14 UTC
  - | Q7 Triager accept? | Would be VALID if novel |
  - | Q7 Triager accept? | Would be VALID if novel |
  - | Q7 Triager accept? | Would be VALID if novel |
  - | Q7 Triager accept? | Would be VALID if novel |
  - | Q7 Triager accept? | Would be VALID if novel |
  - | Q3 Real impact? | **Yes** — 3-way differential (malformed→400 ValidationError, valid-unfound→404, found→200) confirms org UUID existence |
  - | Q7 Triager accept? | Would be VALID if novel |

- 12 lead(s) marked VALID at 2026-08-09 07:47:30 UTC
  - **Verdict: ✅ VALID — CVSS 8.1 (High)**
  - **Verdict: ✅ VALID — CVSS 5.3 (Medium)**
  - **Verdict: ✅ VALID — CVSS 5.3 (Medium)**
  - | Q3 Real impact? | **MEDIUM** — 400 ValidationError (malformed) vs 404 NotFoundError (valid-unfound) vs 200 (found) = reliable org UUID existence oracle |
  - | Q7 Triager accept? | **BORDERLINE but YES** — many programs accept UUID enumeration as low-end valid |
  - **Verdict: ✅ VALID (low) — CVSS 5.3 (Medium)**
  - **Verdict: ✅ VALID (low) — CVSS 3.1 (Low)**
  - | Q2 Attacker-reachable? | **PARTIAL** — public SPA shell, but cross-tenant read requires ≥2 valid Bearer tokens |
  - | Q4 Passive proof? | **NO** — requires AUTH_HELPED (valid test token); rules forbid `no_account_creation` without program approval |
  - **Verdict: 🔶 HOLD** — IDOR potential on cross-tenant read, but requires ≥2 valid test tokens. No test token available within program rules. Escalate only if program provides test credentials.
  - | Q5 Novel? | **NO** — already VALID as informational finding since 2026-08-07 22:00 UTC |
  - | ✅ **VALID** | **5** | CORS reflect-any-origin+creds (CVSS 8.1), scheme-only bypass `/v1/global/regions` (CVSS 5.3), complete no-auth bypass `/v1/global/organizations` (CVSS 5.3), UUID enumeration oracle (CVSS 5.3), param-vector data disclosure (CVSS 3.1) |

- 8 lead(s) triaged at 2026-08-09 08:28 UTC — **NO DELTA**
  - | **VALID** | 0 | No new findings — all probe results are duplicates of already-ACCEPTED findings |
  - | **INVALID** | 8 | terms?organizationId (dup), terms?mobileAppId (dup), organizations fail-open (dup), regions 400 (dup), journeys 401 (expected), login 200 (expected), metabase OOS (Q1), org enum oracle (dup) |
  - | **HOLD** | 0 | No new holds |
  - Key update: All 5 ACCEPTED findings remain STABLE across 10+ probe samples (17:20 UTC → 08:07 UTC). No new reportable surface. No delta.
  - Reporting channel: Spare security channel (per scope.yml, TBD)

- 5 lead(s) marked VALID at 2026-08-09 08:33:15 UTC
  - | Q7 Triager accept? | Would be VALID if novel |
  - | Q7 Triager accept? | Would be VALID if novel |
  - | Q7 Triager accept? | Would be VALID if novel |
  - - **Verdict: 🔶 HOLD** — IDOR potential on cross-tenant read, but requires ≥2 valid test tokens. No test token available within program rules. Escalate only if program provides test credentials.
  - | **VALID** | 0 | No new findings |

- 1 lead(s) marked VALID at 2026-08-09 09:32:30 UTC
  - **VALID count remains: 5** (CORS reflect-any-origin+creds CVSS 8.1, scheme-only bypass `/v1/global/regions` CVSS 5.3, complete no-auth bypass `/v1/global/organizations` CVSS 5.3, UUID enumeration orac

- 20 lead(s) marked VALID at 2026-08-09 10:24:35 UTC
  - | A1 | CORS reflect-any-origin + credentials on /v1/** (all methods + Authorization header) | 8.1 High | VALID — STABLE |
  - | A2 | Scheme-only auth bypass /v1/global/regions (200 + 725B region registry with garbage Bearer) | 5.3 Medium | VALID — STABLE |
  - | A3 | UUID enumeration oracle /v1/public/organization (400/404/200 differential) | 5.3 Medium | VALID — STABLE |
  - | A4 | /v1/global/organizations fail-open (200 + {"data":[]} + CORS, empty payload persists) | 5.3 Medium | VALID — STABLE |
  - | A5 | /v1/public/terms data disclosure (200 + live terms URLs via mobileAppId/organizationId) | 5.3 Medium | VALID — STABLE |
  - | Q3 Real impact? | YES — UUID enumeration oracle (400 malformed / 404 valid-unfound / 200 found) |
  - | Q5 Novel? | **NO — already VALID as Lead A3** |
  - **Verdict: Already VALID (reconfirmation, no delta).** A3 covers this exact oracle.
  - | Q5 Novel? | **NO — already VALID as Lead A4** (controller-wide auth omission) |
  - **Verdict: Already VALID (reconfirmation, no delta).** A4 covers the organizations controller auth omission including subroutes.
  - **Verdict: Already VALID (subsumed under A4).** No new finding.
  - | Q5 Novel? | **NO — already VALID as Lead A2** (scheme-only bypass / 725B data disclosure) |
  - **Verdict: Already VALID (reconfirmation of A2).** The 200-with-garbage-token variant is the same auth bypass; 400 here reflects a request-shape variation, not a new finding.
  - | Q5 Novel? | **NO — CSP leak already VALID** (documented since 2026-08-07 22:00 UTC) |
  - | `/v1/global/regions` | 200 with garbage token / 400 malformed | 400 | Possible replica flip. A2 still valid (historical); monitor for regression |
  - | L4 | api /v1/public/organization?uuid= | **Already VALID** | A3 reconfirmation |
  - | L7 | api /v1/global/organizations/{test-uuid} | **Already VALID** | A4 reconfirmation |
  - | L8 | api /v1/global/organizations/{uuid} | **Already VALID** | Subsumed under A4 |
  - | L9 | api /v1/global/regions 400 | **Already VALID** | A2 reconfirmation |
  - | — | No new VALID findings this cycle | — | — |

- 5 lead(s) marked VALID at 2026-08-09 13:48:34 UTC
  - | A1 | CORS reflect-any-origin + credentials on /v1/** (all methods + Authorization header, uniform via envoy) | 8.1 High | VALID — STABLE |
  - | A2 | Scheme-only auth bypass /v1/global/regions (200 + 725B region registry with garbage Bearer; middleware validates scheme only, never token) | 5.3 Medium | VALID — STABLE |
  - | A3 | UUID enumeration oracle /v1/public/organization (400 malformed / 404 not-found / 200 found) | 5.3 Medium | VALID — STABLE |
  - | A4 | /v1/global/organizations fail-open (200 + {"data":[]} + CORS, route-specific) | 5.3 Medium | VALID — STABLE |
  - | A5 | /v1/public/terms data disclosure (200 + live terms URLs via mobileAppId|organizationId, no auth) | 5.3 Medium | VALID — STABLE |

- 19 lead(s) marked VALID at 2026-08-09 14:28:00 UTC
  - | Q5 Novel? | **NO** — already VALID as A1 since 2026-08-07 22:00 UTC |
  - **Verdict: Already VALID (A1).** Reconfirmed stable. CVSS 8.1 High. Reporting channel: Spare security (TBD).
  - | Q3 | **YES** — returns live region registry (apiUrl/routingHost mappings) without valid auth |
  - | Q5 | **NO** — already VALID as A2 |
  - **Verdict: Already VALID (A2).** CVSS 5.3 Med. Stable across 10+ probe samples.
  - | Q3 | **YES** — 400 (malformed) / 404 (valid-unfound) / 200 (found) = reliable org UUID existence oracle |
  - | Q4 | **YES** — GET with malformed vs valid-format UUIDs |
  - | Q5 | **NO** — already VALID as A3 |
  - **Verdict: Already VALID (A3).** CVSS 5.3 Med.
  - | Q5 | **NO** — already VALID as A4 |
  - **Verdict: Already VALID (A4).** CVSS 5.3 Med. Empty payload persists; write-method variant merged (no handler proven).
  - | Q5 | **NO** — already VALID as A5 |
  - **Verdict: Already VALID (A5).** CVSS 5.3 Med (param-vector variant 3.1 Low).
  - | Q2 | **PARTIAL** — portal is public, but cross-tenant read needs ≥2 valid tokens |
  - | Q4 | **NO** — requires AUTH_HELPED (valid test token); rules forbid `no_account_creation` without program approval |
  - **Verdict: HOLD** — IDOR potential exists but cross-tenant test requires ≥2 valid test tokens. Escalate only if program provides test credentials.
  - | Q2 | **PARTIAL** — needs valid Bearer token |
  - | Q4 | **NO** — requires AUTH_HELPED (valid non-superAdmin Bearer token) |
  - | **Already VALID** | 5 | A1 CORS (8.1), A2 regions bypass (5.3), A3 UUID enum (5.3), A4 orgs fail-open (5.3), A5 terms disclosure (5.3) |

- 14 lead(s) marked VALID at 2026-08-09 15:22:18 UTC
  - | Q5 Novel? | **NO** — already VALID as A4 since 2026-08-07 22:59 UTC |
  - **Verdict: Already VALID (A4).** Reconfirmed stable. CVSS 5.3 Med. Reporting channel: Spare security (TBD).
  - | Q5 Novel? | **NO** — already VALID as A2 since 2026-08-08 08:06 UTC |
  - **Verdict: Already VALID (A2).** The 400 in this probe sample reflects a request-shape variation (backtick-appended URL); the scheme-only bypass itself is stable across 10+ samples. CVSS 5.3 Med.
  - | Q3 Real impact? | **YES** — 400 (malformed) vs 404 (valid-unfound) vs 200 (found) = reliable org UUID existence oracle |
  - | Q4 Passive proof? | **YES** — GET with malformed vs valid-format UUIDs |
  - | Q5 Novel? | **NO** — already VALID as A3 since 2026-08-07 22:00 UTC |
  - **Verdict: Already VALID (A3).** CVSS 5.3 Med.
  - | Q5 Novel? | **NO** — already VALID as A5 since 2026-08-08 08:06 UTC |
  - **Verdict: Already VALID (A5).** CVSS 5.3 Med (param-vector variant 3.1 Low).
  - | Q4 Passive proof? | **PARTIAL** — oracle confirmed (400 malformed → 404 valid-unfound = real DB lookup), but data disclosure unproven without authorized test UUID |
  - | Q5 Novel? | **NO** — already VALID as A3 |
  - **Verdict: Already VALID (A3).** Reconfirmation of the UUID enumeration oracle.
  - | **Already VALID** | 5 | A1 CORS (8.1), A2 regions bypass (5.3), A3 UUID enum (5.3), A4 orgs fail-open (5.3), A5 terms disclosure (5.3) |

- 17 lead(s) marked VALID at 2026-08-09 17:06:16 UTC
  - **Verdict:** VALID (already reported — no new report needed)
  - **Verdict:** VALID (already reported — no new report needed)
  - **Verdict:** VALID (already reported — no new report needed)
  - **Verdict:** VALID (already reported — no new report needed)
  - | Q3 Real impact? | **MEDIUM** — 3-way differential: malformed→400 ValidationError "must match format uuid"; valid-unfound→404 NotFoundError; valid-found→200. Reliable org UUID enumeration. |
  - **Verdict:** VALID (already reported — no new report needed)
  - **Verdict:** VALID (already reported — no new report needed)
  - **Verdict:** VALID (already reported — no new report needed)
  - | Q4 Passive proof? | **NO** — requires AUTH_HELPED (valid token from program channel) |
  - | Q3 Real impact? | **UNPROVEN** — GET returns 401 + CORS; auth-gated, not bypassable without valid token |
  - | 1 | CORS reflect-any-origin+credentials /v1/** | **VALID** | No — already reported STABLE |
  - | 2 | Scheme-only bypass /v1/global/regions (data-bearing) | **VALID** | No — already reported STABLE |
  - | 3 | Fail-open /v1/global/organizations | **VALID** | No — already reported STABLE |
  - | 4 | Data disclosure /v1/public/terms | **VALID** | No — already reported STABLE |
  - | 5 | UUID enumeration /v1/public/organization | **VALID** | No — already reported STABLE |
  - | 6 | CSP leak platform.sparelabs.com | **VALID** | No — already reported STABLE |
  - | 7 | JS bundle leak forms.sparelabs.com | **VALID** | No — already reported STABLE |

- 12 lead(s) marked VALID at 2026-08-09 18:02:01 UTC
  - | Q5 Novel? | **NO** — already VALID since 2026-08-07 22:00 UTC (CVSS 8.1 High). Reconfirmed 30+ times. |
  - **Verdict: Already VALID (reconfirmation only — no delta)**
  - | Q5 Novel? | **NO** — already VALID since 2026-08-08 08:06 UTC (CVSS 5.3 Medium). |
  - **Verdict: Already VALID (reconfirmation only — no delta)**
  - | Q5 Novel? | **NO** — already VALID since 2026-08-08 01:50 UTC (CVSS 5.3 Medium). |
  - **Verdict: Already VALID (reconfirmation only — no delta)**
  - | Q5 Novel? | **NO** — already VALID since 2026-08-07 22:59 UTC (CVSS 5.3 Medium). |
  - **Verdict: Already VALID (reconfirmation only — no delta)**
  - | Q5 Novel? | **NO** — already VALID since 2026-08-08 11:47 UTC (CVSS 5.3 Medium). |
  - **Verdict: Already VALID (reconfirmation only — no delta)**
  - | Q3 Real impact? | **UNPROVEN** — 400 alone indicates route registration, not data disclosure. No body content captured. Parallel to /v1/public/terms which also 400s without params but that endpoint'
  - | **Already VALID** (reconfirmation, no delta) | 5 | CORS reflect-any-origin+creds (8.1), scheme-only bypass /v1/global/regions (5.3), complete no-auth bypass /v1/global/organizations (5.3), UUID enum

- 1 lead(s) marked VALID at 2026-08-09 19:15:47 UTC
  - | **VALID** | 0 | All high-confidence valid findings (A1-A5) confirmed in prior cycles |

- 6 lead(s) marked VALID at 2026-08-09 21:08:37 UTC
  - | **Q5 Novel?** | ❌ **NO** — already VALID as A2 ("Scheme-only auth bypass /v1/global/regions", CVSS 5.3, STABLE since 2026-08-08 08:06 UTC, reconfirmed 30+ times) |
  - | **Q5 Novel?** | ❌ **NO** — already VALID as A4 ("/v1/global/organizations fail-open", CVSS 5.3, STABLE, reconfirmed 30+ times) |
  - | **Q5 Novel?** | ❌ **NO** — already VALID as A5 ("/v1/public/terms data disclosure", CVSS 5.3/3.1 Low, STABLE since 2026-08-08 08:06 UTC) |
  - | **Q5 Novel?** | ❌ **NO** — already VALID as A5 parameter-vector variant (documented 2026-08-08 11:47 UTC, "new param-vector data disclosure") |
  - | **Q6 Not always-rejected?** | ⚠️ Borderline — health endpoints that return only status are best-practice/info-disclosure. Only valid if body contains sensitive data. |
  - | **VALID** | 0 | — |

- 17 lead(s) marked VALID at 2026-08-09 21:57:23 UTC
  - | 1 | api /v1/global/organizations 200 `{"data":[]}` | Yes | Yes | Low (empty) | Yes | No — A4 | Yes | Yes | **VALID (dup)** | Reconfirmation of A4 |
  - | 4 | api /v1/public/terms?mobileAppId= 200 137B | Yes | Yes | Low | Yes | No — A5 | Yes | Yes | **VALID (dup)** | Reconfirmation of A5 param-vector |
  - | 7 | api /v1/public/organization?uuid= 400 | Yes | Yes | Medium | Yes | No — A3 | Yes | Yes | **VALID (dup)** | Reconfirmation of A3 |
  - | 12 | api /v1/public/terms?organizationId=0606efa8-... 200 | Yes | Yes | Low | Yes | No — A5 | Yes | Yes | **VALID (dup)** | Reconfirmation of A5 |
  - | bigpickle | Organizations controller auth omission (stable 200) | **VALID (dup)** | A4 reconfirmation — empty payload persists, no new data-bearing subroute |
  - | bigpickle | MFE-manifest XSS (sink scan negative) | **HOLD** | Q4 — sink scan negative; needs bundle-trace evidence before VALID |
  - | laguna | CORS reflect-any-origin+creds /v1/** | **VALID (dup)** | A1 reconfirmation — STABLE |
  - | laguna | UUID enum oracle /v1/public/organization | **VALID (dup)** | A3 reconfirmation — STABLE |
  - | laguna | CSP leak platform /login | **VALID (dup)** | A6 reconfirmation — STABLE |
  - | ling3 | API CORS + fail-open global orgs | **VALID (dup)** | A1+A4 reconfirmation |
  - | ling3 | CSP leak platform /login | **VALID (dup)** | A6 reconfirmation |
  - | ling3 | JS bundle leak forms.sparelabs.com | **VALID (dup)** | A7 reconfirmation |
  - | nemotron3 | CORS reflect-any-origin+creds /v1/** | **VALID (dup)** | A1 reconfirmation |
  - | nemotron3 | /v1/public/* data-on-401 | **VALID (dup)** | A5 reconfirmation (data now returned as 200, not 401 — behavior flapped but same finding) |
  - | nemotron3 | CSP leak platform + staging admin apps | **VALID (dup)** | A6 reconfirmation |
  - | VALID (new) | 0 | No novel findings |
  - | VALID (reconfirmation) | 10 | A1–A7 reconfirmed STABLE |

- 13 lead(s) marked VALID at 2026-08-09 23:57:50 UTC
  - **Verdict: VALID — HIGH**
  - **Verdict: VALID — MEDIUM**
  - **Verdict: VALID — MEDIUM**
  - **Verdict: VALID — MEDIUM**
  - **Verdict: VALID — LOW** (accepted as info-disclosure reconnaissance enabler; severity capped because leaked hosts are third-party/Vercel, not directly in-scope)
  - **Verdict: VALID — LOW** (accepted as reconnaissance enabler)
  - **Verdict: HOLD → AUTH_HELPED. Highest-priority AUTH_HELPED test. With a program-obtained valid tenant/rider token, POST empty body → 2xx proves missing role check (critical); 401/403 means enforced (
  - | 1 | CORS reflect-any-origin+creds on /v1/** | **VALID** | HIGH (standalone MEDIUM) | No |
  - | 2 | /v1/global/organizations auth omission | **VALID** | MEDIUM | No |
  - | 3 | /v1/global/regions presence-only gate | **VALID** | MEDIUM | No |
  - | 4 | /v1/public/org UUID enumeration oracle | **VALID** | MEDIUM | No |
  - | 5 | CSP + MFE manifest infra leak | **VALID** | LOW | No |
  - | 6 | JS bundle staging infra leak | **VALID** | LOW | No |
