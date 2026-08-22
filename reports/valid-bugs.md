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

- 17 lead(s) marked VALID at 2026-08-10 02:44:12 UTC
  - valid UUID → 200. 3-way differential confirms org UUID existence.
  - VERDICT: VALID (dup) — A1 reconfirmation, no delta
  - VERDICT: VALID (dup) — A4 reconfirmation, empty payload persists
  - VERDICT: VALID (dup) — A1 reconfirmation
  - VERDICT: VALID (dup) — A3 reconfirmation
  - VERDICT: VALID (dup) — A6 reconfirmation
  - VERDICT: VALID (dup) — A5 reconfirmation
  - VERDICT: VALID (dup) — A1-A5 reconfirmation
  - VERDICT: VALID (dup) — A6 reconfirmation
  - VERDICT: VALID (dup) — A7 reconfirmation
  - VERDICT: VALID (dup) — A1 + A4 reconfirmation
  - VERDICT: VALID (dup) — A6 reconfirmation
  - VERDICT: VALID (dup) — A7 reconfirmation
  - VALID (new):     0
  - VALID (dup):    ~30 (all map to A1–A7)
  - | VALID (new) | 0 | No novel findings |
  - | VALID (dup) | ~30 | All reconfirm A1–A7 |

- 14 lead(s) marked VALID at 2026-08-10 04:24:48 UTC
  - | Q7 Triager accept? | **YES** — valid CORS misconfig (OWASP A05:2021) |
  - | Q3 Real impact? | **YES** — full region registry (apiUrl/routingHost mappings, 6 OOS hosts) leaked without valid auth |
  - | Q3 Real impact? | **MEDIUM** — 3-way differential (400 malformed / 404 valid-unfound / 200 found) confirms org UUID existence |
  - | Q4 Passive proof? | **YES** — GET with malformed vs valid-format UUIDs |
  - | Q7 Triager accept? | **YES** (low-end valid) |
  - | Q2 Attacker-reachable? | **PARTIAL** — portal public, cross-tenant test needs ≥2 valid tokens |
  - | Q4 Passive proof? | **NO** — requires AUTH_HELPED (valid test token); rules forbid `no_account_creation` without program approval |
  - | Q6 Not rejected? | **YES** — IDOR is valid class |
  - **Verdict: HOLD** — Q4 — cross-tenant IDOR test requires ≥2 valid Bearer tokens; no test token available within program rules. Escalate only if program provides test credentials.
  - | Q2 Attacker-reachable? | **PARTIAL** — path live, 401-gated; needs valid token to test role check |
  - | Q4 Passive proof? | **NO** — requires AUTH_HELPED (valid non-superAdmin Bearer) |
  - | Q7 Triager accept? | **Needs AUTH_HELPED** — edge checks token-type presence only; role check on valid token unproven |
  - **Verdict: HOLD** — Q4 — highest-priority AUTH_HELPED test. With a program-obtained valid tenant/rider token, POST empty body → 2xx proves missing role check (critical); 401/403 means enforced. No tes
  - | **VALID (new)** | **0** | No novel findings this cycle |

- 11 lead(s) marked VALID at 2026-08-10 06:00:07 UTC
  - | A1 | CORS reflect-any-origin + credentials on entire /v1/** (all methods + Authorization header, uniform envoy middleware) | 8.1 High (AV:N/AC:L/PR:N/UI:R/S:U/C:H/I:H/A:N) | VALID — STABLE 72h+ |
  - | A2 | Scheme-only auth bypass /v1/global/regions (200 + 725B region registry with garbage Bearer; middleware validates scheme only, never token) | 5.3 Medium (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | V
  - | A3 | UUID enumeration oracle /v1/public/organization (400 malformed / 404 not-found / 200 found) | 5.3 Medium (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE |
  - | A4 | /v1/global/organizations fail-open (200 + {"data":[]} + CORS, route-specific, zero-header) | 5.3 Medium (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE (intermittent 400 from LB flapping
  - | A5 | /v1/public/terms data disclosure (200 + live terms URLs via mobileAppId/organizationId, no auth + CORS) | 5.3 Medium (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE |
  - | A6 | CSP + MFE manifest infra leak platform.sparelabs.com/login (prod+staging admin Vercel apps + Metabase + full cloud infra) | 3.1 Low (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE |
  - | A7 | JS bundle staging infra leak forms.sparelabs.com (main.71d52314.js — staging+prod+regional + atlassian + inactive ngrok) | 3.1 Low (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE |
  - **Verdict: Already VALID (reconfirmation only — no delta).** No new report needed.
  - | L6: Laguna reconfirmation batch | **Already VALID** | Maps to A1-A5, no delta |
  - **VALID (new):** 0
  - **VALID (reconfirmation):** 7 (A1-A7)

- 7 lead(s) marked VALID at 2026-08-10 08:15:47 UTC
  - | A1 | CORS reflect-any-origin + credentials on entire /v1/** (all methods + Authorization header, uniform envoy middleware) | 8.1 High (AV:N/AC:L/PR:N/UI:R/S:U/C:H/I:H/A:N) | VALID — STABLE 84h+ |
  - | A2 | Scheme-only auth bypass /v1/global/regions (200 + 725B region registry with garbage Bearer; middleware validates scheme only, never token) | 5.3 Medium (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | V
  - | A3 | UUID enumeration oracle /v1/public/organization (400 malformed / 404 not-found / 200 found) | 5.3 Medium (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE |
  - | A4 | /v1/global/organizations fail-open (200 + {"data":[]} + CORS, route-specific, zero-header) | 5.3 Medium (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE (intermittent 400 from LB flapping
  - | A5 | /v1/public/terms data disclosure (200 + live terms URLs via mobileAppId/organizationId, no auth + CORS) | 3.1 Low (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE |
  - | A6 | CSP + MFE manifest infra leak platform.sparelabs.com/login (prod+staging admin Vercel apps + Metabase + full cloud infra) | 3.1 Low (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE |
  - | A7 | JS bundle staging infra leak forms.sparelabs.com (main.71d52314.js — staging+prod+regional + atlassian + inactive ngrok) | 3.1 Low (AV:N/AC:L/PR:N/UI:N/S:U:C:L/I:N/A:N) | VALID — STABLE |

- 1 lead(s) marked VALID at 2026-08-10 10:02:18 UTC
  - | **VALID** | 7 | All reconfirmations of already-accepted A1-A7 (no new VALID findings) |

- 1 lead(s) marked VALID at 2026-08-10 15:32:54 UTC
  - Please paste the leads you want me to triage — each with its probe results (URLs, http_code, response details, finding description) — and I'll evaluate all 7 questions per lead with a verdict, proof s

- 10 lead(s) marked VALID at 2026-08-10 16:49:24 UTC
  - **Verdict: HOLD** — write handler auth unproven; requires AUTH_HELPED + operator write-approval per `no_data_modification` rule. Not triageable as VALID within passive-only constraints.
  - **Verdict: HOLD** — write handler auth unproven; requires AUTH_HELPED + operator write-approval. Not triageable as VALID within passive-only constraints.
  - **Verdict: Already VALID (A4)** — reconfirmation only, no delta. CVSS 5.3 Medium. Stable 84h+.
  - **Verdict: Already VALID (A2)** — reconfirmation only, no delta. CVSS 5.3 Medium. Stable 84h+.
  - **Verdict: Already VALID (A1)** — reconfirmation only, no delta. CVSS 8.1 High. Stable 84h+.
  - | L8 Zero-header bypass reconfirmation | **Already VALID (A4)** | No delta |
  - | L9 Scheme-only bypass reconfirmation | **Already VALID (A2)** | No delta |
  - | L10 CORS reflection reconfirmation | **Already VALID (A1)** | No delta |
  - **VALID (new):** 0
  - **VALID (reconfirmation):** 3 (A1, A2, A4)

- 18 lead(s) marked VALID at 2026-08-10 18:53:20 UTC
  - | A1 | CORS reflect-any-origin + credentials on /v1/** (all methods + Authorization header, uniform envoy middleware) | 8.1 High (AV:N/AC:L/PR:N/UI:R/S:U/C:H/I:H/A:N) | VALID — STABLE 96h+ |
  - | A2 | Scheme-only auth bypass /v1/global/regions (200 + 725B region registry with garbage Bearer; middleware validates scheme only, never token) | 5.3 Medium (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | V
  - | A3 | UUID enumeration oracle /v1/public/organization (400 malformed / 404 not-found / 200 found) | 5.3 Medium (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE |
  - | A4 | /v1/global/organizations fail-open (200 + {"data":[]} + CORS, zero-header, route-specific) | 5.3 Medium (AV:N/AC:L/PR:N/UI:N/S:U:C:L/I:N/A:N) | VALID — STABLE |
  - | A5 | /v1/public/terms data disclosure (200 + live terms URLs via mobileAppId/organizationId, no auth + CORS) | 3.1 Low (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE |
  - | A6 | CSP + MFE manifest infra leak platform.sparelabs.com/login (prod+staging admin Vercel apps + Metabase + full cloud infra) | 3.1 Low (AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE |
  - | A7 | JS bundle staging infra leak forms.sparelabs.com (main.71d52314.js — staging+prod+regional + atlassian + inactive ngrok) | 3.1 Low (AV:N/AC:L/PR:N/UI:N/S:U:C:L/I:N/A:N) | VALID — STABLE |
  - | Q3 Real impact? | **UNPROVEN** — 400 alone doesn't confirm oracle or data disclosure. No format discrimination observed yet (only test-UUID probed, not malformed vs valid-format). |
  - **Verdict: HOLD** — new auth-free route variant on public namespace. Need format discrimination test (malformed UUID vs valid-format UUID). If 400/404 differential confirmed, it's a duplicate of A3 (s
  - | A1 | CORS reflect-any-origin+creds /v1/** | **VALID** (reconf) | CVSS 8.1 — STABLE 96h+ |
  - | A2 | Scheme-only bypass /v1/global/regions | **VALID** (reconf) | CVSS 5.3 — STABLE |
  - | A3 | UUID enum oracle /v1/public/organization | **VALID** (reconf) | CVSS 5.3 — STABLE |
  - | A4 | /v1/global/organizations fail-open | **VALID** (reconf) | CVSS 5.3 — STABLE |
  - | A5 | /v1/public/terms data disclosure | **VALID** (reconf) | CVSS 3.1 — STABLE |
  - | A6 | CSP infra leak platform /login | **VALID** (reconf) | CVSS 3.1 — STABLE |
  - | A7 | JS bundle leak forms.sparelabs.com | **VALID** (reconf) | CVSS 3.1 — STABLE |
  - | — | No new VALID findings this cycle | — | — |
  - | /v1/global/regions | 200 + 725B (scheme-only) | 400 in latest probes (LB flapping) | STABLE — A2 still valid (intermittent 200/400 from multi-version LB) |

- 12 lead(s) marked VALID at 2026-08-10 20:33:51 UTC
  - | A1 | CORS reflect-any-origin + credentials on /v1/** (all methods + Authorization header, uniform via envoy) | 8.1 High | VALID — STABLE |
  - | A2 | Scheme-only auth bypass /v1/global/regions (200 + 725B region registry with garbage Bearer; middleware validates scheme only, never token) | 5.3 Medium | VALID — STABLE |
  - | A3 | UUID enumeration oracle /v1/public/organization (400 malformed / 404 not-found / 200 found) | 5.3 Medium | VALID — STABLE |
  - | A4 | /v1/global/organizations fail-open (200 + {"data":[]} + CORS, route-specific) | 5.3 Medium | VALID — STABLE |
  - | A5 | /v1/public/terms data disclosure (200 + live terms URLs via mobileAppId|organizationId, no auth) | 5.3 Medium | VALID — STABLE |
  - | Q3 Real impact? | **YES** — full internal infra topology (7 regions, 6 OOS api/routing hosts) disclosed without valid auth |
  - | Q3 Real impact? | **YES** — enumerate valid org UUIDs without auth |
  - | Q2 Attacker-reachable? | **PARTIAL** — needs valid Bearer token |
  - | /v1/global/organizations | 200 {"data":[]} (stable fail-open) | **200 {"data":[]}** (still stable) | No change — A4 remains valid |
  - | /v1/public/terms | 200 + data | **200 + data** (stable) | No change — A5 remains valid |
  - | /v1/public/organizations | 400/404 oracle | **400/404 oracle** (stable) | No change — A3 remains valid |
  - | — | No new VALID findings this cycle | — | — |

- 11 lead(s) marked VALID at 2026-08-10 21:33:42 UTC
  - valid-bugs.md
  - ### Verdict: **VALID**
  - ### Verdict: **VALID** (as a reliable auth-bypass with current data-light impact)
  - | Q4 Passive proof | ✅ YES — `Authorization: Bearer x` is a valid GET |
  - ### Verdict: **VALID** ⭐ (strongest standalone auth-bypass finding)
  - ### Verdict: **VALID**
  - ### Verdict: **VALID** (as part of the unauthenticated surface cluster)
  - ### Verdict: **VALID** (as reconnaissance/infrastructure inventory disclosure)
  - ### Verdict: **VALID** (as infrastructure reconnaissance)
  - | api.sparelabs.com/v1/auth/token/superAdmin role-check bypass | **HOLD** | Requires AUTH_HELPED (valid token); auth-gated at edge per probe; unproven |
  - | Engage portal IDOR (cross-tenant journey/booking) | **HOLD** | Requires AUTH_HELPED (valid rider token); object-level auth unproven |

- 14 lead(s) marked VALID at 2026-08-10 22:27:04 UTC
  - **Verdict: VALID**
  - **Verdict: VALID (Medium, capped by empty payload)**
  - **Verdict: VALID (High)**
  - | Q3 | **YES** — 400 (malformed) vs 404 (nil-uuid) vs 200 (valid-found) enables binary discrimination to discover live org UUIDs; pivot to authenticated endpoints |
  - **Verdict: VALID (Medium)**
  - **Verdict: VALID (Low-Medium)**
  - **Verdict: VALID (Low)**
  - | `/v1/auth/token/superAdmin` role-check bypass | Requires AUTH_HELPED (POST with a valid non-superAdmin token). Impact would be critical if confirmed, but out of scope for passive-only rules. HOLD fo
  - | 1 | api.sparelabs.com | CORS reflect-any-origin+creds on all /v1 | **VALID** | 7.6 |
  - | 2 | api.sparelabs.com | /v1/global/organizations zero-header bypass (empty) | **VALID** | 5.3 |
  - | 3 | api.sparelabs.com | /v1/global/regions scheme-only bypass → 725B leak | **VALID** | 7.5 |
  - | 4 | api.sparelabs.com | /v1/public/organization UUID enumeration oracle | **VALID** | 5.3 |
  - | 6 | platform.sparelabs.com | CSP + MFE prefetch infra leak | **VALID** | 4.3 |
  - | 7 | forms.sparelabs.com | JS bundle staging/infra URL leak | **VALID** | 4.3 |

- 17 lead(s) marked VALID at 2026-08-11 00:54:50 UTC
  - | A1 | CORS reflect-any-origin + credentials on /v1/** (all methods + Authorization header, uniform via envoy) | **8.1 High** (CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:U/C:H/I:H/A:N) | VALID — STABLE 84h+ |
  - | A2 | Scheme-only auth bypass /v1/global/regions (200 + 725B region registry with garbage Bearer; middleware validates scheme only, never token) | **5.3 Medium** (CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L
  - | A3 | UUID enumeration oracle /v1/public/organization (400 malformed / 404 not-found / 200 found) — **DEGRADED to 2-way** (nil-uuid→400) | **5.3 Medium** → **3.1 Low** (reduced precision) | VALID — r
  - | A4 | /v1/global/organizations fail-open (200 + {"data":[]} + CORS, route-specific) | **5.3 Medium** (CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:U/C:L/I:L/A:N) | VALID — STABLE 84h+ |
  - | A5 | /v1/public/terms data disclosure (200 + live terms URLs via mobileAppId|organizationId, no auth) | **5.3 Medium** (CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE 84h+ |
  - | A6 | /v1/public/organizations/{id} UUID enumeration oracle (3-way: 400 malformed / 404 nil-uuid / 200 found) — **plural namespace has BETTER discrimination than degraded singular** | **5.3 Medium** 
  - | A7 | CSP infra leak platform.sparelabs.com/login (prod+staging admin Vercel apps + Metabase + full cloud infra) | **4.3 Low** (CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — informational |
  - | A8 | JS bundle leak forms.sparelabs.com main.71d52314.js (staging+prod+regional infra + atlassian.net + ngrok) | **4.3 Low** (CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — informational |
  - | Q7 Triager accept? | Already VALID |
  - **Verdict: Already VALID** — Lead A1 reconfirmation.
  - | Q7 Triager accept? | Already VALID |
  - **Verdict: Already VALID** — Lead A8 reconfirmation.
  - | Q7 Triager accept? | Already VALID |
  - **Verdict: Already VALID** — Lead A7 reconfirmation.
  - | L11 | api.sparelabs.com/v1/** (CORS) | all models | **Already VALID** | A1 reconfirmation |
  - | L12 | forms.sparelabs.com (JS bundle) | laguna, ling3, nemotron3 | **Already VALID** | A8 reconfirmation |
  - | L13 | platform.sparelabs.com (CSP leak) | laguna, ling3, nemotron3 | **Already VALID** | A7 reconfirmation |

- 1 lead(s) marked VALID at 2026-08-11 05:58:10 UTC
  - | **L18** | `api.sparelabs.com/v1/public/organizations/{id}` (data-bearing) | **HOLD** | Q4 200-branch needs valid UUID; extends A6. |

- 10 lead(s) marked VALID at 2026-08-11 09:31:01 UTC
  - | A1 | CORS reflect-any-origin + credentials on /v1/** (all methods + Authorization, uniform envoy middleware) | 8.1 High (CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:U/C:H/I:H/A:N) | VALID — STABLE 96h+ |
  - | A2 | Scheme-only auth bypass /v1/global/regions (200 + 725B region registry with garbage Bearer; middleware validates scheme only, never token) | 5.3 Medium (CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N
  - | A3 | UUID enumeration oracle /v1/public/organization (2-way: 400 malformed / 200 found; nil-uuid now also 400) | 3.1 Low (CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — reduced severity |
  - | A4 | /v1/global/organizations fail-open (200 + {"data":[]} + CORS, route-specific, READ-ONLY — write path enforces auth) | 5.3 Medium (CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:U/C:L/I:N/A:N) | VALID — write-p
  - | A5 | /v1/public/terms data disclosure (200 + live terms URLs via mobileAppId|organizationId, no auth) | 5.3 Medium (CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE 96h+ |
  - | A6 | /v1/public/organizations/{id} UUID enumeration oracle (3-way: 400 malformed / 404 nil-uuid / 200 found) | 5.3 Medium (CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — STABLE, best discri
  - | A7 | CSP infra leak platform.sparelabs.com/login (prod+staging admin Vercel apps + Metabase + full cloud infra) | 4.3 Low (CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — informational |
  - | A8 | JS bundle leak forms.sparelabs.com main.71d52314.js (staging+prod+regional infra + atlassian.net + ngrok) | 4.3 Low (CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N) | VALID — informational |
  - | Q4 Passive proof? | NO — requires AUTH_HELPED (POST with a valid non-superAdmin Bearer token); passive GET returns 401 |
  - **Verdict: HOLD** — Q4 fails (requires AUTH_HELPED write testing). Endpoint confirmed live at edge (401-gated with garbage Bearer, OPTIONS 204 advertises POST). Per-route auth omissions are the proven

- 4 lead(s) marked VALID at 2026-08-11 17:50:54 UTC
  - | A4 | IDOR | api.sparelabs.com/v1/public/organizations/{id} | 3-way UUID enumeration oracle — malformed→400, nil→404, valid→200 | ACCEPTED |
  - | Q3 Real impact? | YES — full internal infra topology disclosure (7 regions, 6 OOS api/routing subdomains) without valid auth |
  - | Q3 Real impact? | YES — 3-way differential (malformed→400, nil→404, valid→200) enables org UUID enumeration |
  - | Q4 Provable passive? | **NO** — requires AUTH_HELPED valid tenant token to test role check |

- 1 lead(s) marked VALID at 2026-08-11 23:12:05 UTC
  - | **Known VALID (A1–A7)** | CORS reflect-any-origin (8.1), scheme-only auth bypass (5.3), UUID enumeration (5.3), fail-open orgs (5.3), terms data disclosure (3.1–5.3), CSP/MFE infra leak (4.3), JS bu

- 19 lead(s) marked VALID at 2026-08-12 03:06:25 UTC
  - | A8 | IDOR | api.sparelabs.com/v1/public/organizations/{id} | **3-way UUID enumeration oracle** (plural namespace) — malformed→400 ValidationError; nil-uuid→404 NotFoundError; valid→200 (HUMAN_ONLY);
  - | Q3 Real impact? | YES — full infra topology disclosure (7 regions, 6 OOS hosts) without valid auth |
  - | Q3 Real impact? | YES — 3-way differential (malformed→400, nil→404, valid→200) enables org UUID enumeration; CORS enables cross-origin |
  - | Q4 Passive proof? | YES (400/404 branch); HUMAN_ONLY for valid-UUID 200-branch |
  - | Q3 Real impact? | UNPROVEN — 200-branch unobserved 84h+; terms-valid UUID returns 404 on oracle |
  - | Q3 Real impact? | UNPROVEN — zero-header GET → hardcoded 200+11B `{"data":[]}` across 7+ query params; unknown if valid token returns data |
  - | Q5 Novel? | PARTIAL — A3 (zero-header bypass) accepted; data-bearing nature with valid token unproven |
  - **Verdict: HOLD** — needs program test token. If valid token returns non-empty org registry, severity upgrades from stub-level to HIGH. Already on HOLD queue.
  - | Q3 Real impact? | LOW — nil-uuid now returns 400 ValidationError "not found" (was 404); 3-way→2-way degradation; valid-org confirmation requires HUMAN_ONLY UUID |
  - | A1 | CORS reflect-any-origin+creds /v1/** | **VALID** (reconf) | CVSS 8.1 — STABLE 84h+ |
  - | A2 | Scheme-only bypass /v1/global/regions | **VALID** (reconf) | CVSS 5.3 — STABLE |
  - | A3 | Zero-header bypass /v1/global/organizations | **VALID** (reconf) | CVSS 5.3 — STABLE (read-only) |
  - | A4 | UUID oracle /v1/public/organization | **VALID** (reconf, degraded) | CVSS 5.3 — degraded 2-way |
  - | A5 | Data disclosure /v1/public/terms | **VALID** (reconf) | CVSS 3.1 — STABLE |
  - | A6 | CSP infra leak platform/login | **VALID** (reconf) | CVSS 3.1 — STABLE |
  - | A7 | JS bundle leak forms.sparelabs.com | **VALID** (reconf) | CVSS 3.1 — STABLE |
  - | A8 | 3-way UUID oracle /v1/public/organizations/{id} | **VALID** (reconf) | CVSS 5.3 — STABLE (new 2026-08-11) |
  - | L6 | Valid-token org registry data-bearing | **HOLD** | Needs program test token |
  - | — | **No new VALID findings this cycle** | — | — |

- 11 lead(s) marked VALID at 2026-08-22 00:37:01 UTC
  - **Verdict: VALID**
  - **Verdict: VALID**
  - **Verdict: VALID**
  - **Verdict: VALID**
  - **Verdict: VALID**
  - **Verdict: HOLD** — The 3-way differential is confirmed but no real UUID → 200 has been captured. Needs a known valid org UUID to prove the 200 branch.
  - | 1 | SSO Tenant Enumeration (WorkOS) | **VALID** | Clean unauth oracle with credential leak. Report. |
  - | 2 | Org-Key Tenant Disclosure | **VALID** | Feature-flag differential is real intel. Report. |
  - | 3 | Regions Topology + Bearer-x Bypass | **VALID** | Scheme-only bypass + infra disclosure. Report. |
  - | 4 | CORS Reflect-Any-Origin + Credentials | **VALID** | Report as-is. The ACAC:true + Authorization in ACAM is the finding regardless of cookie auto-attach. Downgrade severity if Bearer-only confirm
  - | 5 | Zero-Header Organizations Bypass | **VALID** | Empty payload is a liability, not an exoneration. Report the pattern (auth omission + write CORS surface). Severity low today, escalates if data-be

- 9 lead(s) marked VALID at 2026-08-22 04:03:20 UTC
  - ### Verdict: **VALID**
  - ### Verdict: **VALID**
  - ### Verdict: **VALID**
  - | Q3 Real impact? | **YES** — unauthenticated case creation endpoint; with valid caseTypeId and contactInfo could create cases in any customer's environment |
  - ### Verdict: **VALID**
  - | 1 | SSO Tenant Enumeration (WorkOS Oracle) | **VALID** | 7.5 | Unauthenticated SSO secret leak → targeted phishing |
  - | 2 | Org-Key Tenant Disclosure | **VALID** | 6.5 | Unauthenticated customer enumeration + internal feature-flag inventory |
  - | 3 | Regions Topology + Bearer-x Auth Bypass | **VALID** | 7.5 | Auth bypass + full infrastructure disclosure |
  - | 5 | Engage Cases POST Auth Gate Absent | **VALID** | 6.5 | Unauthenticated write-path bypass |
