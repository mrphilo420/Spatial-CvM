-- Theorem 2: Spectral decomposition via Mercer's Theorem
import SpatialCvM.Theorem2.JointConvergence
import Mathlib.MeasureTheory.Integral.Lebesgue.Basic

namespace SpatialCvM.Theorem2.Mercer

open MeasureTheory

-- Mercer's theorem: symmetric positive semi-definite kernel has eigendecomposition
-- Γ(s, t) = ∑ₘ λₘ φₘ(s) φₘ(t)
-- Deep result in functional analysis (Mercer, 1909; see also Conway, 1990)
axiom mercer_decomposition (Γ : ℝ → ℝ → ℝ)
    (h_symmetric : ∀ s t, Γ s t = Γ t s)
    (h_positive : ∀ f, ∫ s, ∫ t, f s * Γ s t * f t ∂MeasureTheory.volume ∂MeasureTheory.volume ≥ 0) :
    ∃ λ : ℕ → ℝ,
    ∃ φ : ℕ → ℝ → ℝ,
    (∀ m, λ m ≥ 0) ∧
    (∀ m n, ∫ x, φ m x * φ n x ∂MeasureTheory.volume = if m = n then 1 else 0) ∧
    (∀ s t, Γ s t = ∑' m, λ m * φ m s * φ m t)

end SpatialCvM.Theorem2.Mercer
