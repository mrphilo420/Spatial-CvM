# Quick Start Guide — SpatialCvM Formalization

Get up and running in 5 minutes.

---

## Installation (2 minutes)

```bash
# Clone repo
git clone https://github.com/yourusername/SpatialCvM.git
cd SpatialCvM

# Update Lake dependencies (gets Mathlib)
lake update

# Build project
lake build

# If successful: ✅ You're ready!
# If error: check Lean 4 v4.30.0-rc1 is installed
```

---

## Project at a Glance

**What**: Lean 4 formalization of Spatial Cramer-von Mises test  
**Why**: Prove 3 theorems about asymptotic distribution under fixed bandwidth  
**Current**: Tier 1 complete (axioms cleaned), Theorem 1 needs refactoring  
**Time to Completion**: ~52 hours (1 week full-time)

---

## The 3 Theorems (In 30 Seconds)

```
LEMMA 1 ✅
├─ Asymptotic covariance structure
└─ (Foundation for everything)

THEOREM 1 🔴 (NEEDS WORK: 18 hours)
├─ Empirical process → Gaussian process
├─ Split into: FDD (8h) + Tightness (6h) + Limit (4h)
└─ Uses: Lindeberg CLT + Prokhorov theorem

THEOREM 2 🟠 (BLOCKED by Thm1: 15 hours)
├─ Test statistic → Σ λₘ χ²_{K-1,m}
├─ Uses: Theorem 1 + continuous mapping theorem
└─ Needs: Contrastability + spectral decomposition

THEOREM 3 🟡 (PARTIAL: 9 hours after Thm2)
├─ Multivariate extension via copulas
├─ Proof structure exists (just fill axioms)
└─ Uses: Theorem 2 + delta method
```

---

## File Locations

```
SpatialCvM/
├── SpatialCvM/Theorem1/Main.lean     ← MONOLITHIC AXIOM (refactor needed)
├── SpatialCvM/Theorem2/Main.lean     ← Depends on Theorem 1
├── SpatialCvM/Theorem3/Main.lean     ← Depends on Theorem 2 (partial proof)
├── SpatialCvM/Lemma1/Main.lean       ← Foundation (complete)
└── README.md                          ← Full documentation
```

---

## Common Commands

```bash
# Build everything
lake build

# Build just one theorem module
lake build SpatialCvM.Theorem1

# Check for errors only
lake build 2>&1 | grep "error:"

# Clean and rebuild
lake clean && lake build

# Browse documentation (if blueprint installed)
cd blueprint && lake build
open build/doc/index.html
```

---

## Next Steps

### Option A: Understand the Project
1. Read [README.md](README.md) (5 min)
2. Review [CONTRIBUTING.md](CONTRIBUTING.md) (10 min)
3. Read `/memories/session/proof_structure_complete.md` (15 min)
→ Total: 30 min understanding

### Option B: Start Contributing
1. Pick a sub-lemma (recommend: Tightness, 6 hours)
2. Read `/memories/session/theorem1_refactor_starter.md`
3. Implement using the code templates provided
4. `lake build` to test
5. Commit and create PR

### Option C: Review What's Done
1. Check `/memories/session/tier1_implementation_report.md`
   - Axiom cleanup (8 false/degenerate axioms removed)
   - `weighted_chisq` now properly defined
2. Review changes in git history

---

## Decision Tree: What Should I Do?

```
Are you new to the project?
  ├─ YES → Read README.md + CONTRIBUTING.md (30 min)
  └─ NO → Skip to next

Do you want to contribute code?
  ├─ YES → Go to "Where to Start Contributing"
  └─ NO → Review documentation (5 min)
  
Where to Start Contributing?
  ├─ "I want highest priority work"
  │   └─ Theorem 1, Sub-Lemma 2 (Tightness)
  │       - Clearest proof path
  │       - Code templates ready
  │       - 6 hours estimate
  │
  ├─ "I want foundation work"
  │   └─ Theorem 1, Sub-Lemma 1 (FDD)
  │       - Mathematically central
  │       - Uses Lindeberg CLT
  │       - 8 hours estimate
  │
  └─ "I prefer multivariate stuff"
      └─ Theorem 3 components
          - But wait for Theorem 2 first
          - Read Theorem 2 strategies
```

---

## Key Concepts (2 min)

**Fixed Bandwidth**: Unlike classical stats where bandwidth h → 0, here h stays fixed. Result: Test doesn't go to zero under H₀.

**Non-Consistency**: Test statistic → weighted χ² (not degenerate). This is good for testing!

**Weighted Chi-Square**: Eigenvalues λₘ* weight independent χ²_{K-1} variables. Limit distribution is ∑λₘ* χ²_{K-1,m}.

---

## Proof Strategy Overview

```
Mathematical Result → Lean Proof

1. Lemma 1 (Foundation)
   Covariance integral formula
   → Axiomatize (foundation, OK to assume)

2. Theorem 1 (Weak Convergence)
   Empirical process ⟹ Gaussian
   → Break into 3 pieces:
      (a) FDD: Apply Lindeberg CLT
      (b) Tightness: Apply Arzelà-Ascoli
      (c) Limit: Combine (a) + (b)

3. Theorem 2 (Null Distribution)
   Test ⟹ Weighted χ²
   → Build on Theorem 1:
      (a) Contrast projection
      (b) Eigenvalue decomposition
      (c) Chi-square limit from (a)+(b)

4. Theorem 3 (Multivariate)
   Multivariate test ⟹ Same χ²
   → Use Theorem 2 + copulas:
      (a) Copula covariance structure
      (b) Trace-class bounds
      (c) Delta method application
```

---

## Mathlib Essentials

Key lemmas you'll use frequently:

```lean
-- Convergence
Tendsto (fun n => X n) Filter.atTop (𝓝 x)  -- X_n → x

-- Gaussian distributions
IsGaussian f                                -- f is Gaussian
MultivariateNormal μ Σ                      -- MVN with mean μ, cov Σ

-- Tightness
IsTight (fun n => X n)                      -- Sequence is tight

-- Spectral theory
Eigenvalue T λ                              -- λ is eigenvalue of T
```

---

## Common Patterns

### Pattern 1: Apply CLT
```lean
lemma my_convergence : ... := by
  apply tendsto_multivariate_normal
  · -- Show Lindeberg condition
    sorry
  · -- Show covariance structure
    exact asymptotic_covariance ...
```

### Pattern 2: Apply Continuous Mapping Theorem
```lean
lemma continuous_image : ... := by
  have h_conv : Tendsto Xₙ ... := ... -- weak convergence
  have h_cont : ContinuousAt f x := ... -- f is continuous
  exact Tendsto.comp h_cont h_conv
```

### Pattern 3: Spectral Decomposition
```lean
lemma spectral : ... := by
  obtain ⟨λ, φ, h_eigen, h_orth⟩ := spectral_decomposition T
  -- λ are eigenvalues, φ are eigenfunctions
  -- h_eigen: T(φ_m) = λ_m * φ_m
  -- h_orth: orthonormal basis
```

---

## Debugging Tips

### "lake build" fails with "unknown package"
```bash
lake update  # Ensure Mathlib is downloaded
```

### "lake build" fails with "error: unknown identifier"
```bash
# Check the import
import SpatialCvM.CorrectModule  ✓
import SpatialCvM.WrongModule   ✗

# Check file names match (case-sensitive)
MyFile.lean → import SpatialCvM.MyFile
```

### "Proof doesn't compile"
```lean
-- Use sorry to move forward
theorem my_theorem : P := by
  sorry  -- TODO: implement later
  
-- Check what Mathlib provides
#check Tendsto
#check asymptotic_covariance
```

### "Not sure which Mathlib lemma to use"
- Search GitHub: `grep -r "lemma_name" ~/.elan/toolchains/`
- Try `#check lemma_name`
- Ask in issue or discussion

---

## Resources

- **[README.md](README.md)** — Full project documentation
- **[CONTRIBUTING.md](CONTRIBUTING.md)** — How to contribute
- **[Proof Structure](/memories/session/proof_structure.md)** — Detailed strategies
- **[Quick Reference](/memories/session/proof_quick_ref.md)** — Visual diagrams
- **[Implementation Templates](/memories/session/theorem1_refactor_starter.md)** — Code to get started

---

## Need Help?

1. **Check documentation first** — 80% of answers are in the files above
2. **Read similar proofs** — Look at `Theorem2/Mercer.lean` for spectral examples
3. **Open an issue** — Describe the blocker clearly
4. **Ask in discussions** — For broader questions

---

## Success Checklist: Before You Commit

- [ ] `lake build` completes with 0 errors
- [ ] No remaining `sorry` in main proof (only temporary blockers)
- [ ] Comments explain proof strategy
- [ ] Proof follows the documented strategy
- [ ] Git message describes what was proved
- [ ] PR description cites relevant papers

---

## Next Action

**Pick ONE:**

A) **Run `lake build`** to verify setup (2 min)
   ```bash
   lake update && lake build
   ```

B) **Read README** to understand project (5 min)
   ```bash
   open README.md
   ```

C) **Start implementing** (check Contributing.md first!)
   ```bash
   git checkout -b feature/your-feature
   # Edit files
   lake build
   git commit -m "feat: ..."
   git push origin feature/your-feature
   ```

D) **Review what's been done** (Tier 1)
   ```bash
   cat /memories/session/tier1_implementation_report.md
   ```

---

**Happy Formalizing!** 🎉

