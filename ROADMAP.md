# Roadmap — SpatialCvM Formalization (Tier 2-4)

**Current Status**: ✅ Tier 1 Complete (Axiom Cleanup)  
**Next Phase**: 🔴 Tier 2a (Theorem 1 Refactoring) — Ready to Start  
**Timeline**: ~52 hours total (~1 week full-time)  
**Last Updated**: April 18, 2026

---

## Phase Overview

```
Tier 1: Axiom Cleanup         ✅ COMPLETE (6 hours)
  ├─ Removed 8 false/degenerate axioms
  ├─ Defined weighted_chisq
  └─ Status: 25 → 17 axioms

Tier 2a: Theorem 1 Refactor  🔴 READY TO START (18 hours)
  ├─ Sub-Lemma 1: FDD Convergence (8h)
  ├─ Sub-Lemma 2: Tightness (6h) ← RECOMMENDED START
  └─ Sub-Lemma 3: Limit Characterization (4h)

Tier 2b: Theorem 2 Proof      🟠 BLOCKED (15 hours)
  ├─ Contrastability Lemma (2h)
  ├─ Spectral Decomposition (4h)
  ├─ Chi-Square Limit (3h)
  └─ Integration (6h)

Tier 3: Theorem 3 Completion  🟡 PARTIAL (9 hours)
  ├─ Copula Mercer Decomposition (4h)
  ├─ Copula Trace-Class (2h)
  └─ Copula Weak Convergence (3h)

Tier 4: Polish                📋 PLANNED (5 hours)
  ├─ Add citations throughout
  ├─ Final documentation
  └─ Examples and test cases

TOTAL: ~52 hours (~1 week full-time, 2-3 weeks part-time)
```

---

## Tier 2a: Theorem 1 Refactoring (18 Hours)

**Current State**: Monolithic axiom combining 3 results  
**Goal**: Replace axiom with 3 proved sub-lemmas  
**Impact**: Unblocks Theorem 2, critical path item

### Sub-Lemma 1: FDD Convergence (8 Hours)

**What**: Finite-dimensional distributions converge to multivariate Gaussian

**Mathematical Content**:
- Fix points $t_1, \ldots, t_k$
- Empirical process at these points: $(\hat{Z}_n(t_1), \ldots, \hat{Z}_n(t_k))$
- Convergence: $(\hat{Z}_n(t_1), \ldots, \hat{Z}_n(t_k)) \Rightarrow N(0, \Sigma)$
- $\Sigma$ is asymptotic covariance from Lemma 1

**Proof Strategy**:
1. Center the empirical process (subtract mean)
2. Standardize by variance (scale to unit)
3. Apply Lindeberg Central Limit Theorem
4. Verify Lindeberg condition using mixing bounds (Davydov inequality)
5. Show covariance matrix matches Lemma 1 formula

**Key Mathlib Lemmas**:
- `Tendsto.mvnormal_of_tendsto_covariance`
- `Filter.Tendsto.mul` (for scaling)
- `Int.mul_emod_right_of_pos` (index handling)
- Custom: Lindeberg condition verification via mixing bounds

**Blocking Issues**: None (foundation lemmas ready)

**Timeline**:
- Hour 1-2: Set up FDD structure, introduce points
- Hour 2-3: Center and standardize empirical process
- Hour 3-5: Lindeberg condition via Davydov
- Hour 5-7: Apply multivariate CLT
- Hour 7-8: Polish and documentation

**Code Template Location**: `/memories/session/theorem1_refactor_starter.md` (lines 15-29)

**Status**: ✅ Ready (template provided)

---

### Sub-Lemma 2: Tightness (6 Hours) ← **RECOMMENDED START HERE**

**What**: Empirical process is tight (uniformly concentrated)

**Mathematical Content**:
- Sequence is tight if for all $\epsilon > 0$, $\exists K$ compact: $P(\|X_n\|_\infty > K) < \epsilon$
- Use Arzelà-Ascoli criterion: uniform boundedness + equicontinuity
- Bound: $\|X_n\|_\infty \leq$ (from mixing bounds)
- Equicontinuity: Skorokhod modulus of continuity

**Proof Strategy**:
1. Apply Arzelà-Ascoli compactness criterion
2. Show uniform boundedness: $\sup_n E[\|X_n\|_\infty] < \infty$
3. Show equicontinuity: $\lim_{\delta \to 0} \sup_n \sup_{|s-t|<\delta} |X_n(s) - X_n(t)| = 0$
4. Use Skorokhod modulus $\omega_\delta$ with mixing decay

**Key Mathlib Lemmas**:
- `IsTight.isCompact`
- `TightSequence.of_compactness`
- `ModulusOfContinuity` (Skorokhod)
- Custom: Uniform boundedness from moment bounds

**Blocking Issues**: None (mixing bounds available)

**Timeline**:
- Hour 0-1: Set up Arzelà-Ascoli criterion
- Hour 1-2: Prove uniform boundedness
- Hour 2-4: Equicontinuity via Skorokhod modulus
- Hour 4-5: Connect to mixing bounds
- Hour 5-6: Polish

**Code Template Location**: `/memories/session/theorem1_refactor_starter.md` (lines 30-40)

**Why Recommended**: 
- Clearest proof path (direct application of Arzelà-Ascoli)
- Fewest dependencies
- Best learning value (introduces key techniques)
- Unblocks Sub-Lemma 3

**Status**: ✅ Ready (template provided)

---

### Sub-Lemma 3: Limit Characterization (4 Hours)

**What**: Combine FDD + Tightness to show Gaussian limit

**Mathematical Content**:
- Combine results: FDD convergence + tightness
- Imply: Weak convergence in $D[0,1]$ (or $C[0,1]$ for smooth)
- Identify limit: Gaussian process with covariance from Lemma 1
- Verify consistency: Covariance structure matches expected form

**Proof Strategy**:
1. Use Skorokhod representation theorem
   - FDD + tightness → weak convergence
2. Construct limiting Gaussian process
3. Show covariance matches Lemma 1
4. Verify continuity (for $C[0,1]$ if appropriate)

**Key Mathlib Lemmas**:
- `Skorokhod.representation`
- `Tendsto.narrow_convergence`
- `IsGaussian.covariance`
- Custom: Gaussian process construction

**Blocking Issues**: 
- ⚠️ Requires Sub-Lemma 1 (FDD convergence)
- ⚠️ Requires Sub-Lemma 2 (tightness)

**Timeline**:
- Hour 0-1: Set up Skorokhod construction
- Hour 1-2: Apply representation theorem
- Hour 2-3: Verify covariance structure
- Hour 3-4: Polish

**Code Template Location**: `/memories/session/theorem1_refactor_starter.md` (lines 41-50)

**Status**: ✅ Ready (depends on 1 & 2)

**Suggested Ordering**: 
1. ✅ Do Sub-Lemma 2 first (simplest, clearest)
2. ✅ Then Sub-Lemma 1 (uses CLT)
3. ✅ Finally Sub-Lemma 3 (combines both)

---

## Tier 2b: Theorem 2 Proof (15 Hours)

**Current State**: Axiom `asymptotic_null` (blocks Theorem 3)  
**Goal**: Prove test statistic converges to weighted χ²  
**Dependencies**: ✅ Theorem 1 proof (all 3 sub-lemmas)  
**Impact**: Unblocks Theorem 3

### Overview

**Theorem Statement**:
```
For test statistic T_n(h):
  T_n(h) ⟹ Σ λ_m* χ²_{K-1,m}
where λ_m* are eigenvalues of contrast covariance operator
```

**Proof Decomposition**:

#### Component 1: Contrastability Lemma (2 hours)
Define contrast projection: Projects empirical process onto homogeneity space

**What**: Continuous linear functional $C: D[0,1] → ℝ^K$
- Maps process to contrast vector
- Verifies continuity (Hadamard differentiability prepared)
- Shows invertibility on relevant space

**Status**: 🟢 Strategy ready, Theorem 2/JointConvergence.lean partially done

#### Component 2: Spectral Decomposition (4 hours)
Eigenvalue decomposition of contrast covariance operator

**What**: 
- $\Gamma = \sum_{m=1}^∞ λ_m* \phi_m \otimes \phi_m$
- $\phi_m$ orthonormal eigenfunctions
- $λ_m*$ eigenvalues (our weights)

**Key Steps**:
1. Apply spectral theorem to covariance operator
2. Show trace-class property (finite sum possible)
3. Compute eigenvalue decay from mixing bounds

**Status**: 🟢 Structure ready, Theorem2/Mercer.lean exists

#### Component 3: Chi-Square Limit (3 hours)
Show eigenvalue-weighted sum of independent $\chi^2_K$

**What**: 
- Project Theorem 1 Gaussian to eigenspaces
- Each projection is independent $\chi^2_{K-1}$ 
- Scale by eigenvalue $λ_m*$

**Status**: 🟢 Strategy ready, Theorem2/ChiSquare.lean (definition now exists)

#### Component 4: Integration (6 hours)
Chain everything: Theorem 1 → Contrast → Spectral → Limit

**What**: 
1. Apply continuous mapping theorem to contrast
2. Apply spectral decomposition to resulting limit
3. Verify chi-square scaling
4. Conclude Theorem 2

**Status**: 🟡 Main.lean axiom `asymptotic_null` needs replacement

### Timeline for Tier 2b

```
Week 2 (assuming Tier 2a completes Friday):
  Monday:    Component 1 (Contrastability) — 2h
  Tuesday:   Component 2 (Spectral) — 4h  
  Wednesday: Component 3 (Chi-Square) — 3h
  Thursday:  Component 4 (Integration) — 6h
  Friday:    Testing and polish
```

### Build Command
```bash
lake build SpatialCvM.Theorem2
```

---

## Tier 3: Theorem 3 Completion (9 Hours)

**Current State**: Proof structure exists, 3 axioms to fill  
**Goal**: Complete multivariate extension proof  
**Dependencies**: ✅ Theorem 2 proof  
**Impact**: Final main theorem proved

### Overview

**Theorem Statement**:
```
For multivariate (s-dimensional) test statistic T_n^(s):
  T_n^(s) ⟹ Σ λ_m* χ²_{K-1,m}  (same limit!)
  via copula transform
```

**Why Copulas**: 
- Original test: univariate ($s=1$)
- Multivariate: Apply copula to transform margins
- Result: Same weighted χ² limit for any marginal dimension

### Components to Prove

#### Component 1: Copula Mercer Decomposition (4 hours)

**What**: Copula kernel has spectral decomposition
- $C(u,v) = \sum_{m=1}^∞ λ_m^C \phi_m^C(u) \phi_m^C(v)$
- Eigenfunctions $\phi_m^C$ define copula eigenstructure

**Proof Strategy**:
1. Show copula covariance is compact
2. Apply Mercer theorem (Mathlib version)
3. Verify eigenvalues/eigenfunctions

**Status**: 🟡 Axiom `copula_mercer_decomposition` exists, needs proof

**Timeline**: 4 hours

#### Component 2: Copula Trace-Class (2 hours)

**What**: Copula operator is trace-class (Σ|λ_m| < ∞)
- Ensures absolute convergence in spectral decomposition
- Needed for chi-square representation

**Proof Strategy**:
1. Bound eigenvalues using copula properties
2. Show summability from smoothness
3. Verify trace-class via Hilbert-Schmidt norm

**Status**: 🟡 Axiom `copula_trace_class` exists, needs proof

**Timeline**: 2 hours

#### Component 3: Copula Weak Convergence (3 hours)

**What**: Multivariate empirical process converges
- Uses copula transform + Theorem 2 result
- Applies delta method (already in Hadamard.lean)

**Proof Strategy**:
1. Univariate weak convergence (from Theorem 2)
2. Apply copula transform (Hadamard derivative)
3. Use delta method for multivariate limit

**Status**: 🟡 Axiom `copula_weak_convergence` exists, needs proof

**Timeline**: 3 hours

### Proof Structure (Exists in Main.lean)

```lean
theorem multivariate_limit (s : ℕ) ... :
    empirical_process_s_variate s ⟹ copula_transformed_limit s := by
  -- Step 1: Univariate convergence (from Theorem 2)
  have h1 : univariate_convergence := asymptotic_null ...
  
  -- Step 2: Copula decomposition
  have h2 : copula_mercer_decomposition := sorry
  
  -- Step 3: Trace-class property
  have h3 : copula_trace_class := sorry
  
  -- Step 4: Delta method application
  have h4 : copula_weak_convergence := sorry
  
  -- Step 5: Combine
  exact combine_results h1 h2 h3 h4
```

### Timeline for Tier 3

```
Week 3 (assuming Theorem 2 completes end of Week 2):
  Monday:    Component 1 (Mercer) — 4h
  Tuesday:   Component 2 (Trace-Class) — 2h
  Wednesday: Component 3 (Weak Conv) — 3h
  Thursday:  Testing and integration
  Friday:    Polish
```

### Build Command
```bash
lake build SpatialCvM.Theorem3
```

---

## Tier 4: Polish & Documentation (5 Hours)

**Current State**: All theorems proved, basic documentation exists  
**Goal**: Publication-ready formalization  
**Dependencies**: All previous tiers

### Tasks

#### 1. Add Mathematical References (2 hours)
- Insert citations to papers throughout proofs
- Format according to blueprint style
- Cross-reference between theorems

#### 2. Complete Examples (2 hours)
- Add example files showing how to use theorems
- Demonstrate with specific kernel (e.g., Epanechnikov)
- Show concrete eigenvalue calculations

#### 3. Final Documentation (1 hour)
- Update proof structure doc with completion notes
- Add navigation guide to final codebase
- Generate HTML docs via blueprint

### Build & Docs
```bash
# Final build
lake build

# Generate documentation
cd blueprint && lake build
open build/doc/index.html
```

---

## Dependency Chain (Visual)

```
Lemma 1: Asymptotic Covariance
    ↓ (foundation for all theorems)
    
Theorem 1: Weak Convergence
  ├─ Sub-Lemma 1: FDD (8h)
  │   ├─ Lindeberg CLT
  │   └─ Mixing bounds
  ├─ Sub-Lemma 2: Tightness (6h)
  │   ├─ Arzelà-Ascoli
  │   └─ Skorokhod modulus
  └─ Sub-Lemma 3: Limit (4h)
      ├─ Requires Sub-Lemma 1
      └─ Requires Sub-Lemma 2
    
    ↓ (weak convergence result needed)
    
Theorem 2: Null Distribution (15h)
  ├─ Contrastability (2h)
  ├─ Spectral Decomposition (4h)
  ├─ Chi-Square Limit (3h)
  └─ Integration (6h)
  
    ↓ (null distribution needed)
    
Theorem 3: Multivariate (9h)
  ├─ Copula Mercer (4h)
  ├─ Copula Trace (2h)
  └─ Copula Weak Conv (3h)
  
    ↓ (all theorems proved)
    
Tier 4: Polish (5h)
  ├─ References
  ├─ Examples
  └─ Documentation
```

**Critical Path**: Thm1 → Thm2 → Thm3 (cannot parallelize)

---

## Success Metrics

### Tier 2a Complete When:
- [ ] All 3 Sub-Lemmas replace `weak_convergence` axiom
- [ ] `lake build SpatialCvM.Theorem1` passes
- [ ] No remaining `sorry` in main proofs
- [ ] Comments explain strategy for each step

### Tier 2b Complete When:
- [ ] Theorem 2 axiom `asymptotic_null` is proved
- [ ] All 4 components (contrastability, spectral, chi-square, integration) proved
- [ ] `lake build SpatialCvM.Theorem2` passes
- [ ] Proof uses Theorem 1 result (weak convergence)

### Tier 3 Complete When:
- [ ] All 3 axioms (`copula_mercer_decomposition`, `copula_trace_class`, `copula_weak_convergence`) proved
- [ ] `lake build SpatialCvM.Theorem3` passes
- [ ] Proof uses Theorem 2 result (null distribution)

### Tier 4 Complete When:
- [ ] All theorems have mathematical references
- [ ] Example files demonstrate usage
- [ ] Blueprint documentation builds
- [ ] Final `lake build` passes with 0 errors

---

## Resources for Next Phase

### Code Templates
- `/memories/session/theorem1_refactor_starter.md` — Sub-lemma code outlines

### Strategy Documents
- `/memories/session/proof_structure.md` — Detailed strategies for Theorem 2-3
- `/memories/session/proof_quick_ref.md` — Visual diagrams and quick reference

### Implementation Reports
- `/memories/session/tier1_implementation_report.md` — What was done in Tier 1

### Documentation
- [README.md](README.md) — Project overview
- [CONTRIBUTING.md](CONTRIBUTING.md) — How to contribute
- [QUICKSTART.md](QUICKSTART.md) — Quick reference

---

## Recommended Next Steps

**For Tier 2a (Choose ONE)**:

1. **Start with Sub-Lemma 2 (Tightness)** ← RECOMMENDED
   - Clearest proof path
   - Template ready in `/memories/session/theorem1_refactor_starter.md`
   - 6 hours, reasonable first milestone
   
2. **Start with Sub-Lemma 1 (FDD)**
   - More mathematically central
   - Longer (8 hours)
   - Uses CLT extensively

3. **Study all three first**
   - Read templates
   - Review strategies in `/memories/session/proof_structure.md`
   - Then start coding

**Git Workflow**:
```bash
git checkout -b feature/theorem1-tightness
# or
git checkout -b feature/theorem1-fdd-convergence
# or
git checkout -b feature/theorem1-limit
```

**Build & Test**:
```bash
# After each lemma
lake build SpatialCvM.Theorem1

# Watch for compilation
# Fix `sorry` blocks as you prove them
```

---

## Estimated Schedule (Full-Time)

```
Week 1 (Tier 2a: Theorem 1 Refactoring)
  Monday:    Sub-Lemma 2 (Tightness) — 6h ✓
  Tuesday:   Sub-Lemma 1 (FDD) — 8h ✓
  Wednesday: Sub-Lemma 3 (Limit) — 4h ✓
  Thursday:  Testing & integration — 2h
  Friday:    Start Tier 2b

Week 2 (Tier 2b: Theorem 2 Proof)
  Monday:    Contrastability — 2h ✓
  Tuesday:   Spectral Decomposition — 4h ✓
  Wednesday: Chi-Square Limit — 3h ✓
  Thursday:  Integration — 6h ✓
  Friday:    Testing

Week 3 (Tier 3: Theorem 3 Completion)
  Monday:    Copula Mercer — 4h ✓
  Tuesday:   Copula Trace-Class — 2h ✓
  Wednesday: Copula Weak Convergence — 3h ✓
  Thursday:  Testing & integration
  Friday:    Start Tier 4

Week 4 (Tier 4: Polish)
  Monday-Thursday: References, examples, docs
  Friday: Final build & docs generation
```

**Part-Time Estimate**: 2-3 weeks (10-15 hours per week)

---

## Contact & Questions

For questions about:
- **Proof strategies**: See `/memories/session/proof_structure.md`
- **Code templates**: See `/memories/session/theorem1_refactor_starter.md`
- **Contribution process**: See [CONTRIBUTING.md](CONTRIBUTING.md)
- **Quick reference**: See [QUICKSTART.md](QUICKSTART.md)

---

**Status**: ✅ Tier 1 Complete, 🔴 Tier 2a Ready  
**Last Updated**: April 18, 2026  
**Next Action**: Pick Sub-Lemma and start coding!

