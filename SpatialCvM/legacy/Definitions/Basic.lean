import Mathlib.Data.Real.Basic
import Mathlib.Analysis.SpecialFunctions.Sqrt

/-!
## Basic Definitions — Locations, Norms, and Distance

This module defines the geometric primitives used throughout the Spatial CvM
formalization: spatial locations as points in $\mathbb{R}^2$, the Euclidean norm,
and the induced metric. These underpin the kernel-smoothed empirical process
and all subsequent weak-convergence arguments.

**Key objects:**
- `Loc` — spatial locations as $\mathbb{R}^2$
- `loc_norm` — Euclidean norm $\|s\| = \sqrt{s_1^2 + s_2^2}$
- `loc_dist` — metric $d(s_1, s_2) = \|s_1 - s_2\|$

**Proof status:** 3 of 4 lemmas have complete proofs; the triangle inequality
(`loc_dist_triangle`) is axiomatized via `sorry`.
-/

namespace SpatialCvM.Definitions.Basic

/-!
Spatial locations are points in $\mathbb{R}^2$.
In the spatial CvM setting, each observation site $s \in [0,1]^2$ is a `Loc`.
-/
abbrev Loc := ℝ × ℝ

/-!
The Euclidean norm on $\mathbb{R}^2$:
$$\|s\| = \sqrt{s_1^2 + s_2^2}.$$
Marked `noncomputable` because `Real.sqrt` is not computable.
-/
noncomputable def loc_norm : Loc → ℝ := fun s => Real.sqrt (s.1^2 + s.2^2)

/-!
Euclidean distance between two spatial locations:
$$d(s_1, s_2) = \|s_1 - s_2\| = \sqrt{(s_{1,1} - s_{2,1})^2 + (s_{1,2} - s_{2,2})^2}.$$
This is the metric induced by `loc_norm` and is used to define the
kernel bandwidth $h$ and mixing coefficients.
-/
noncomputable def loc_dist (s₁ s₂ : Loc) : ℝ := loc_norm (s₁.1 - s₂.1, s₁.2 - s₂.2)

/-!
## `loc_dist_nonneg` — Non-negativity of Euclidean distance

For all $s_1, s_2 \in \mathbb{R}^2$:
$$0 \le d(s_1, s_2).$$

**Proof.** Immediate from `Real.sqrt_nonneg`: the square root of any
real number is non-negative. □
-/
lemma loc_dist_nonneg (s₁ s₂ : Loc) : 0 ≤ loc_dist s₁ s₂ := by
  unfold loc_dist loc_norm
  exact Real.sqrt_nonneg _

/-!
## `loc_dist_comm` — Symmetry of Euclidean distance

For all $s_1, s_2 \in \mathbb{R}^2$:
$$d(s_1, s_2) = d(s_2, s_1).$$

**Proof.** Unfold the definition to $\sqrt{(a-b)^2 + (c-d)^2}$.
Since $(a-b)^2 = (b-a)^2$ (and likewise for $c-d$), the two expressions
are identical. In Lean, `congr 1 <;> ring` handles each component
separately via the ring tactic. □
-/
lemma loc_dist_comm (s₁ s₂ : Loc) : loc_dist s₁ s₂ = loc_dist s₂ s₁ := by
  unfold loc_dist loc_norm
  simp only [Prod.fst_sub, Prod.snd_sub]
  congr 1 <;> ring

/-!
## `loc_dist_triangle` — Triangle inequality for Euclidean distance

For all $s_1, s_2, s_3 \in \mathbb{R}^2$:
$$d(s_1, s_3) \le d(s_1, s_2) + d(s_2, s_3).$$

**Proof idea.** This is the Minkowski inequality for the $\ell^2$ norm in
$\mathbb{R}^2$: $\|x + y\|_2 \le \|x\|_2 + \|y\|_2$. Writing
$x = s_1 - s_2$ and $y = s_2 - s_3$, the claim becomes
$\|x + y\| \le \|x\| + \|y\|$. This can be derived from
`norm_add_le` applied to the $\ell^2$ norm on $\mathbb{R}^2$.

*Status: axiomatized (`sorry`).*
-/
lemma loc_dist_triangle (s₁ s₂ s₃ : Loc) :
    loc_dist s₁ s₃ ≤ loc_dist s₁ s₂ + loc_dist s₂ s₃ := by
  unfold loc_dist loc_norm
  -- We use the triangle inequality for the Euclidean norm:
  -- ‖(a,b)‖ + ‖(c,d)‖ ≥ ‖(a+c, b+d)‖
  -- Here: s₁ - s₃ = (s₁ - s₂) + (s₂ - s₃)
  let a := s₁.1 - s₂.1
  let b := s₁.2 - s₂.2
  let c := s₂.1 - s₃.1
  let d := s₂.2 - s₃.2
  -- Then s₁ - s₃ = (a + c, b + d)
  have key : s₁.1 - s₃.1 = a + c ∧ s₁.2 - s₃.2 = b + d := by
    constructor <;> ring
  rw [key.1, key.2]
  -- Now we need: sqrt((a+c)² + (b+d)²) ≤ sqrt(a² + b²) + sqrt(c² + d²)
  -- This is the Minkowski inequality for ℝ²: ‖(a+c, b+d)‖ ≤ ‖(a,b)‖ + ‖(c,d)‖
  -- Using the fact that the Euclidean norm satisfies the triangle inequality
  have h_norm : Real.sqrt ((a + c) ^ 2 + (b + d) ^ 2) ≤
                Real.sqrt (a ^ 2 + b ^ 2) + Real.sqrt (c ^ 2 + d ^ 2) := by
    -- We prove the triangle inequality for the Euclidean norm using Cauchy-Schwarz.
    -- Let u = (a, b) and v = (c, d). We need ‖u + v‖ ≤ ‖u‖ + ‖v‖.
    -- Squaring both sides, we need to show:
    -- (a+c)² + (b+d)² ≤ (√(a²+b²) + √(c²+d²))²
    -- which expands to:
    -- a² + 2ac + c² + b² + 2bd + d² ≤ a² + b² + c² + d² + 2√((a²+b²)(c²+d²))
    -- Simplifying: ac + bd ≤ √((a²+b²)(c²+d²))
    -- This is the Cauchy-Schwarz inequality: |⟨u,v⟩| ≤ ‖u‖‖v‖
    have h1 : (Real.sqrt ((a + c) ^ 2 + (b + d) ^ 2)) ^ 2 ≤
              (Real.sqrt (a ^ 2 + b ^ 2) + Real.sqrt (c ^ 2 + d ^ 2)) ^ 2 := by
      have h_left : (Real.sqrt ((a + c) ^ 2 + (b + d) ^ 2)) ^ 2 = (a + c) ^ 2 + (b + d) ^ 2 := by
        apply Real.sq_sqrt
        positivity
      have h_right : (Real.sqrt (a ^ 2 + b ^ 2) + Real.sqrt (c ^ 2 + d ^ 2)) ^ 2 =
                      (Real.sqrt (a ^ 2 + b ^ 2)) ^ 2 + (Real.sqrt (c ^ 2 + d ^ 2)) ^ 2 +
                      2 * (Real.sqrt (a ^ 2 + b ^ 2) * Real.sqrt (c ^ 2 + d ^ 2)) := by ring
      have h_right_simp : (Real.sqrt (a ^ 2 + b ^ 2) + Real.sqrt (c ^ 2 + d ^ 2)) ^ 2 =
                           (a ^ 2 + b ^ 2) + (c ^ 2 + d ^ 2) +
                           2 * (Real.sqrt (a ^ 2 + b ^ 2) * Real.sqrt (c ^ 2 + d ^ 2)) := by
        rw [h_right]
        have h1 : (Real.sqrt (a ^ 2 + b ^ 2)) ^ 2 = a ^ 2 + b ^ 2 := Real.sq_sqrt (by positivity)
        have h2 : (Real.sqrt (c ^ 2 + d ^ 2)) ^ 2 = c ^ 2 + d ^ 2 := Real.sq_sqrt (by positivity)
        rw [h1, h2]
      rw [h_left, h_right_simp]
      -- Now we need: (a+c)² + (b+d)² ≤ a² + b² + c² + d² + 2√((a²+b²)(c²+d²))
      -- Expanding left side: a² + 2ac + c² + b² + 2bd + d²
      -- Rearranging: we need ac + bd ≤ √((a²+b²)(c²+d²))
      -- This is the Cauchy-Schwarz inequality: |⟨u,v⟩| ≤ ‖u‖‖v‖
      -- Note: the inequality holds trivially when ac + bd ≤ 0
      by_cases h_nonneg : 0 ≤ a * c + b * d
      · -- Case: ac + bd ≥ 0, we need to show (ac + bd)² ≤ (a² + b²)(c² + d²)
        have h_cauchy : (a * c + b * d) ^ 2 ≤ (a ^ 2 + b ^ 2) * (c ^ 2 + d ^ 2) := by
          -- Expand: a²c² + 2abcd + b²d² ≤ a²c² + a²d² + b²c² + b²d²
          -- Simplify to: 2abcd ≤ a²d² + b²c²
          -- This is: 0 ≤ (ad - bc)²
          linarith [sq_nonneg (a * d - b * c)]
        -- Since ac + bd ≥ 0 and √(a²+b²)√(c²+d²) ≥ 0, we need ac + bd ≤ √(a²+b²)√(c²+d²)
        -- This follows from (ac+bd)² ≤ (a²+b²)(c²+d²) by taking square roots
        have h_prod : Real.sqrt (a ^ 2 + b ^ 2) * Real.sqrt (c ^ 2 + d ^ 2) =
                       Real.sqrt ((a ^ 2 + b ^ 2) * (c ^ 2 + d ^ 2)) := by
          rw [Real.sqrt_mul (by positivity)]
        have h2 : a * c + b * d ≤ Real.sqrt ((a ^ 2 + b ^ 2) * (c ^ 2 + d ^ 2)) := by
          have h_le_sq : (a * c + b * d) ^ 2 ≤ ((a ^ 2 + b ^ 2) * (c ^ 2 + d ^ 2)) := h_cauchy
          have h_nonneg2 : 0 ≤ a * c + b * d := h_nonneg
          have h2 : Real.sqrt ((a * c + b * d) ^ 2) = a * c + b * d := by
            rw [Real.sqrt_sq (by linarith)]
          have h3 : Real.sqrt ((a ^ 2 + b ^ 2) * (c ^ 2 + d ^ 2)) ≥ 0 := Real.sqrt_nonneg _
          have h4 : Real.sqrt ((a * c + b * d) ^ 2) ≤ Real.sqrt ((a ^ 2 + b ^ 2) * (c ^ 2 + d ^ 2)) :=
            Real.sqrt_le_sqrt (by linarith)
          linarith [h2, h4]
        linarith [h_prod, h2]
      · -- Case: ac + bd < 0, the inequality holds trivially since LHS < 0 ≤ RHS
        have h_neg : a * c + b * d < 0 := by linarith
        have h_pos : 0 ≤ Real.sqrt (a ^ 2 + b ^ 2) * Real.sqrt (c ^ 2 + d ^ 2) := by positivity
        linarith [h_neg, h_pos]
    have h2 : 0 ≤ Real.sqrt (a ^ 2 + b ^ 2) + Real.sqrt (c ^ 2 + d ^ 2) := by positivity
    nlinarith [Real.sqrt_nonneg ((a + c) ^ 2 + (b + d) ^ 2), h1, h2,
               Real.sq_sqrt (show (0 : ℝ) ≤ (a + c) ^ 2 + (b + d) ^ 2 by positivity),
               sq_nonneg (Real.sqrt ((a + c) ^ 2 + (b + d) ^ 2) - Real.sqrt (a ^ 2 + b ^ 2) - Real.sqrt (c ^ 2 + d ^ 2))]
  exact h_norm

/-!
## `loc_dist_eq_zero` — Positive definiteness of Euclidean distance

For all $s_1, s_2 \in \mathbb{R}^2$:
$$d(s_1, s_2) = 0 \iff s_1 = s_2.$$

**Proof.**

($\Rightarrow$) If $d(s_1, s_2) = 0$, then $\sqrt{(a-b)^2 + (c-d)^2} = 0$.
Since $\sqrt{x} = 0$ implies $x = 0$ for $x \ge 0$ (`Real.sqrt_eq_zero`),
we get $(a-b)^2 + (c-d)^2 = 0$. A sum of squares is zero only if each term
is zero, so $a = b$ and $c = d$, hence $s_1 = s_2$.

($\Leftarrow$) If $s_1 = s_2$, then $s_1 - s_2 = 0$ and
$\sqrt{0 + 0} = 0$ by `Real.sqrt_zero`. □
-/
lemma loc_dist_eq_zero {s₁ s₂ : Loc} :
    loc_dist s₁ s₂ = 0 ↔ s₁ = s₂ := by
  constructor
  · intro h
    unfold loc_dist loc_norm at h
    -- Real.sqrt x = 0 and x ≥ 0 implies x = 0
    have hx : (0 : ℝ) ≤ (s₁.1 - s₂.1)^2 + (s₁.2 - s₂.2)^2 := by positivity
    have h_sq : (s₁.1 - s₂.1)^2 + (s₁.2 - s₂.2)^2 = 0 := by
      have h1 : Real.sqrt ((s₁.1 - s₂.1)^2 + (s₁.2 - s₂.2)^2) = 0 := h
      have h2 := Real.sqrt_eq_zero hx
      -- h2 says: sqrt x = 0 ↔ x = 0 when x ≥ 0
      exact Iff.mp h2 h1
    -- From a² + b² = 0, both a = 0 and b = 0
    have h1 : s₁.1 - s₂.1 = 0 := by nlinarith
    have h2 : s₁.2 - s₂.2 = 0 := by nlinarith
    ext <;> linarith
  · intro h
    subst h
    unfold loc_dist loc_norm
    simp [sub_self, Real.sqrt_zero]

end SpatialCvM.Definitions.Basic
