# Immediate Implementation Plan: Spectral Theory for Spatial CvM

## Current Status

**COMPLETED:**
- ✅ LagRegroupProof.lean - All sorry statements resolved
- ✅ Geometric covariance summability proved
- ✅ Lag regroup identity with bijection implementation
- ✅ Coefficient boundedness lemmas

**REMAINING:** 20 sorry statements across:
- Utils_new_broken/MeasureTheory.lean (3)
- Theorem3_new_broken/Definitions.lean (7+)
- Theorem1_new_broken/FiniteDimensional.lean (10+)

---

## Priority 1: Spectral Theory Foundation

### Week 1-2: Compact Operator Definitions

**File:** `SpatialCvM/Definitions/CompactOperator.lean`

```lean
import Mathlib.Analysis.NormedSpace.OperatorNorm
import Mathlib.Analysis.InnerProductSpace.Basic

namespace SpatialCvM

/-- Compact operator on a Hilbert space (Definition from Conway VII.1.8) -/
def IsCompactOperator {H : Type*} [InnerProductSpace ℂ H] 
    (A : H → H) : Prop :=
  ∃ K : Set H, IsCompact K ∧ ∀ ε > 0, ∃ F : Finset H, 
    ∀ x ∈ closedBall 0 1, ∃ y ∈ F, ‖A x - y‖ < ε

/-- The algebra of compact operators ℬ₀(𝒳) -/
def CompactOperators (H : Type*) [InnerProductSpace ℂ H] : 
    Submodule ℂ (H →L[ℂ] H) := ...

/-- Covariance operator for stationary random field -/
def CovarianceOperator {n : ℕ} (γ : ℤ → ℝ) (h_summable : Summable (λ m => |γ m|)) :
    CompactOperators (Fin n → ℝ) := ...
```

**Key Lemmas to Prove:**
1. `covariance_operator_is_compact` - Show covariance operator is compact
2. `compact_operator_normed_space` - ℬ₀(𝒳) is a Banach algebra
3. `spectrum_non_empty` - σ(A) ≠ ∅ for compact A

### Week 3-4: Spectral Decomposition

**File:** `SpatialCvM/Proofs/SpectralDecomposition.lean`

```lean
/-- Theorem 7.1 (F. Riesz): Spectral theory for compact operators -/
theorem f_riesz_spectral_theory {H : Type*} [InnerProductSpace ℂ H]
    {A : CompactOperators H} (h_dim : InfiniteDimensional ℂ H) :
    -- Either (a), (b), or (c) holds
    (spectrum A = {0}) ∨ 
    (∃ (n : ℕ) (λs : Fin n → ℂ), 
      spectrum A = {0} ∪ Set.range λs ∧ 
      ∀ k, λs k ≠ 0 ∧ FiniteDimensional ℂ (ker (A - λs k • 1))) ∨
    (∃ (λs : ℕ → ℂ), 
      spectrum A = {0} ∪ Set.range λs ∧ 
      Tendsto λs atTop (𝓝 0) ∧ 
      ∀ k, λs k ≠ 0 ∧ FiniteDimensional ℂ (ker (A - λs k • 1))) := ...
```

**Dependencies:**
- Mathlib linear algebra
- Spectral theory (partially available)
- Hilbert space theory

---

## Priority 2: Mercer Decomposition (Theorem 2)

### Week 5-6: Mercer Theorem Implementation

**File:** `SpatialCvM/Proofs/MercerDecomposition.lean`

```lean
/-- Mercer decomposition for covariance operator -/
theorem mercer_decomposition {n : ℕ} (γ : ℤ → ℝ) 
    (h_pos_def : PositiveDefinite γ)
    (h_summable : Summable (λ m => |γ m|)) :
    ∃ (λs : ℕ → ℝ) (φs : ℕ → Fin n → ℝ),
      (∀ k, λs k ≥ 0) ∧
      (Tendsto λs atTop (𝓝 0)) ∧
      (∀ k, Orthonormal ℂ {φs k}) ∧
      (∀ s t : Fin n, γ (s - t : ℤ) = ∑' k, λs k * φs k s * φs k t) := ...
```

**Key Steps:**
1. Apply Theorem 7.1 to get eigenvalues {λₖ} and eigenfunctions {φₖ}
2. Prove orthonormality of eigenfunctions
3. Establish pointwise convergence of series
4. Prove uniform convergence using λₖ → 0

### Week 7-8: Chi-Square Limit

**File:** `SpatialCvM/Proofs/ChiSquareLimit.lean`

```lean
/-- Theorem 2: Chi-square limit for Spatial CvM -/
theorem chi_square_limit {n : ℕ} (a : ℕ → ℝ) (γ : ℤ → ℝ)
    (h_mercer : MercerDecomposition γ) :
    Tendsto (SpatialCvMStatistic n a γ) atTop 
      (Law (χ² (mercer_rank γ))) := ...
```

---

## Priority 3: Finite-Dimensional Approximation (Theorem 1)

### Week 9-10: Spectral Truncation

**File:** `SpatialCvM/Proofs/FiniteDimensionalApproximation.lean`

```lean
/-- Finite-rank approximation via spectral truncation -/
def spectralTruncation {H : Type*} [InnerProductSpace ℂ H]
    (A : CompactOperators H) (N : ℕ) : FiniteDimensional ℂ (H →L[ℂ] H) := ...

/-- Convergence of finite-rank approximations -/
theorem spectral_truncation_converges {H : Type*} [InnerProductSpace ℂ H]
    {A : CompactOperators H} (h_iso : Isometry A) :
    Tendsto (λ N => spectralTruncation A N) atTop 
      (𝓝 A) := ...
```

**Application to Theorem 1:**
- Replace sorry statements in FiniteDimensional.lean
- Use spectral projections from Corollary 7.8
- Prove tightness via equicontinuity + spectral decay

---

## Priority 4: Multivariate Extensions (Theorem 3)

### Week 11-12: Tensor Product Construction

**File:** `SpatialCvM/Definitions/Multivariate.lean`

```lean
/-- Multivariate covariance operator -/
def MultivariateCovarianceOperator {p : ℕ} (γs : Fin p → (ℤ → ℝ)) :
    CompactOperators (Fin p → Fin n → ℝ) := ...

/-- Multivariate Mercer decomposition -/
theorem multivariate_mercer {p : ℕ} (γs : Fin p → (ℤ → ℝ))
    (h_pd : ∀ j, PositiveDefinite (γs j)) :
    ∃ (Λ : ℕ → ℝ) (Φs : ℕ → Fin p → Fin n → ℝ), ...
```

---

## Technical Requirements

### Mathlib Dependencies

```
require mathlib from git "https://github.com/leanprover-community/mathlib4"
```

**Required Mathlib Modules:**
- `Mathlib.Analysis.InnerProductSpace.Basic`
- `Mathlib.Analysis.NormedSpace.OperatorNorm`
- `Mathlib.LinearAlgebra.Eigenspace`
- `Mathlib.Topology.ContinuousFunction.Basic`

### New Definitions Needed

1. **Compact Operators** (Conway VII.1.8)
2. **Spectral Projections** (Conway 6.9)
3. **Riesz Idempotents** (Conway 6.9)
4. **Mercer Kernels** (Aronszajn 1950)

### Proof Techniques from Conway

1. **Diagonalization Argument** (Lemma 7.5)
   - Used for eigenvalue decay
   - Key for tightness proofs

2. **Geometric Series** (Lemma 2.1)
   - Used for resolvent bounds
   - Key for convergence rates

3. **Resolvent Identity** (Proposition 3.9)
   - Used for spectral projections
   - Key for functional calculus

---

## Testing Strategy

### Unit Tests

```lean
-- Test: Covariance operator of geometric mixing is compact
example {ρ : ℝ} (hρ : |ρ| < 1) :
    IsCompactOperator (CovarianceOperator (λ m => ρ^|m|)) := ...

-- Test: Eigenvalues decay to 0
example {A : CompactOperators (Fin 10 → ℝ)} :
    Tendsto (eigenvalues A) atTop (𝓝 0) := ...
```

### Integration Tests

```lean
-- Test: Lag regroup + Mercer = Chi-square limit
example {n : ℕ} (a : ℕ → ℝ) (γ : ℤ → ℝ) :
    lag_regroup_identity a γ → 
    mercer_decomposition γ → 
    chi_square_limit n a γ := ...
```

---

## Risk Mitigation

### Risk 1: Mathlib Spectral Theory Incomplete

**Mitigation:** 
- Use `Mathlib.LinearAlgebra.Eigenspace` as starting point
- Port definitions from Isabelle/HOL spectral theory library
- Collaborate with Mathlib analysis team

### Risk 2: Hilbert Space Formalization Complex

**Mitigation:**
- Start with finite-dimensional case (Fin n → ℝ)
- Use `Mathlib.Analysis.InnerProductSpace.PiL2`
- Generalize later

### Risk 3: Time Constraints

**Mitigation:**
- Focus on Theorem 2 first (highest impact)
- Use axioms for Theorems 1 and 3 initially
- Gradually replace axioms with proofs

---

## Success Criteria

### Week 4 Milestone
- [ ] Compact operator definitions complete
- [ ] Covariance operator shown compact
- [ ] Theorem 7.1 statement formalized

### Week 8 Milestone
- [ ] Mercer decomposition proved
- [ ] Eigenvalue decay established
- [ ] Theorem 2 sorry statements resolved

### Week 12 Milestone
- [ ] Finite-dimensional approximation complete
- [ ] Multivariate extensions defined
- [ ] All sorry statements resolved

---

## Conclusion

This plan leverages the Conway reference to systematically address the remaining sorry statements. The key insight is that **Theorem 7.1 (F. Riesz)** provides the foundation for:

1. Mercer decomposition (Theorem 2)
2. Finite-rank approximations (Theorem 1)
3. Multivariate extensions (Theorem 3)

**Estimated Timeline:** 12 weeks for complete resolution of all sorry statements.

**Next Action:** Begin implementation of compact operator definitions (Week 1).
