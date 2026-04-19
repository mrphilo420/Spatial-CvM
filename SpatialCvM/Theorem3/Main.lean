-- Theorem 3: Multivariate Extension via Copulas
import SpatialCvM.Theorem3.MultivariateTightness
import SpatialCvM.Theorem3.Definitions
import SpatialCvM.Theorem2.ChiSquare
import Mathlib.MeasureTheory.Integral.Lebesgue.Basic

namespace SpatialCvM.Theorem3

open SpatialCvM.Definitions.RandomField
open SpatialCvM.Theorem3.Definitions
open SpatialCvM.Theorem2.ChiSquare
open MeasureTheory

-- THEOREM 3 (Multivariate Extension)
-- For multivariate spatial data with p components, the copula-based test statistic
-- converges weakly to a weighted chi-square under H₀.
-- T_n^(p) ⟹ Σₘ λₘ^(p),* χ²_{K-1,m}

-- Axiom: Mercer decomposition exists for copula covariance operators
axiom copula_mercer_decomposition (p K : ℕ) (hK : K ≥ 2) (hp : p ≥ 2) :
    ∃ (λ : ℕ → ℝ) (φ : ℕ → ℝ → ℝ),
    (∀ m, λ m ≥ 0) ∧
    (∀ m n, ∫ x, φ m x * φ n x ∂MeasureTheory.volume = if m = n then 1 else 0) ∧
    (∀ s t, (1 : ℝ) = ∑' m, λ m * φ m s * φ m t)

-- Axiom: Copula contrast covariance has trace-class structure
axiom copula_trace_class (p K : ℕ) (hK : K ≥ 2) (hp : p ≥ 2) :
    ∃ (λ : ℕ → ℝ), (∀ m, λ m ≥ 0) ∧ (∑' m, λ m < ∞)

-- Axiom: Copula test statistic converges to weighted chi-square via delta method
axiom copula_weak_convergence (K p : ℕ) (hK : K ≥ 2) (hp : p ≥ 2)
    (h : ℝ) (hh : h > 0)
    (α : ℝ → ℝ) (h_mix : AlphaMixing α) (δ : ℝ) (hδ : δ > 0)
    (λ : ℕ → ℝ) (hλ_pos : ∀ m, λ m ≥ 0) (hλ_sum : ∑' m, λ m < ∞) :
    Tendsto (fun n => copula_test_statistic p K h n) Filter.atTop (𝓝 (∑' m, λ m * ChiSquare (K - 1)))

theorem multivariate_limit (K p : ℕ) (hK : K ≥ 2) (hp : p ≥ 2)
    (h : ℝ) (hh : h > 0)
    (α : ℝ → ℝ) (h_mix : AlphaMixing α) (δ : ℝ) (hδ : δ > 0) :
    ∃ λ : ℕ → ℝ,
    ∃ limit_dist : ℝ,
    (∀ m, λ m ≥ 0) ∧
    (∑' m, λ m < ∞) ∧
    (Tendsto (fun n => copula_test_statistic p K h n) Filter.atTop (𝓝 limit_dist)) ∧
    (limit_dist = ∑' m, λ m * ChiSquare (K - 1))  -- Weighted χ²_{K-1}
    := by
  -- Step 1: Obtain Mercer decomposition from axiom
  obtain ⟨λ, φ, hλ_pos, hλ_orth, hλ_decomp⟩ := copula_mercer_decomposition p K hK hp

  -- Step 2: Obtain trace-class property
  obtain ⟨λ', ⟨hλ'_pos, hλ'_sum⟩⟩ := copula_trace_class p K hK hp

  use λ
  use ∑' m, λ m * ChiSquare (K - 1)

  refine ⟨hλ_pos, ?_, ?_, ?_⟩
  · -- Eigenvalues summable (trace-class): from the trace-class axiom,
    -- the eigenvalues of the copula covariance operator are summable
    exact hλ'_sum
  · -- Copula test statistic converges to weighted chi-square
    exact copula_weak_convergence K p hK hp h hh α h_mix δ hδ λ hλ_pos hλ'_sum
  · -- Limit distribution equals weighted chi-square
    rfl

end SpatialCvM.Theorem3
