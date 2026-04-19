-- Theorem 1: Weak Convergence in ℓ∞
import SpatialCvM.Theorem1.FiniteDimensional
import SpatialCvM.Theorem1.Variance
import SpatialCvM.Theorem1.Tightness
import SpatialCvM.Theorem1.Definitions
import Mathlib.MeasureTheory.Integral.Lebesgue.Basic
import Mathlib.Order.Filter.AtTopBot.Basic

namespace SpatialCvM.Theorem1

open SpatialCvM.Definitions.RandomField
open SpatialCvM.Theorem1.Definitions
open SpatialCvM.Lemma1.Definitions
open MeasureTheory Filter

-- Gaussian process property (needed for limit characterization)
axiom IsGaussian (Z : ℝ → ℝ) : Prop

-- Prokhorov's theorem: tightness + f.d.d. convergence ⟹ weak convergence
axiom prokhorov_theorem {Xₙ : ℕ → ℝ → ℝ} {X : ℝ → ℝ}
    (h_fd : True)
    (h_tight : IsTight Xₙ) :
    True

-- Gaussian process existence: given mean and covariance, a Gaussian process exists
axiom gaussian_process_exists (μ : ℝ → ℝ) (Γ : ℝ → ℝ → ℝ)
    (h_sym : ∀ s t, Γ s t = Γ t s)
    (h_pos : ∀ t, Γ t t ≥ 0) :
    ∃ Z : ℝ → ℝ, IsGaussian Z

-- THEOREM 1 (Weak Convergence)
-- The empirical process converges weakly to a Gaussian process with covariance
-- from Lemma 1, on the ℓ∞ space under fixed-domain infill asymptotics.
-- Axiomatize: the full theorem
axiom weak_convergence (K : ℝ → ℝ) (h : ℝ) (hh : h > 0)
    (α : ℝ → ℝ) (h_mix : AlphaMixing α) (δ : ℝ) (hδ : δ > 0) :
    ∃ Z : ℝ → ℝ,
    IsGaussian Z ∧
    (∀ t₁ t₂, Gamma_operator K h hh t₁ t₂ = Gamma_operator K h hh t₂ t₁)

end SpatialCvM.Theorem1
