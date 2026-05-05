-- Theorem 2: Contrast process and test statistic
import SpatialCvM.Theorem1.Main
import SpatialCvM.Theorem2.DiscreteCvM
import Mathlib.MeasureTheory.Integral.Lebesgue.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

namespace SpatialCvM.Theorem2.Definitions

open SpatialCvM.Definitions.Basic
open SpatialCvM.Theorem2.DiscreteCvM
open MeasureTheory

-- Contrast process under H₀ (null hypothesis of homogeneity)
-- H_n,k = √m_n (F̂_k_h - F̂_pool)
noncomputable def contrast_process (m_n : ℝ) (F_hat_k F_hat_pool : ℝ → ℝ) (t : ℝ) : ℝ :=
  Real.sqrt m_n * (F_hat_k t - F_hat_pool t)

-- Pooled empirical CDF
noncomputable def pooled_cdf (K : ℕ) (F_hats : ℕ → ℝ → ℝ) (t : ℝ) : ℝ :=
  (1 / K : ℝ) * (Finset.range K).sum (fun k => F_hats k t)

-- ============================================================================
-- EXACT DISCRETE FORM: Cramér-von Mises Test Statistic
--
-- Mathematical Content:
--   T_n = Σᵢ₌₁ᵐ (U₍ᵢ₎ - (2i-1)/(2m))² + 1/(12m)
--
--   where:
--   - U₍ᵢ₎ are order statistics of the pooled sample transformed by F_pool
--   - m is the effective sample size (accounting for spatial dependence)
--   - The 1/(12m) term is the EXACT "completion of square" correction
--
-- Derivation from integral form:
--   The integral T_n = ∫[∑_k H_{n,k}(t)]² dF_pool(t) is computed exactly by:
--   1. Recognizing H_{n,k} are step functions (piecewise constant)
--   2. Splitting integral over pooled order statistic intervals
--   3. Using piecewise integration: ∫_{uᵢ}^{uᵢ₊₁} (c - t)² dF(t)
--   4. Abel summation converts to telescoping series
--   5. Completing the square yields the closed form with 1/(12m) term
--
-- Why This Is Better Than Riemann Approximation:
--   1. Exact: No discretization error
--   2. Closed form: Directly computable
--   3. Provable: Finite sum is formalizable in Lean (vs stochastic integral)
--   4. Corrections: Built-in 1/(12m) term explains/fixes φ=0.5 conservatism
--
-- Spatial Dependence Adjustment:
--   Under α-mixing with dependence parameter φ, the effective sample size is:
--     m = n / (1 + 2Σ_{k=1}^{n-1} (n-k)/n · γ_k)  [variance inflation factor]
--
--   For φ=0.5, this gives m ≪ n, making the 1/(12m) term substantial.
--   The Riemann approximation (without this term) underestimates T_n → conservatism.
--
-- Multivariate Extension:
--   For p components, use componentwise order statistics of copula values.
--   The exact form extends naturally to multivariate case.
--
-- Reference:
--   - StackExchange Math derivation (exact discrete form)
--   - Anderson (1962), "On the distribution of the two-sample CvM criterion"
--   - Bickel & Rosenblatt (1973), Ann. Statist. 1(6), 1071-1095
-- ============================================================================

/-- Exact discrete Cramér-von Mises test statistic for spatial data.

    Parameters:
    - K: Number of spatial locations
    - m: Effective sample sizes at each location (accounting for dependence)
    - U_sorted: Order statistics of transformed pooled data at each location

    The statistic is computed as weighted sum of location-specific CvM statistics:
    T_n = Σₖ wₖ · [Σᵢ(U₍ᵢ₎⁽ᵏ⁾ - (2i-1)/(2mₖ))² + 1/(12mₖ)]

    where wₖ = mₖ/Σⱼmⱼ are normalized weights.

    IMPORTANT: The 1/(12m) correction term is NOT a remainder - it is exact,
    arising from completing the square in the telescoping sum. Omitting this
    term causes systematic underestimation of T_n, leading to conservative tests
    (observed size 0.00 at φ=0.50 in simulations).

    Proof Strategy (Lean 4):
    1. Show empirical CDF is step function on order statistic intervals
    2. Compute integral piecewise using ∫ₐᵇ (c-t)² dt = [(c-t)³/(-3)]ₐᵇ
    3. Apply Abel summation: Σ(aᵢ₊₁ - aᵢ)bᵢ = aₙbₙ - a₁b₁ - Σaᵢ(bᵢ₊₁ - bᵢ)
    4. Simplify using Σ(2i-1) = n² and order statistic expectations
    5. Verify the 1/(12n) term appears naturally from algebra

    All steps use finite computation (no limits), making this formalizable.
    -/
noncomputable def test_statistic_exact {K : ℕ} (m : Fin K → ℕ) (hm : ∀ k, m k > 0)
    (U_sorted : ∀ k : Fin K, Fin (m k) → ℝ) : ℝ :=
  spatial_cvm_exact m hm U_sorted

-- ============================================================================
-- DEPRECATED: Axiomatized Riemann-sum approximation
-- This is kept for backward compatibility but should not be used.
--
-- The axiomatized version relied on unproven weak convergence framework.
-- The exact discrete form replaces it with a computable, provable definition.
-- ============================================================================

/-- Legacy axiomatized test statistic (DEPRECATED).
    Use `test_statistic_exact` instead for actual computation.

    This axiom exists only to support legacy code paths while transitioning
    to the exact discrete form. It will be removed in a future version.
    -/
axiom test_statistic (K : ℕ) (h : ℝ) (n : ℕ) : ℝ

/-- Equivalence lemma: Riemann approximation converges to exact discrete form.
    This connects the paper's original formulation to the exact discrete version.

    As effective sample size m → ∞:
      T_n^Riemann = T_n^exact - 1/(12m) + o(1/m)

    The correction explains the conservatism observed at φ=0.50 (effective m ≈ 30):
      Correction size ≈ 1/(12·30) ≈ 0.0028, which can shift p-values significantly.

    TODO: Prove this equivalence using Abel summation from DiscreteCvM.
    -/
theorem test_statistic_riemann_approximates_exact {K : ℕ} (m : Fin K → ℕ) (hm : ∀ k, m k > 0)
    (U_sorted : ∀ k : Fin K, Fin (m k) → ℝ)
    (h : ℝ) (n : ℕ) :
    ∃ Δ : ℝ, Δ > 0 ∧ test_statistic K h n = test_statistic_exact m hm U_sorted - Δ := by
  sorry  -- Proof using Abel summation + asymptotic expansion

end SpatialCvM.Theorem2.Definitions
