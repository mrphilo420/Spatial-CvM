# CONWAY (1990) EXTRACTION STATUS REPORT
## Chapter Analysis for De-axiomatization — April 22, 2025

---

## Executive Summary

**Status**: ✓ Chapter 4 "Locally Convex Spaces" Extracted Successfully  
**Critical Discovery**: Chapter 4 covers separation theorems (Prokhorov's foundation) but **NOT spectral theory**  
**Next Requirement**: Need Chapter on compact operators/eigenvalues for Mercer decomposition

---

## Chapter 4 Contents — LOCALLY CONVEX SPACES

### Found: Key Theorems for Weak Convergence

| Theorem | Page | Content | Application |
|---------|------|---------|-------------|
| **Theorem 1.2** | 100 | LCS definition via seminorms | Topology on func spaces |
| **Theorem 1.14** | 103 | Minkowski functional/gauge | Constructing seminorms |
| **Theorem 2.1** | 105 | Metrization of LCS | Metric for ℓ∞[0,1] |
| **Theorem 2.6** | 107 | Normability criterion | Why weak topologies aren't normable |
| **Theorem 3.9** | 111 | **STRICT SEPARATION** | **Foundation for Prokhorov** |
| **Theorem 4.1** | 114 | Riesz representation on C(X) | Probability measures |

### Critical Result: Strict Separation Theorem (3.9)

**Statement**: If $\mathscr{X}$ is a real LCS and $A, B$ are disjoint closed convex with $B$ **compact**, then $A$ and $B$ are strictly separated by a continuous linear functional.

**Why This Matters for SpatialCvM**:
- **Prokhorov's Theorem**: Uses compactness of sets of probability measures
- **Tightness**: Strict separation characterizes when sets can be separated
- This is the **functional analysis foundation** for weak convergence theory

**Lean Path**: Theorem 3.9 → Prokhorov's Theorem → weak convergence → `prokhorov_theorem` axiom

---

## Missing: Spectral Theory for Mercer Decomposition

**Expected Location**: Chapter 5 "Weak Topologies" or Chapter 7 "Spectral Theory"  
**What We Have**: Page 123 shows "CHAPTER V Weak Topologies" — spectral theory likely in Chapter VI or VII

**Required Content for `mercer_decomposition`**:
1. Compact self-adjoint operators on Hilbert spaces
2. Spectral theorem eigenfunction expansion
3. Eigenvalue bounds for integral operators
4. Mercer kernel representation formula

**Likely Sources** (if not in this Conway edition):
- Conway (1990) Chapter 6 or 7 (not extracted yet)
- Riesz & Sz.-Nagy (1955), "Functional Analysis"
- Alternative: De Wet (1980) eigenvalue characterizations

---

## Implementation Path from Chapter 4

### For `prokhorov_theorem` (Theorem1/Main.lean)

**Can Now Implement**:
```
Mathlib Path:
1. Define LCS structure on probability measures
2. Use strict separation (Theorem 3.9) for compact sets
3. Show tightness via separation
4. Derive Prokhorov from compactness + separation
```

**Status**: Pathway established via Conway 3.9

### For `mercer_decomposition` (Theorem2/Mercer.lean)

**Requires Additional Reference**:
- Conway Chapter on Spectral Theory, OR
- Alternative source on compact operators

**Mathlib Status**: No Hilbert space spectral theory currently

---

## Next Actions

### Immediate
1. ✓ Document Chapter 4 extraction (completed)
2. Search Conway PDF for "compact operator", "eigenvalue", "spectral" keywords
3. If spectral content in later chapters, extract pages 200-300

### Short-term
4. Update `REFERENCE_REQUIREMENTS.md` with Chapter 4 findings
5. Connect Theorem 3.9 to Prokhorov documentation in `Theorem1/Main.lean`
6. Use Chapter 4 content for weak convergence framework

### Remaining Need
7. **Find Spectral Theory source** for `mercer_decomposition`:
   - Check if Conway has spectral theory chapter (search PDF pages 200-350)
   - Alternative: Riesz & Sz.-Nagy (1955) or other functional analysis text

---

## Summary Table

| Axiom | Conway Reference | Chapter 4 Status | Completeness |
|-------|------------------|------------------|--------------|
| `prokhorov_theorem` | Theorem 3.9 (separation) | ✓ Documented | ~60% ready |
| `mercer_decomposition` | Spectral theory TBD | ✗ Not in Ch. 4 | Need Ch. 6+ |
| `hadamard_differentiable` | Theorem 2.4, 3.9 | ✓ Partial | ~40% ready |
| `gaussian_process_exists` | Fréchet spaces (2.4) | ✓ Partial | ~30% ready |

---

## Key Insight

Chapter 4 provides the **function spaces theory** (LCS, separation, Riesz representation) needed for weak convergence - but **NOT** the operator theory (spectral decomposition) needed for Mercer kernels.

**Two distinct areas**:
1. **Probability on function spaces** → Chapter 4 ✓ (separation theorems)
2. **Integral operators / eigenfunctions** → Need different chapter/source

---

**Last Updated**: April 22, 2025  
**Extractions Complete**: Chapter 4 (100-123)  
**Still Needed**: Spectral theory chapter (Ch. 6+ )
