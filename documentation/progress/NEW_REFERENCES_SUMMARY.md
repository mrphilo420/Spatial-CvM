# Newly Acquired References — April 22, 2025

## Summary

Four critical references were discovered in `\related studies`, all highly relevant to de-axiomatization efforts.

---

## Reference Details

### 1. Sen (2022) — "A Gentle Introduction to Empirical Process Theory"
- **File**: `Emp-Proc-Lecture-Notes.pdf` (1,735 KB, 172 pages)
- **Date Added**: April 22, 2025
- **Contents**:
  - Chapter 1: Introduction to empirical processes
  - Chapter 4: Chaining and uniform entropy (Dudley's bound)
  - Chapter 9: **Weak convergence in complete separable metric spaces**
  - Section 9.1: Weak convergence of random vectors in ℝ^d
  - Section 9.2: Weak convergence in metric spaces and continuous mapping theorem
- **Relevance**: Provides elementary proofs for `prokhorov_theorem` and `gaussian_process_exists`
- **Mathlib Status**: Could inform implementation of weak convergence framework
- **Extraction Priority**: **HIGH** — Extract Chapter 9 for weak convergence theory

---

### 2. Radulović & Wegkamp (2016) — "An elementary proof of weak convergence of empirical processes"
- **File**: `DM.pdf` (258 KB, 20 pages)
- **Date Added**: April 22, 2025
- **Key Innovation**: Simple decoupling argument for proving asymptotic equicontinuity
- **Main Result**: Lemma 3 and Theorem 5 — weak convergence without maximal inequalities
- **Relevance**: 
  - Directly addresses `tightness_via_equicontinuity` axiom
  - Novel approach: Decouple dependence using decoupling argument
  - Works for stationary sequences (not just i.i.d.)
- **Mathlib Status**: Could provide alternative proof path for tightness
- **Extraction Priority**: **HIGH** — Key paper for Theorem 1 tightness

---

### 3. Radulović, Wegkamp & Zhao (2017) — "Weak convergence of empirical copula processes indexed by functions"
- **File**: `DMY_Bernoulli.pdf` (375 KB, 39 pages)
- **Journal**: Bernoulli 23(4B), 2017, 3346–3384
- **DOI**: 10.3150/16-BEJ849
- **Key Assumption**: P-condition (first-order partial derivatives exist/continuous)
- **Main Result**: Weak convergence of empirical copula processes in ℓ^∞
- **Relevance**:
  - **Critical for Theorem 3**: Copula process weak convergence
  - Addresses `copula_hadamard_differentiable` axiom
  - Functional delta method for copulas
  - Generalization to multivariate case
- **Mathlib Status**: Essential for multivariate extension
- **Extraction Priority**: **CRITICAL** — Needed for Theorem 3 implementation

---

### 4. WCEP 2019 Lecture Notes
- **File**: `wcep2019_notes.pdf` (283 KB)
- **Date Added**: April 22, 2025
- **Contents**: Weak convergence and empirical processes educational notes
- **Relevance**: Background material, exercises, examples
- **Extraction Priority**: **MEDIUM** — Supplementary material

---

## Priorities for Extraction

### Immediate (Next Session)
1. **DMY_Bernoulli.pdf** (Radulović, Wegkamp, Zhao 2017)
   - **Why**: Theorem 3 multivariate extension depends on copula process results
   - **What to extract**: Definition of P-condition, copula process convergence, Hadamard differentiability proof
   
2. **DM.pdf** (Radulović & Wegkamp 2016)
   - **Why**: Alternative elementary proof for tightness
   - **What to extract**: Lemma 3 (decoupling), Theorem 5 (weak convergence)

### Short-term (Next Week)
3. **Emp-Proc-Lecture-Notes.pdf**
   - **Why**: Comprehensive weak convergence theory
   - **What to extract**: Chapter 9 (weak convergence in metric spaces)

---

## Connection to Axioms

| Axiom | Primary Reference | Status | New Alternative |
|-------|------------------|--------|-----------------|
| `tightness_via_equicontinuity` | Billingsley (1999) | Documented | Radulović & Wegkamp (2016) ✓ |
| `copula_hadamard_differentiable` | van der Vaart & Wellner (1996) | Not available | Radulović et al. (2017) ✓ |
| `prokhorov_theorem` | Billingsley (1999) | Documented | Sen (2022) + Radulović (2016) ✓ |

---

## Key Insight

The **Radulović & Wegkamp (2016)** paper provides an **elementary** proof of weak convergence that:
- Does not require maximal inequalities
- Works for stationary processes
- Uses decoupling arguments instead of chaining

This could provide an alternative implementation path that is **simpler** than the standard approach, potentially reducing the Mathlib infrastructure needed.

---

## Next Actions

1. **Extract DMY_Bernoulli.pdf** (highest priority — Theorem 3)
2. **Extract DM.pdf** (Theorem 1 tightness alternative)
3. **Map extracted content** to existing axioms in `Hadamard.lean` and `Tightness.lean`
4. **Update** `REFERENCE_REQUIREMENTS.md` with extraction status

---

**Last Updated**: April 22, 2025  
**Discovery**: 4 new references in `\related studies`  
**Critical Find**: Radulović et al. (2017) for copula/Hadamard theory
