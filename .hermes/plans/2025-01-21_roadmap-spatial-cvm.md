# Roadmap: Building Up from Spatial-CvM Axioms

**Date**: 2025-01-21  
**Status**: Draft Plan — Ready for Review
**Scope**: Complete formalization of Spatial Cramér–von Mises theory in Lean 4

---

## Executive Summary

This roadmap provides a phased approach to prove the 44 axioms in the Spatial-CvM project. The work is organized into **6 phases** of increasing difficulty, from quick wins (days) to major infrastructure development (months-years).

| Phase | Duration | Axioms | Difficulty |
|-------|----------|--------|------------|
| Phase 1 | Days | 2 | 🟢 Immediate |
| Phase 2 | Weeks | 8 | 🟡 Beginner |
| Phase 3 | Weeks | 6 | 🟡 Intermediate |
| Phase 4 | Months | 7 | 🔴 Advanced |
| Phase 5 | Months | 6 | 🔴 Expert |
| Phase 6 | Months+ | 15 | ⚫ New Infrastructure |

---

## Phase 1: Quick Wins (🟢 Days)

### Goal
Prove 2 axioms that are already within reach of current Mathlib.

### Axioms to Prove
1. **`sup_norm_le_of_bound`** (`Theorem1/Definitions.lean:79`)
   - **Statement**: If |f(x)| ≤ B for all x in domain, then sup_norm ≤ B
   - **Mathlib Tool**: Use `sSup_le` with upper bound proof
   - **Est. Time**: 1-2 days

2. **`riemann_sum_convergence`** (`Utils/MeasureTheory.lean:48`)
   - **Statement**: Riemann sums converge to the integral
   - **Mathlib Tool**: Available in `Mathlib.Analysis.BoxIntegral` or similar
   - **Est. Time**: 1-2 days

### File Changes
- `SpatialCvM/Utils/MeasureTheory.lean`
- `SpatialCvM/Theorem1/Definitions.lean`

### Verification
```bash
lake build SpatialCvM Theorem1.Definitions
lake build SpatialCvM Utils.MeasureTheory
```

---

## Phase 2: Kernel Integral Theory (🟡 Weeks)

### Goal
Build the foundation for kernel operations by adding measurable structure.

### Prerequisites
- Understand `IsKernel` structure
- Learn about Bochner/Lebesgue integrals in Mathlib

### Axioms to Prove
1. **`kernel_squared_integral_pos`** (`Lemma1/Definitions.lean:59`)
   - Integral of squared kernel is positive
   - **Approach**: Use kernel boundedness + positivity on support

2. **`littleO_of_tendsto_zero`** (`Utils/Asymptotics.lean:32`)
   - Conversion from tendsto to little-o notation
   - **Approach**: Import from Mathlib's asymptotics library

3. **`IsTight`** (`Theorem1/Definitions.lean:111`)
   - Define using compact sets and probability bounds
   - **Approach**: Use `Mathlib.Probability` + compactness definitions

4. **Remaining kernel axioms** in `Lemma1/Definitions.lean`:
   - `gamma_kernel` definition
   - `Gamma_operator` definition  
   - `Gamma_operator_symmetric`

### New Definitions Needed
```lean
-- Add to IsKernel structure
structure IsKernel (K : ℝ → ℝ) where
  ...existing fields...
  measurable : Measurable K  -- NEW
```

### File Changes
- `SpatialCvM/Definitions/Kernel.lean` (add measurable field)
- `SpatialCvM/Lemma1/Definitions.lean` (prove kernel integrals)
- `SpatialCvM/Utils/Asymptotics.lean` (prove littleO)

### Verification
```bash
lake build SpatialCvM.Lemma1.Definitions
```

### References
- Rudin, W. (1976). *Principles of Mathematical Analysis*. Chapters 6, 11.
- Folland, G. (1999). *Real Analysis*. Chapters 2-3.

---

## Phase 3: Empirical Process Bounds (🟡 Weeks)

### Goal
Build the empirical process framework with explicit definitions.

### Prerequisites
- Complete Phase 2
- Understand how to define stochastic processes

### Axioms to Prove
1. **`empirical_process`** (`Theorem1/Definitions.lean:48`)
   - Define explicitly using kernel-weighted sum
   - **Approach**: Need sample data structure first

2. **`empirical_process_bound`** (`Theorem1/Tightness.lean:74`)
   - Boundedness of empirical process

3. **`empirical_process_diff_bound`** (`Theorem1/Tightness.lean:80`)
   - Lipschitz bound on differences

4. **`true_process`** (implicit in `Theorem1/Definitions.lean:17`)
   - Already partially defined, complete the proof

5. **`asymptotic_variance_formula`** (`Theorem1/Variance.lean:16`)
   - Express variance in terms of Gamma kernel

6. **`BoundOfKernel`** + **`some_bound`** (`Theorem1/FiniteDimensional.lean`)
   - Derive explicit bounds from IsKernel properties

### New Structures Needed
```lean
-- Sample data structure
structure SampleData (Ω : Type*) [MeasurableSpace Ω] (n : ℕ) where
  samples : Fin n → Ω → ℝ
  measurable : ∀ i, Measurable (samples i)
  iid : ∀ i j, IdentDistrib (samples i) (samples j)
```

### File Changes
- `SpatialCvM/Theorem1/Definitions.lean` (empirical process)
- `SpatialCvM/Theorem1/Tightness.lean` (bounds)
- `SpatialCvM/Theorem1/Variance.lean` (variance formula)

### Verification
```bash
lake build SpatialCvM.Theorem1.Tightness
```

---

## Phase 4: CLT & Mixing Theory (🔴 Months — Advanced)

### Goal
Prove the Central Limit Theorem for α-mixing arrays.

### Prerequisites
- Complete Phases 1-3
- Strong understanding of probability theory
- Fourier analysis for characteristic functions

### Axioms to Prove
1. **`davydov_inequality`** (incomplete in `Lemma1/Mixing.lean`)
   - Full covariance bound: |Cov(X,Y)| ≤ 4α^(1-2/q)||X||_p||Y||_r

2. **`alpha_summable`** + **`alpha_mixing_covariance_decay`**
   - Summability of mixing coefficients
   - Decay of covariances

3. **`lindeberg_indicators`** + **`clt_triangular_array`**
   - Lindeberg conditions for dependent data
   - CLT for triangular arrays under mixing

4. **`finite_dimensional_convergence`**
   - Convergence of finite-dimensional distributions

5. **`clt_mixing_arrays`**
   - Complete CLT proof for mixing arrays

6. **`indicator_covariance_integrable`**
   - Integrability of indicator covariances

### Key Lemmas to Prove
```lean
-- Davydov's inequality with explicit bound
lemma davydov_inequality {p q r : ℝ} (hp : p ≥ 1) (hq : q ≥ 1) (hr : r ≥ 1)
    (h : 1/p + 1/q + 1/r = 1) {X Y : Ω → ℝ}
    (hX : MemLp X p) (hY : MemLp Y q) :
    |covariance X Y| ≤ 4 * α(X,Y)^(1/r) * ‖X‖_p * ‖Y‖_q
```

### File Changes
- `SpatialCvM/Definitions/RandomField.lean` (mixing definitions)
- `SpatialCvM/Lemma1/Mixing.lean` (Davydov proof)
- `SpatialCvM/Theorem1/FiniteDimensional.lean` (CLT)

### Verification
```bash
lake build SpatialCvM.Theorem1.FiniteDimensional
```

### References
- Davydov, Y. A. (1970). The invariance principle. *Theory of Probability & Its Applications*, 15(3), 487-498. DOI: 10.1137/1115050
- El Machkouri, M., Volný, D., & Wu, W. B. (2013). A CLT for stationary random fields. *Stochastic Processes*, 123(1), 1-14. DOI: 10.1016/j.spa.2012.08.006
- Doukhan, P. (1994). *Mixing: Properties and Examples*. Springer Lecture Notes.

---

## Phase 5: Functional Analysis (🔴 Months — Expert)

### Goal
Prove Mercer's theorem and establish covariance operator theory.

### Prerequisites
- Complete Phases 1-4
- Functional analysis background (compact operators, spectral theory)
- L² space theory in Mathlib

### Axioms to Prove
1. **`mercer_decomposition`** (`Theorem2/Mercer.lean:49`)
   - Spectral decomposition of continuous kernels
   - Eigenfunctions + eigenvalues
   - **Major undertaking**: 2-4 months

2. **`tightness_via_equicontinuity`** + **`tightness_multivariate`**
   - Arzelà-Ascoli theorem application
   - Equicontinuity ⟹ tightness

3. **`asymptotic_covariance`** (both in `Lemma1/Main.lean` and `ExpandedProof.lean`)
   - Compute covariance of limit process

4. **`copula_mercer_decomposition`**
   - Extension to copula setting

### Key Components Needed
```lean
-- Compact operator structure
structure CompactOperator {H : Type} [HilbertSpace H] (T : H → H) where
  is_linear : ∀ x y, T (x + y) = T x + T y
  is_compact : IsCompactOperator T

-- Spectral theorem for self-adjoint compact operators
theorem spectral_compact_self_adjoint {H : Type} [HilbertSpace H]
    (T : H → H) (h_self : IsSelfAdjoint T) (h_compact : IsCompactOperator T) :
    ∃ λ : ℕ → ℝ, ∃ φ : ℕ → H,
    (∀ m, λ m ≥ 0) ∧
    (∀ m n, inner (φ m) (φ n) = if m = n then 1 else 0) ∧
    (∀ x, T x = ∑' m, λ m * inner x (φ m) * φ m)
```

### File Changes
- `SpatialCvM/Theorem2/Mercer.lean`
- `SpatialCvM/Theorem1/Tightness.lean`
- `SpatialCvM/Theorem3/MultivariateTightness.lean`

### Verification
```bash
lake build SpatialCvM.Theorem2.Mercer
```

### References
- Mercer, J. (1909). Functions of positive and negative type. *Phil. Trans. Royal Society*, 209, 415-446. DOI: 10.1098/rsta.1909.0016
- Conway, J. B. (1990). *A Course in Functional Analysis*. Springer. Chapters I-II.
- Reed, M., & Simon, B. (1980). *Methods of Modern Mathematical Physics*, Vol. I. Academic Press.

---

## Phase 6: Weak Convergence Framework (⚫ Major Infrastructure — Months to Years)

### Goal
Build the full infrastructure for weak convergence of empirical processes in ℓ∞.

### Prerequisites
- Expert-level knowledge of measure theory on Banach spaces
- Understanding of Prokhorov's theorem
- Willingness to contribute significant code to Mathlib

### Axioms to Prove
1. **`prokhorov_theorem`** (`Theorem1/Main.lean:20`)
   - Tightness ⟺ relative compactness in ℓ∞
   - **Note**: ℓ∞([0,1]) is **non-separable** — this is hard

2. **`weak_convergence`** (multiple locations)
   - Definition and properties of weak convergence
   - Billingsley's approach for non-separable spaces

3. **`continuous_mapping_theorem`** (`Theorem2/Main.lean:23`)
   - CMT in infinite-dimensional settings

4. **`IsGaussian`** + **`gaussian_process_exists`**
   - Definition of Gaussian processes
   - Existence via Kolmogorov extension

5. **`functional_delta_method`** (`Theorem3/DeltaMethod.lean:46`)
   - Hadamard differentiability
   - Chain rule for weak convergence

6. **`Hadamard`** + **`copula_hadamard_differentiable`**
   - Copula differentiability
   - Application to delta method

7. **`cramer_wold_multivariate`** + **`copula_weak_convergence`**
   - Multivariate extensions

8. **Calibration axioms**: `eigenvalues_of_covariance`, `p_value_uniform`

### Major Mathlib Contributions Required
This phase likely requires contributing to Mathlib itself:

```
Mathlib.Probability:
  - WeakConvergence.lean (new file)
  - ProkhorovTheorem.lean (new file)  
  - GaussianProcess.lean (new file)
  - HadamardDifferentiability.lean (new file)

Mathlib.Analysis:
  - CompactOperator.lean (expand existing)
  - SpectralTheory.lean (expand existing)
```

### File Changes
- `SpatialCvM/Theorem1/Main.lean`
- `SpatialCvM/Theorem2/Main.lean`
- `SpatialCvM/Theorem3/Main.lean`
- `SpatialCvM/Theorem3/DeltaMethod.lean`
- `SpatialCvM/Theorem3/Hadamard.lean`
- `SpatialCvM/Calibration/*.lean`

### Verification
```bash
lake build SpatialCvM
```

### References
- Billingsley, P. (1999). *Convergence of Probability Measures* (2nd ed.). Wiley.
- van der Vaart, A. W., & Wellner, J. A. (1996). *Weak Convergence and Empirical Processes*. Springer. DOI: 10.1007/978-1-4757-2545-2
- Römisch, W. (2004). Delta method, infinite dimensional. *Encyclopedia of Statistical Sciences*.

---

## Estimated Timeline

| Phase | Duration | Prerequisites |
|-------|----------|---------------|
| Phase 1 | 1-2 weeks | Current knowledge |
| Phase 2 | 2-4 weeks | Phase 1 complete |
| Phase 3 | 2-4 weeks | Phase 2 complete |
| Phase 4 | 2-3 months | Phases 1-3, probability expertise |
| Phase 5 | 2-4 months | Phase 4, functional analysis |
| Phase 6 | 6-12 months | All above, measure theory expertise |

**Total**: 1-2 years for complete formalization (part-time work with expertise)

**Total (with Mathlib contributions)**: 2-4 years for full infrastructure

---

## Recommended Starting Point

### Immediate Action (This Week)
1. **Prove `riemann_sum_convergence`** — Search Mathlib for `boxIntegral` or similar
2. **Prove `sup_norm_le_of_bound`** — Use `sSup_le` theorem

### Next Month
1. Add `Measurable` field to `IsKernel`
2. Define `gamma_kernel` as explicit integral
3. Prove `kernel_squared_integral_pos`

### First Quarter
1. Build sample data structure
2. Define empirical process explicitly
3. Prove empirical process bounds

---

## Risk Factors

| Risk | Likelihood | Mitigation |
|------|-----------|------------|
| Mathlib API changes | High | Pin to stable version, use `lake-manifest` |
| Missing prerequisites | High | Prove general lemmas first, contribute upstream |
| Complexity underestimation | Very High | Phase reviews, incremental milestones |
| Mathlib contributions required | Very High | Start discussions with Mathlib community early |

---

## Success Metrics

For each phase completion:

1. **No `sorry`** in Phase files
2. **No `axiom`** for Phase statements (can keep `axiom` for upcoming phases)
3. **`lake build`** passes for all modified modules
4. **`#print axioms <TheoremName>`** shows no unexpected axioms

---

## Call for Collaboration

This roadmap represents **significant work**. Recommendations:

1. **Phase out** — Work alone, prove what you can
2. **Phase in** — Collaborate with others, divide by expertise
3. **Mathlib contribution** — Submit general lemmas upstream to benefit community

Potential collaboration areas:
- Weak convergence framework (measure theorists)
- Mercer decomposition (functional analysts)  
- Mixing inequalities (probability theorists)
- Automated tactics (Lean experts)

---

## Next Steps

1. **Review this plan** — Are the assessments accurate?
2. **Prioritize** — Which Phases are most important? (suggest starting with 1-3)
3. **Execute Phase 1** — Prove the 2 quick wins starting tomorrow

---

**Document Status**: Draft → Awaiting Review → Execution
**Last Updated**: 2025-01-21
