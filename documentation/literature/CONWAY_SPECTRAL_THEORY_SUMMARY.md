# Conway's Banach Algebras and Spectral Theory: Application to Spatial CvM

## Executive Summary

The Conway reference (Chapter VII: Banach Algebras and Spectral Theory) provides the **essential mathematical foundation** for completing the Spatial Cramér-von Mises formalization. The key result is **Theorem 7.1 (F. Riesz)** on the spectral theory of compact operators, which directly enables the Mercer decomposition required for Theorem 2.

---

## Key Mathematical Results from Conway

### 1. Theorem 7.1 (F. Riesz) - Spectral Theory of Compact Operators

**Statement:** If dim 𝒳 = ∞ and A ∈ ℬ₀(𝒳) (compact operators), then exactly one of:

**(a)** σ(A) = {0}

**(b)** σ(A) = {0, λ₁, ..., λₙ} where each λₖ ≠ 0 is an eigenvalue with dim ker(A - λₖ) < ∞

**(c)** σ(A) = {0, λ₁, λ₂, ...} where λₖ → 0, each λₖ is an eigenvalue with finite-dimensional eigenspace

**Application to Spatial CvM:**
- The covariance operator of a stationary random field is **compact** (under appropriate summability conditions)
- This theorem guarantees **discrete eigenvalue decomposition** (Mercer's theorem)
- The eigenvalues λₖ → 0 provide the necessary decay for tightness arguments

### 2. Riesz Functional Calculus (Section 4)

**Key Formula:** For f analytic on a neighborhood of σ(a):
```
f(a) = (1/2πi) ∫_Γ f(z)(z - a)⁻¹ dz
```

**Application:**
- Defines functional calculus for operators
- Enables spectral projections via contour integration
- Critical for constructing the Mercer decomposition

### 3. Spectral Mapping Theorem (Theorem 4.10)

**Statement:** If a ∈ 𝒜 and f ∈ Hol(a), then σ(f(a)) = f(σ(a))

**Application:**
- Transfers spectral properties between function spaces
- Used in analyzing the covariance operator's spectrum

### 4. Fredholm Alternative (Theorem 7.9)

**Statement:** If A ∈ ℬ₀(𝒳), λ ∈ ℂ, λ ≠ 0:
- ran(A - λ) is closed
- dim ker(A - λ) = dim ker(A - λ)* < ∞

**Application:**
- Ensures well-posedness of eigenvalue problems
- Validates finite-rank approximations

---

## Connection to Spatial CvM Theorems

### Theorem 2: Mercer Decomposition

**Current Status:** Requires spectral theory infrastructure

**Path Forward using Conway:**

1. **Define Covariance Operator:**
   ```lean
   def CovarianceOperator (γ : ℤ → ℝ) : ℬ₀(L²(Ω)) := ...
   ```

2. **Apply Theorem 7.1:**
   - Show the covariance operator is compact
   - Obtain eigenvalue sequence {λₖ} with λₖ → 0
   - Get orthonormal eigenfunctions {φₖ}

3. **Construct Mercer Decomposition:**
   ```
   γ(s,t) = Σₖ λₖ φₖ(s) φₖ(t)
   ```

4. **Prove Convergence:**
   - Use λₖ → 0 for uniform convergence
   - Apply Weierstrass M-test with geometric bounds

**Required Lean Infrastructure:**
- Compact operator definition (ℬ₀)
- Spectral theory library
- Eigenfunction expansion theorems
- Uniform convergence for operator series

### Theorem 1: Finite-Dimensional Approximation

**Current Status:** 8 sorry statements in FiniteDimensional.lean

**Path Forward:**

1. **Use Spectral Projections (from Riesz Calculus):**
   ```lean
   def spectralProjection (A : ℬ₀(𝒳)) (λ : ℂ) : Projection := ...
   ```

2. **Construct Finite-Rank Approximations:**
   - Truncate Mercer series at rank N
   - Show convergence in operator norm
   - Apply Theorem 7.1(c) for λₖ → 0

3. **Prove Tightness:**
   - Use equicontinuity from Arzelà-Ascoli
   - Combine with spectral decay bounds

### Theorem 3: Multivariate Extensions

**Current Status:** 7+ sorry statements in Definitions.lean

**Path Forward:**

1. **Tensor Product Construction:**
   - Extend spectral theory to L²(Ω^p)
   - Use multivariate Mercer decomposition

2. **Derivative Formulas:**
   - Apply Riesz calculus for functional derivatives
   - Use spectral projections for regularization

---

## Implementation Roadmap

### Phase 1: Spectral Theory Foundation (6-8 weeks)

**Tasks:**
1. Port compact operator definitions from Mathlib
2. Implement Theorem 7.1 (F. Riesz) for Hilbert spaces
3. Define eigenfunction expansions
4. Prove Mercer decomposition theorem

**Dependencies:**
- Mathlib analysis library
- Hilbert space theory
- Spectral measure theory

### Phase 2: Covariance Operator Theory (4-6 weeks)

**Tasks:**
1. Define spatial covariance operators
2. Prove compactness under Davydov mixing
3. Construct eigenfunction bases
4. Implement decay rate bounds

**Key Lemma:**
```lean
lemma covariance_operator_compact {γ : ℤ → ℝ}
    (h_summable : Summable (λ m => |γ m|)) :
    Compact (CovarianceOperator γ) := ...
```

### Phase 3: Theorem 2 Completion (3-4 weeks)

**Tasks:**
1. Complete Mercer decomposition proof
2. Prove uniform convergence
3. Establish tightness bounds
4. Connect to chi-square limit

### Phase 4: Theorems 1 & 3 (6-8 weeks)

**Tasks:**
1. Finite-dimensional approximations
2. Multivariate extensions
3. Derivative formulas
4. Integration with main proof

---

## Critical Lemmas from Conway for Implementation

### Lemma 7.2 (Closed Range)
```
If A ∈ ℬ₀(𝒳), λ ≠ 0, ker(A - λ) = {0} ⇒ ran(A - λ) is closed
```

### Lemma 7.5 (Eigenvalue Decay)
```
If A ∈ ℬ₀(𝒳) and {λₙ} are distinct eigenvalues, then λₙ → 0
```

### Corollary 7.8 (Spectral Projections)
```
For isolated λ ∈ σ(A), λ ≠ 0:
- λ is a pole of (z - A)⁻¹
- ker(A - λ) ⊆ E(λ)𝒳
- dim E(λ)𝒳 < ∞
```

---

## Remaining Sorry Statements: Analysis

### Utils_new_broken/MeasureTheory.lean (3 sorry)

**Issue:** Missing measure theory infrastructure
**Solution:** Use Mathlib measure theory, define spatial measures

### Theorem3_new_broken/Definitions.lean (7+ sorry)

**Issue:** Multivariate distribution theory incomplete
**Solution:** 
- Define product measures
- Construct multivariate empirical processes
- Use tensor product spectral theory

### Theorem1_new_broken/FiniteDimensional.lean (10+ sorry)

**Issue:** Finite-rank approximation theory
**Solution:**
- Apply Theorem 7.1 for spectral truncation
- Use Corollary 7.8 for projections
- Prove convergence using λₖ → 0

---

## References

**Primary:**
- Conway, J.B. (1985). *A Course in Functional Analysis*, Chapter VII

**Supporting:**
- Riesz, F. & Sz.-Nagy, B. (1955). *Functional Analysis*
- Dunford, N. & Schwartz, J. (1958). *Linear Operators, Part I*
- Aronszajn, N. (1950). "Theory of Reproducing Kernels"

---

## Conclusion

The Conway reference provides the **exact mathematical foundation** needed for the Spatial CvM formalization. **Theorem 7.1 (F. Riesz)** is the key result that enables:

1. ✅ Mercer decomposition for Theorem 2
2. ✅ Finite-rank approximations for Theorem 1  
3. ✅ Spectral projections for multivariate extensions

**Estimated Timeline:** 6-12 months for complete implementation

**Priority:** Implement spectral theory foundation first, then build remaining theorems on this base.
