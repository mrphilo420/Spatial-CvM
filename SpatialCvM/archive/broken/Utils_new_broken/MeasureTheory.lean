-- ============================================================================
-- UTILS: Measure Theory Helpers
-- ============================================================================

import Mathlib.MeasureTheory.MeasureSpace
import Mathlib.MeasureTheory.Integral.Bochner
import Mathlib.Probability.Moments.Expectation

namespace SpatialCvM.Utils.MeasureTheory

open MeasureTheory Function

-- ============================================================================
-- Probability and Expectation Notation
-- ============================================================================

/-- Probability notation ℙ(A) -/
notation "ℙ(" A ")" => measure (by volume_tac) A

/-- Covariance notation -/
notation "cov[" μ "]" X "," Y => Covariance.cov[μ] X Y

/-- Expectation notation 𝔼[X] -/
notation "𝔼[" X "]" => ∫ ω, X ω ∂(by volume_tac)

-- ============================================================================
-- Indicator Function Helpers
-- ============================================================================

/-- Indicator function 𝟙{X ≤ x} -/
def indicatorLe {Ω : Type*} (X : Ω → ℝ) (x : ℝ) : Ω → ℝ :=
  fun ω ↦ if X ω ≤ x then 1 else 0

/-- Indicator is measurable when X is measurable -/
lemma indicator_measurable {Ω : Type*} [MeasurableSpace Ω] {X : Ω → ℝ}
    (hX : Measurable X) (x : ℝ) :
    Measurable (indicatorLe X x) := by
  apply Measurable.ite
  · exact measurableSet_le hX measurable_const
  · exact measurable_const
  · exact measurable_const

-- ============================================================================
-- Bounded Function Lemmas
-- ============================================================================

/-- Bounded function composition -/
lemma bounded_comp {α β γ : Type*} [MetricSpace β] [MetricSpace γ]
    {f : α → β} {g : β → γ}
    (hf : ∃ B, ∀ x, dist (f x) default ≤ B)
    (hg : LipschitzWith K g) :
    ∃ B', ∀ x, dist (g (f x)) default ≤ B' := by
  sorry

-- ============================================================================
-- Summation Lemmas
-- ============================================================================

/-- Absolute summability implies summability -/
lemma summable_of_abs_summable {α : Type*} {f : α → ℝ}
    (h : Summable (fun a ↦ |f a|)) : Summable f := by
  sorry

/-- Comparison test for summability -/
lemma summable_comparison_test {α : Type*} {f g : α → ℝ}
    (hg : Summable g)
    (h : ∀ a, |f a| ≤ |g a|) :
    Summable f := by
  sorry

end SpatialCvM.Utils.MeasureTheory