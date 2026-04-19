# Contributing to Spatial CvM Formalization

Thank you for your interest in contributing to this Lean 4 formalization of spatial statistics! This guide will help you get started.

---

## Getting Started

### 1. Understand the Project
- Read [README.md](README.md) for project overview
- Review the proof structure in `/memories/session/proof_structure.md`
- Understand the dependency chain: Lemma 1 → Theorem 1 → Theorem 2 → Theorem 3

### 2. Set Up Your Environment

```bash
# Clone the repository
git clone https://github.com/yourusername/SpatialCvM.git
cd SpatialCvM

# Update dependencies
lake update

# Build to verify setup
lake build
```

### 3. Choose What to Work On

**Current Priorities** (in order):

1. **Theorem 1 Sub-Lemmas** (HIGHEST PRIORITY)
   - FDD Convergence (8 hours)
   - Tightness (6 hours)
   - Limit Characterization (4 hours)
   - See: `/memories/session/theorem1_refactor_starter.md`

2. **Theorem 2 Components** (depends on Theorem 1)
   - Contrastability Lemma
   - Spectral Decomposition
   - Chi-Square Limit

3. **Theorem 3 Sub-Axioms** (depends on Theorem 2)
   - Copula Mercer Decomposition
   - Copula Trace-Class
   - Copula Weak Convergence

4. **Support & Utility Lemmas**
   - Strengthen axioms with proofs
   - Add Mathlib references
   - Improve documentation

---

## Development Workflow

### Creating a Feature Branch

```bash
# Create and switch to new branch
git checkout -b feature/your-feature-name

# Examples:
git checkout -b feature/theorem1-fdd-convergence
git checkout -b feature/theorem2-spectral-decomposition
git checkout -b feature/theorem3-copula-mercer
```

### Making Changes

**File Organization**:
- Keep related lemmas in same file
- Use meaningful file names (e.g., `FiniteDimensional.lean` for FDD lemmas)
- Group by theorem/topic

**Code Style**:

```lean
-- ✅ GOOD: Clear naming and structure

-- FDD Convergence Lemma
-- Strategy: Apply Lindeberg CLT to kernel evaluations at fixed points
lemma fdd_convergence (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) ...
    (h_kern : IsKernel K) :
    ∀ (pts : List ℝ),
    empirical_process_vector K h n pts ⟹ multivariate_gaussian pts := by
  intro pts
  -- Step 1: Fix the points
  let t := pts
  -- Step 2: Apply CLT
  apply tendsto_multivariate_normal
  · -- Lindeberg condition
    sorry  -- TODO: Show Lindeberg holds for bounded kernels
  · -- Covariance matrix
    sorry  -- TODO: Compute from Lemma 1
  sorry

-- ❌ AVOID: Vague naming and structure
lemma lem1 (K : ℝ → ℝ) ... := by sorry
```

**Comments & Documentation**:

```lean
-- Explain WHAT you're proving and WHY
-- State the mathematical theorem being formalized
-- Reference key Mathlib lemmas

-- THIS LEMMA PROVES: Finite-dimensional distribution convergence
-- Mathematical theorem: For fixed points t₁,...,tₖ,
--   (Ẑₙ(t₁), ..., Ẑₙ(tₖ)) ⟹ N(0, Σ)
-- where Σ is the asymptotic covariance matrix
-- Key steps: Lindeberg CLT + mixing bounds (Davydov)
-- References: van der Vaart & Wellner (1996), Rio (1993)

lemma fdd_convergence ... := by
  sorry
```

**Proof Style**:

```lean
-- Use structured proofs for clarity
lemma my_theorem (h1 : P) (h2 : Q) : R := by
  -- Step 1: Establish base fact
  have h3 : S := by
    apply some_lemma
    exact h1
  -- Step 2: Apply key theorem
  have h4 : T := by
    apply another_lemma
    · exact h2
    · exact h3
  -- Step 3: Conclude
  exact conclude h4

-- Use focused goals (·) for readability
lemma my_theorem ... := by
  refine ⟨?_, ?_, ?_⟩
  · -- First goal
    sorry
  · -- Second goal
    sorry
  · -- Third goal
    sorry
```

### Testing Your Changes

```bash
# Build just your file
lake build SpatialCvM.YourModule

# Build the full project
lake build

# Check for errors
lake build 2>&1 | grep "error:"

# Clean and rebuild (if needed)
lake clean && lake build
```

### Committing Your Work

```bash
# Stage changes
git add SpatialCvM/YourModule.lean

# Commit with clear message
git commit -m "feat: Prove FDD convergence via Lindeberg CLT

- Implement Lindeberg condition for bounded kernels
- Apply multivariate CLT to empirical process
- Fix point set at t₁, ..., tₖ
- Reference: van der Vaart & Wellner (1996) Chapter 2"

# Push to branch
git push origin feature/your-feature-name
```

**Commit Message Guidelines**:
- Start with type: `feat`, `fix`, `docs`, `refactor`
- Clear description of what was proved
- Reference relevant papers/lemmas in body
- Mention any blocking issues

---

## Pull Request Process

### 1. Create Pull Request

```bash
# After pushing, create PR on GitHub
# Title: "feat: Prove Theorem X, Step Y"
# Description: Explain what was proved and why
```

### 2. PR Description Template

```markdown
## What This Proves
Brief description of the mathematical result.

## Strategy
High-level proof approach.

## Key Lemmas Used
- `lemma_from_mathlib`
- `previously_proved_lemma`

## References
- Van der Vaart & Wellner (1996)
- Rio (1993)

## Blocks/Unblocks
- Unblocks: Theorem 2 (once Theorem 1 complete)
- Depends on: Theorem 1 (Sub-Lemma 1)

## Build Status
- [x] `lake build` passes
- [x] No remaining `sorry` in main proof
- [x] Documented with comments
```

### 3. Code Review

- Ensure proof is mathematically sound
- Check Mathlib lemma usage is correct
- Verify comments explain the strategy
- Confirm no spurious axioms introduced

### 4. Merge

Once approved, PR will be merged to `main`.

---

## Handling Blockers

### "I'm stuck on a proof step"

1. **Axiomatize it temporarily**:
```lean
lemma my_lemma : P := by
  sorry  -- TODO: Use Lindeberg CLT from Mathlib.Probability
  -- For now, treat this step as an axiom
  -- Comment explains what needs proving
```

2. **Keep main structure intact**:
   - Don't abandon the whole lemma
   - Mark blocked pieces with `sorry` + comment
   - Continue with next steps

3. **Ask for help**:
   - Open an issue describing the blocker
   - Link to relevant Mathlib lemmas
   - Share minimal reproducible example

### "This requires an axiom that doesn't exist"

1. **Check Mathlib thoroughly**:
```bash
# Search Mathlib for related lemmas
lake env lean --run "
open Lean Elab Command in
#check Tendsto.mvnormal
"
```

2. **If truly needed, define it**:
```lean
-- Add to Utils/Asymptotics.lean or appropriate file
axiom my_axiom (P Q : Prop) (h : P) : Q := by sorry

-- Add comment explaining what's needed
-- Reference: SomeAuthor (Year), Theorem X.Y
```

3. **Document in README**:
   - Add to Axioms section
   - Explain why it's necessary
   - Plan for eventual proof

---

## Best Practices

### ✅ DO

- **Break lemmas into small, provable pieces**
  - Each lemma: 1-2 hours max
  - Clear, focused goals
  
- **Comment generously**
  - Explain proof strategy before proving
  - Reference relevant theorems
  - Cite papers

- **Test frequently**
  - Build after each lemma
  - Don't let errors accumulate

- **Reference Mathlib extensively**
  - Use existing lemmas where possible
  - Avoid reproving standard results

- **Keep the dependency chain clean**
  - No circular dependencies
  - Respect the Lemma 1 → Thm 1 → Thm 2 → Thm 3 order

### ❌ DON'T

- **Create monolithic axioms**
  - Break them into sub-lemmas
  - Make each step verifiable

- **Leave `sorry` without comments**
  - Always explain what's missing
  - Reference relevant Mathlib lemmas

- **Skip the proof structure documentation**
  - Update `/memories/session/proof_structure.md`
  - Add implementation notes

- **Prove things that exist in Mathlib**
  - Search thoroughly first
  - Use `exact mathlib_lemma`

- **Introduce new axioms casually**
  - Discuss in issues first
  - Document thoroughly

---

## Documentation Expectations

### For Each Lemma

1. **High-level comment**:
```lean
-- FDD Convergence: Finite-dimensional distributions of empirical process
-- converge to multivariate Gaussian via Lindeberg CLT
-- Mathematical content: For fixed t₁,...,tₖ,
--   (Ẑₙ(t₁), ..., Ẑₙ(tₖ)) ⟹ N(0, Σ)
-- Reference: van der Vaart & Wellner (1996), Chapter 2
```

2. **Proof comments**:
```lean
lemma my_lemma : P := by
  -- Step 1: Fix the finite set of points
  let pts := [t₁, t₂, ..., tₖ]
  
  -- Step 2: Apply Lindeberg CLT
  have h_lindeberg : Lindeberg_condition ... := by sorry
  
  -- Step 3: Conclude
  exact tendsto_multivariate_normal h_lindeberg
```

3. **Session memory update**:
   - Add completion note to `/memories/session/proof_structure.md`
   - Update timestamps
   - Cross-link related lemmas

---

## Questions?

- **Check existing documentation**: `/memories/session/`
- **Look at similar lemmas**: See `Theorem2/Mercer.lean` for spectral structure examples
- **Open an issue**: Describe the blocker clearly with minimal example
- **Ask in discussions**: GitHub Discussions for longer-form questions

---

## Example: Contributing a Full Sub-Lemma

Here's an example workflow for contributing FDD Convergence:

### 1. Create Branch
```bash
git checkout -b feature/theorem1-fdd-convergence
```

### 2. Implement Lemma
Edit `SpatialCvM/Theorem1/FiniteDimensional.lean`:

```lean
-- Finite-Dimensional Distribution Convergence
-- For fixed points, empirical process at those points converges to Gaussian

import SpatialCvM.Lemma1.Main
import Mathlib.Probability.Distributions.Normal.Basic
import Mathlib.MeasureTheory.Integral.Lebesgue.Basic

namespace SpatialCvM.Theorem1.FiniteDimensional

-- FDD Convergence via Lindeberg CLT
-- The empirical process vector converges weakly to multivariate Gaussian
lemma fdd_convergence (K : ℝ → ℝ) (h : ℝ) (hh : h > 0)
    (hK : IsKernel K)
    (α : ℝ → ℝ) (h_mix : AlphaMixing α) (δ : ℝ) (hδ : δ > 0) :
    ∀ (pts : Finset ℝ),
    empirical_process_vector K h n pts ⟹ gaussian_limit K h α pts := by
  intro pts
  -- Apply Lindeberg CLT
  apply tendsto_multivariate_normal_lindeberg
  · -- Lindeberg condition holds
    apply lindeberg_for_kernel K h α hK h_mix
  · -- Covariance structure from Lemma 1
    exact asymptotic_covariance K h α
  sorry  -- TODO: Chain these pieces together

end SpatialCvM.Theorem1.FiniteDimensional
```

### 3. Test
```bash
lake build SpatialCvM.Theorem1.FiniteDimensional
```

### 4. Commit
```bash
git add SpatialCvM/Theorem1/FiniteDimensional.lean
git commit -m "feat: Prove FDD convergence for empirical process

- Set up Lindeberg condition for bounded kernels
- Apply multivariate CLT to kernel evaluations
- Use Davydov inequality for mixing bounds
- Reference: van der Vaart & Wellner (1996)"
```

### 5. Push & Create PR
```bash
git push origin feature/theorem1-fdd-convergence
# Create PR on GitHub with description
```

---

## Thank You!

Your contributions help advance formal mathematics and spatial statistics. Every lemma proved makes the project stronger. 🙏

**Happy proving!** 📐

