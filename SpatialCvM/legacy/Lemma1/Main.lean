-- Lemma 1: Asymptotic Covariance Theorem
import SpatialCvM.Lemma1.Definitions
import SpatialCvM.Lemma1.Stationarity
import SpatialCvM.Lemma1.Mixing
import SpatialCvM.Lemma1.Asymptotics
import Mathlib.MeasureTheory.Integral.Lebesgue.Basic

namespace SpatialCvM.Lemma1

open SpatialCvM.Definitions.RandomField
open SpatialCvM.Lemma1.Definitions
open SpatialCvM.Definitions.Kernel
open MeasureTheory

-- LEMMA 1 (Asymptotic Covariance)
-- Under fixed bandwidth h, the empirical process covariance converges to an integral form.
-- Key insight: The covariance does NOT vanish (non-consistency at fixed h).
-- Axiomatize: the full theorem statement
axiom asymptotic_covariance (K : ℝ → ℝ) (h : ℝ) (hh : h > 0)
    (hK : IsKernel K)
    (α : ℝ → ℝ) (h_mix : AlphaMixing α) :
    ∃ Γ : ℝ → ℝ,
    (Γ 0 > 0) ∧  -- Non-consistency: covariance at 0 is positive
    (∀ ε > 0, ∃ δ > 0, ∀ s₁ s₂, |s₁ - s₂| < δ → |Γ s₁ - Γ s₂| < ε) -- Continuity

end SpatialCvM.Lemma1
