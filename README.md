# Spatial Cramér-von Mises Test — Lean 4 Formalization

> A machine-checked formalization of the asymptotic theory for the **Spatial Cramér-von Mises (CvM) test** under fixed-bandwidth spatial statistics, built in Lean 4 with Mathlib.

[![Lean 4](https://img.shields.io/badge/Lean-4-blue)](./lean-toolchain) [![Mathlib](https://img.shields.io/badge/Mathlib-v4.30.0--rc1-green)](./lakefile.toml) [![Blueprint CI](https://github.com/mrphilo420/Spatial-CvM/actions/workflows/blueprint.yml/badge.svg)](https://github.com/mrphilo420/Spatial-CvM/actions/workflows/blueprint.yml)

---

## What Is This?

The Spatial CvM test is a goodness-of-fit test for spatial point patterns. This project formalizes its **asymptotic null distribution** in Lean 4 — proving that under a fixed bandwidth $h$, the test statistic converges to a **weighted chi-square distribution** $\sum \lambda_m^* \chi^2_{K-1,m}$, even under the null hypothesis.

**Key innovation**: The fixed-bandwidth regime produces a *non-consistent* test — the bandwidth doesn't shrink to zero, so spatial dependence persists and the limiting distribution is non-degenerate. This is both practically useful (practitioners choose $h$) and mathematically rich (the covariance operator doesn't vanish).

---

## The Three Theorems

| Result | Statement | Lean Status |
|--------|-----------|-------------|
| **Lemma 1** | Asymptotic covariance $\Gamma(y,z) = \sum_{d=0}^\infty \text{Cov}(Y_1(y), Y_{1+d}(z)) < \infty$ | ✅ Axiomatized |
| **Theorem 1** | $\sqrt{n}(\widehat{H}_{n,h} - H_0) \xrightarrow{d} \mathcal{GP}$ in $\ell^\infty[0,1]$ | 🟠 Refactoring (Tightness ✅) |
| **Theorem 2** | $T_n \xrightarrow{d} \sum_{m=1}^\infty \lambda_m^* \chi^2_{K-1,m}$ | 🟠 Blocked by Thm 1 |
| **Theorem 3** | Multivariate extension via copula decomposition | 🟡 Partial proof |

**Proof dependency chain**: Lemma 1 → Theorem 1 → Theorem 2 → Theorem 3

---

## The Journey So Far

This project has been an intense formalization effort spanning multiple phases:

### Phase 1: Initial Setup & Definitions
- Set up the Lean 4 project with Mathlib dependency
- Defined all core mathematical structures: spatial locations, kernel functions, random fields, $\alpha$-mixing, copulas
- Established the project architecture organized by theorem

### Phase 2: Axiom Audit & Cleanup (Tier 1 — ✅ Complete)
- Audited **33 Lean files** containing **25 axioms**
- Found **6 critical issues**: 1 false axiom, 7 degenerate axioms
- Removed 8 false/degenerate axioms; defined `weighted_chisq` properly
- Result: **25 → 17 axioms**, all logically consistent
- Verified `SpatialCvM.Theorem1.Tightness` compiles successfully

### Phase 3: Theorem 1 Refactoring (Tier 2a — 🟠 In Progress)
- Broke the monolithic `weak_convergence` axiom into 3 sub-lemmas:
  1. **FDD Convergence** (Lindeberg CLT) — in progress
  2. **Tightness** (Arzelà-Ascoli) — ✅ compiles, all `positivity` errors fixed
  3. **Limit Characterization** — planned
- Fixed 4 `positivity` tactic errors by replacing with explicit semantic lemmas
- Cleaned linter warnings, enforced Lean style guide

### Phase 4: Paper & Documentation (✅ Complete)
- Wrote a complete publishable LaTeX paper (`paper/spatial_cvm_asymptotic_theory.tex`)
- Created supplementary proofs document (~500 lines of detailed math)
- Built a quick-reference card with notation, inequalities, and assumptions
- Documented the full mathematical framework

### Phase 5: Theorem 2 & 3 (Planned)
- Theorem 2: Continuous mapping + Mercer spectral decomposition → chi-square limit
- Theorem 3: Copula decomposition + functional delta method → multivariate extension
- Estimated: ~42 hours remaining

---

## Project Structure

```
SpatialCvM/
├── Main.lean                              # Entry point
├── SpatialCvM.lean                        # Namespace & API exports
│
├── Definitions/                           # Core definitions ✅
│   ├── Basic.lean                         # Spatial locations, distances
│   ├── Kernel.lean                        # Kernel functions, bivariate forms
│   ├── RandomField.lean                   # α-mixing, stationarity, isotropy
│   ├── Lattice.lean                       # Lattice domains
│   └── Copula.lean                        # Copula structures
│
├── Lemma1/                                # Asymptotic Covariance ✅
│   ├── Main.lean                          # asymptotic_covariance axiom
│   ├── Definitions.lean                   # Gamma kernel, Gamma operator
│   ├── Stationarity.lean                  # Stationary process properties
│   ├── Mixing.lean                        # Davydov inequality, mixing bounds
│   └── Asymptotics.lean                   # Little-o, big-O notation
│
├── Theorem1/                              # Weak Convergence 🟠
│   ├── Main.lean                          # weak_convergence axiom (refactoring)
│   ├── FiniteDimensional.lean             # FDD convergence structure
│   ├── Tightness.lean                     # Tightness lemmas ✅ compiles
│   ├── Variance.lean                      # Variance computation
│   └── Definitions.lean                   # Supporting definitions
│
├── Theorem2/                              # Null Distribution 🟠
│   ├── Main.lean                          # asymptotic_null axiom
│   ├── ChiSquare.lean                     # weighted_chisq (now defined ✅)
│   ├── JointConvergence.lean              # Joint convergence structure
│   ├── Mercer.lean                        # Eigenvalue decomposition
│   └── Definitions.lean
│
├── Theorem3/                              # Multivariate Extension 🟡
│   ├── Main.lean                          # multivariate_limit (partial proof)
│   ├── DeltaMethod.lean                   # Functional delta method
│   ├── Hadamard.lean                      # Hadamard differentiability
│   ├── MultivariateTightness.lean         # Multivariate tightness
│   └── Definitions.lean
│
├── Calibration/                           # Test calibration (non-core)
│   ├── Eigenvalues.lean                   # Spectral computation
│   ├── Satterthwaite.lean                 # Satterthwaite approximation
│   └── DiscreteCovariance.lean           # Discrete covariance
│
├── ExpandedProof.lean                     # Extended proof scratchpad
│
└── Utils/                                 # Utility lemmas
    ├── Asymptotics.lean                   # Little-o, big-O formalization
    ├── MeasureTheory.lean                 # Integration, Riemann sums
    └── Tactics.lean                       # Custom proof tactics
```

---

## Documentation

| File | Description |
|------|-------------|
| [`MATHEMATICAL_FRAMEWORK.md`](./MATHEMATICAL_FRAMEWORK.md) | Complete mathematical exposition of all definitions and theorems |
| [`FORMALIZED_SPATIAL_CVM_TEST.txt`](./FORMALIZED_SPATIAL_CVM_TEST.txt) | Plain-text reference of all Lean definitions and axioms |
| [`ROADMAP.md`](./ROADMAP.md) | Detailed phase-by-phase roadmap with hour estimates |
| [`STATUS_REPORT.md`](./STATUS_REPORT.md) | Current status, completed work, and technical tactics used |
| [`CONTRIBUTING.md`](./CONTRIBUTING.md) | How to contribute to the formalization |
| [`QUICKSTART.md`](./QUICKSTART.md) | Get up and running in 5 minutes |
| [`FINAL_PAPER.md`](./FINAL_PAPER.md) | Complete publishable paper (Markdown) |
| [`paper/`](./paper/) | LaTeX paper drafts, supplementary proofs, quick reference |

---

## Getting Started

### Prerequisites
- **Lean 4** (v4.30.0-rc1 or later)
- **Lake** (Lean package manager, bundled with Lean 4)
- **Mathlib** (imported automatically via `lakefile.toml`)

### Installation

```bash
# Clone the repository
git clone https://github.com/mrphilo420/Spatial-CvM.git
cd Spatial-CvM

# Update dependencies (Lake fetches Mathlib automatically)
lake update

# Build the project
lake build
```

### Verify Setup

```bash
# Build a specific module
lake build SpatialCvM.Theorem1.Tightness

# Run the REPL
lake env lean --repl
```

---

## Mathematical Highlights

### Fixed vs. Shrinking Bandwidth

| Property | Shrinking $h_n \to 0$ | Fixed $h > 0$ |
|----------|----------------------|----------------|
| Consistency | ✅ Consistent | ❌ Non-consistent |
| Limiting distribution | $\chi^2_{K-1}$ | $\sum \lambda_m^* \chi^2_{K-1,m}$ |
| Covariance | Vanishes | Persists ($\Gamma \neq 0$) |
| Spatial dependence | Disappears | Encoded in eigenvalues |
| Interpretability | Low (scale-free) | High (fixed spatial scale) |

### Core Proof Techniques

- **Davydov's inequality** — bounds on mixing covariance
- **Lindeberg CLT** — finite-dimensional convergence
- **Arzelà-Ascoli** — tightness in $\ell^\infty$
- **Mercer's theorem** — spectral decomposition of covariance operator
- **Continuous mapping theorem** — quadratic form → chi-square
- **Functional delta method** — extension to multivariate case
- **Copula decomposition** — separating marginal and dependence structure

---

## Current Status (April 2026)

| Metric | Value |
|--------|-------|
| **Lean files** | 34 |
| **Lines of Lean code** | ~2,100 |
| **Proved theorems/lemmas** | 19 |
| **Core axioms** | 49 (incl. ExpandedProof scratchpad) |
| **Compiling modules** | `SpatialCvM.Theorem1.Tightness` ✅ |
| **Next milestone** | Complete Theorem 1 FDD convergence sub-lemma |
| **Estimated remaining** | ~42 hours |

---

## License

This project is released for academic and research purposes. See individual files for attribution.

---

## Acknowledgments

Built with [Lean 4](https://lean-lang.org/) and [Mathlib](https://github.com/leanprover-community/mathlib4). The mathematical theory follows the fixed-bandwidth spatial CvM framework for goodness-of-fit testing in spatial statistics.

