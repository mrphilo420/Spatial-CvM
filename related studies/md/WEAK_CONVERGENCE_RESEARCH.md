# Weak Convergence Framework Research

**Date**: 2025-01-21  
**Focus**: Understanding what's needed to build Prokhorov's theorem and weak convergence in Lean

---

## Current State of Mathlib

### ❌ NOT Available in Mathlib

| Component | Status | Why It Matters |
|-----------|--------|---------------|
| `WeakConvergence` | ❌ Not defined | Core concept missing |
| `ProbabilityMeasure` on function spaces | ❌ Not defined | Can't define measures on ℓ∞ |
| `ProkhorovTheorem` | ❌ Not proved | Tightness ⟺ relative compactness |
| `IsTight` | ❌ Not defined | Key condition for convergence |
| `ℓ∞([0,1])` space | ❌ Not defined | Non-separable Banach space |
| Borel σ-algebra on ℓ∞ | ❌ Not defined | Measure theory obstacle |

### ✅ Available in Mathlib (Building Blocks)

| Component | Mathlib Location | Notes |
|-----------|-----------------|-------|
| `Tendsto` | `Mathlib.Order.Filter` | Basic convergence |
| `Measure` | `Mathlib.MeasureTheory` | Abstract measures |
| `IsCompact` | `Mathlib.Topology.Compactness` | Compact sets in topology |
| `NormedSpace` | `Mathlib.Analysis.NormedSpace` | Banach spaces |
| `Borel` σ-algebra | `Mathlib.MeasureTheory` | On separable spaces |

---

## Weak Convergence: Mathematical Requirements

### Portmanteau Theorem (Equivalent Definitions)

From Wikipedia/standard references, weak convergence Pₙ ⇒ P is equivalent to ANY of:

1. **Expectation definition** (Primary):
   ```
   Eₙ[f] → E[f]  for all f ∈ C_B(S) (bounded continuous functions)
   ```

2. **Lipschitz test functions**:
   ```
   Eₙ[f] → E[f]  for all bounded Lipschitz f
   ```

3. **Closed set limsup**:
   ```
   limsup Pₙ(C) ≤ P(C)  for all closed C ⊆ S
   ```

4. **Open set liminf**:
   ```
   liminf Pₙ(U) ≥ P(U)  for all open U ⊆ S
   ```

5. **Continuity sets**:
   ```
   Pₙ(A) → P(A)  for all continuity sets A of P
   ```

**Key insight**: Definition 1 (bounded continuous functions) is the most useful for implementation because:
- It connects directly to `Tendsto` in Mathlib
- `C_B(S)` is well-defined in Mathlib as `BoundedContinuousFunction`
- Avoids measure-theoretic complications

---

### 1. The Space ℓ∞([0,1])

**Definition**: Space of bounded functions on [0,1] with sup norm
```
ℓ∞([0,1]) = {f : [0,1] → ℝ | sup_{t∈[0,1]} |f(t)| < ∞}
‖f‖_∞ = sup_{t∈[0,1]} |f(t)|
```

**Key properties**:
- **Non-separable** — No countable dense subset
- **Banach space** — Complete normed vector space
- **Not σ-compact** — Complicates measure theory

**Why it's hard**:
- Standard probability theory assumes separability
- Borel σ-algebra on non-separable spaces behaves badly
- Need **empirical process theory** approach (Dudley, 1985)

---

### 2. Prokhorov's Theorem

**Classical form** (for separable metric spaces):
```
Let {Pₙ} be probability measures on separable metric space (S, d).
{Pₙ} is tight ⟺ every subsequence has a weakly convergent subsequence.
```

**For ℓ∞([0,1])** (van der Vaart & Wellner, 1996):
- Need special treatment due to non-separability
- Use **finite-dimensional convergence** + **tightness**
- Tightness via **equicontinuity** (Arzelà-Ascoli)

**Implementation requirements**:
1. Define probability measures on function spaces
2. Define tightness relative to compact sets
3. Prove relative compactness characterization
4. Connect to weak convergence

---

### 3. Finite-Dimensional Convergence

**Definition**: A sequence of stochastic processes {Xₙ} converges
**finitely** to X if for all finite sets {t₁, ..., tₖ}:
```
(Xₙ(t₁), ..., Xₙ(tₖ)) ⇒ (X(t₁), ..., X(tₖ))     in ℝᵏ
```

**Why it matters**:
- ℝᵏ is separable — standard theory applies
- Cramér-Wold device reduces to 1D convergence
- CLT for dependent data (El Machkouri-Volny-Wu) applies

**What's needed**:
- Cramér-Wold theorem
- Multivariate CLT under mixing
- Covariance matrix convergence

---

### 4. Tightness via Arzelà-Ascoli

**Arzelà-Ascoli Theorem**:
```
Let F ⊆ C([0,1]) be a family of continuous functions.
F is relatively compact (in sup norm) ⟺
  (1) F is equicontinuous, and
  (2) sup_{f∈F} |f(0)| < ∞
```

**For empirical processes**:
- Need **modulus of continuity**: ω(δ) = sup_{|s-t|<δ} |Xₙ(s) - Xₙ(t)|
- Show P(ω(δ) > ε) → 0 for each ε > 0
- Use Lipschitz/Hölder bounds from IsKernel

---

## Implementation Strategy

### Phase A: Foundational Definitions (Weeks)

```lean
-- Empirical process space
def EmpiricalProcessSpace (domain : Set ℝ) := {f : domain → ℝ // BddAbove (Set.range |f|)}

-- Probability measure on this space
structure ProbabilityMeasureOn (α : Type) [MeasurableSpace α] where
  measure : Measure α
  isProbability : measure univ = 1

-- Weak convergence: Pₙ ⇒ P iff ∫ f dPₙ → ∫ f dP for all bounded continuous f
def WeakConvergesTo {α : Type} [MeasurableSpace α]
    (Pₙ : ℕ → ProbabilityMeasureOn α) (P : ProbabilityMeasureOn α) : Prop :=
  ∀ f : α → ℝ, Continuous f → Bounded f →
    Tendsto (λ n => ∫ a, f a ∂(Pₙ n).measure) atTop (𝓝 (∫ a, f a ∂P.measure))

-- Tightness
def IsTight {α : Type} [MeasurableSpace α] [TopologicalSpace α]
    (Pₙ : ℕ → ProbabilityMeasureOn α) : Prop :=
  ∀ ε > 0, ∃ K : Set α, IsCompact K ∧ ∀ n, Pₙ n (Kᶜ) < ε
```

### Phase B: Prokhorov's Theorem (Months)

```lean
theorem Prokhorov {α : Type} [MeasurableSpace α] [MetricSpace α] [Separable α]
    {Pₙ : ℕ → ProbabilityMeasureOn α} :
    IsTight Pₙ ↔ RelativeCompact (seq Pₙ) := by
  -- Huge proof involving:
  -- 1. Tightness ⟹ existence of convergent subsequences
  -- 2. Relative compactness ⟹ tightness via contrapositive
  sorry
```

**Note**: This requires **separability**, which ℓ∞([0,1]) does NOT have!

### Phase C: Non-Separable Extension (Major Research)

For ℓ∞ specifically, we need:
1. **Dudley's approach**: Use finite approximations
2. **Outer probability measures**: Handle measurability issues
3. ** Hoffmann-Jørgensen theory**: Replace almost sure convergence

This is **research-level** mathematics that would be a genuine contribution.

---

## What Can Be Done Now

### Immediate (Building Blocks)

1. **Define the components**:
   - `EmpiricalProcess` type
   - `ProbabilityMeasureOn` structure
   - `IsTight` definition

2. **Prove basic properties**:
   - Tightness implies boundedness in probability
   - Continuous mapping theorem (simple form)

3. **Connect to existing library**:
   - Use Mathlib's `C(α, β)` for continuous functions
   - Use `BoundedContinuousFunction` for test functions

### Short-term (Weeks-Months)

1. **Prove Arzelà-Ascoli**:
   ```lean
theorem ArzelaAscoli {F : Set (C([0,1], ℝ))} :
    IsCompact (closure F) ↔ EquicontinuousOn F ∧ BddAbove (λ f => ‖f‖) F := by
   ```

2. **Finite-dimensional convergence**:
   ```lean
def FiniteDimConverges {Xₙ : ℕ → ℝ → ℝ} {X : ℝ → ℝ} : Prop :=
  ∀ (k : ℕ) (t : Fin k → ℝ), Tendsto (λ n => (Xₙ (t 0), ..., Xₙ (t (k-1)))) ...
   ```

3. **Connect CLT to Gaussian processes**:
   ```lean
theorem_CLT_implies_Gaussian {Xₙ} (h_clt : Tendsto √n(F̂ₙ - F) ...):
   ∃ Z : GaussianProcess, Tendsto Xₙ ... Z := by
   ```

### Long-term (Months-Years)

1. **Full Prokhorov theorem for ℓ∞**
2. **Complete weak convergence framework**
3. **Functional delta method**
4. **Contribution to Mathlib**

---

## References for Implementation

### Primary Sources

1. **Billingsley, P. (1999)**. *Convergence of Probability Measures* (2nd ed.).
   - ISBN: 978-0-471-19745-4
   - **Chapter 2**: The space ℓ∞([0,1])
   - **Chapter 5**: Prokhorov's theorem

2. **van der Vaart, A. W., & Wellner, J. A. (1996)**.
   *Weak Convergence and Empirical Processes: With Applications to Statistics*.
   - DOI: 10.1007/978-1-4757-2545-2
   - **Chapter 1.3**: Weak convergence in ℓ∞
   - **Theorem 1.3.9**: Prokhorov's theorem for empirical processes

3. **Dudley, R. M. (1985)**. *An extended Wichura theorem, definitions
   of Donsker class, and weighted empirical distributions*.
   - In: *Probability in Banach Spaces V*. Springer.
   - Extension of Donsker theorem to non-separable spaces

### Supporting Mathematics

4. **Dudley, R. M. (2002)**. *Real Analysis and Probability*.
   - ISBN: 978-0-521-80972-6
   - **Chapters 9, 11**: Metric-space topology and measure theory

5. **Pollard, D. (1990)**. *Empirical Processes: Theory and Applications*.
   - NSF-CBMS Regional Conference Series
   - Alternative approach to empirical process theory

---

## Separability and the Lévy-Prokhorov Metric

### Crucial Fact: ℓ∞([0,1]) is **NOT Separable**

**Definition**: A topological space is **separable** if it has a countable dense subset.

**Why ℓ∞([0,1]) is not separable**:
- Consider the family of characteristic functions 1_{[0,a]} for a ∈ [0,1]
- These are all in ℓ∞ (as they are bounded by 1)
- ‖1_{[0,a]} - 1_{[0,b]}‖_∞ = 1 for a ≠ b
- Uncountably many functions at distance ≥ 1 from each other
- No countable dense set can exist

**Implications**:
- The space 𝒫(S) of probability measures is not metrizable by Lévy-Prokhorov
- Standard Prokhorov theorem does NOT directly apply
- Need **Dudley's extended theorem** or **Hoffmann-Jørgensen theory**

---

### Lévy-Prokhorov Metric

**Definition**: For probability measures μ, ν on metric space (S, d):
```
π(μ, ν) = inf{ε > 0 | ∀ measurable A, μ(A) ≤ ν(A^ε) + ε}
```
where A^ε = {x ∈ S | dist(x, A) < ε} is the ε-neighborhood.

**Properties**:
- Metrizes weak convergence on **separable** metric spaces
- 𝒫(S) is separable, complete, compact iff S is
- For **non-separable** spaces: need alternative approach

**In Mathlib**: Not currently implemented (would require ~2-3 months)

---

## Comparison: Vague vs Weak Convergence

From Wikipedia, these differ in test functions:

| Convergence | Test Functions | When Equivalent |
|-------------|----------------|---------------|
| **Vague** | C_c(X) (compact support) | Not for probability measures |
| **Weak** | C_B(X) (bounded continuous) | Probability context |

**For probability measures**: Vague + Tight ⟺ Weak

**Why this matters**:
- Empirical processes need weak convergence (bounded continuous test functions)
- Vague convergence is insufficient for 𝒫([]0,1])
- Tightness bridges the gap (hence critical)

---

## Weak Convergence as Weak-* Convergence

**Functional Analysis Connection** (from Wikipedia):
- Weak convergence of measures = **Weak-* convergence** of linear functionals
- Via Riesz-Representation: M(X) ≅ C_0(X)*
- For **compact** X: C_0(X) = C_B(X)

**Implication for ℓ∞**:
- ℓ∞([0,1]) is the dual of ℓ¹ (technically)
- But empirical process theory uses different approach
- The weak-* topology is not sufficient for probability applications

---

## Assessment

### Can We Build This?

| Component | Difficulty | Time Estimate |
|-----------|------------|---------------|
| Basic definitions | 🟡 Medium | 1-2 weeks |
| Arzelà-Ascoli theorem | 🟡 Medium | 2-4 weeks |
| Finite-dimensional convergence | 🔴 Hard | 1-2 months |
| Prokhorov (separable) | 🔴 Hard | 2-3 months |
| Prokhorov (ℓ∞) | ⚫ Research | 6-12 months |
| Full weak convergence framework | ⚫ Research | 1-2 years |

### Recommendation

**Start with the building blocks**:
1. Define `IsTight` and basic properties
2. Prove Arzelà-Ascoli (this is standard analysis)
3. Set up finite-dimensional convergence framework
4. Document gaps — acknowledge where infrastructure is missing

**For the hard parts**: 
- Create documented axioms with clear statements
- Write the structure/proof strategy
- Acknowledge this requires significant additional work

---

## Next Steps (Proposed)

1. **Define `IsTight`** as a concept (not just axiom)
2. **Prove tightness ⟹ boundedness** in probability
3. **Set up finite-dimensional distribution framework**
4. **Document the remaining gap** (Prokhorov for ℓ∞)

This would give us:
- ✅ Clear definitions
- ✅ Understandable proof structure
- ⚠️ Acknowledged gaps where work remains
- 📋 Roadmap for future development

---

**Document Status**: Research Complete  
**Recommendation**: Proceed with foundational definitions  
**Estimated Phase Duration**: 2-4 weeks for building blocks
