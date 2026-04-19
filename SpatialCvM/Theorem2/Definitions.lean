-- Theorem 2: Contrast process and test statistic
import SpatialCvM.Theorem1.Main
import Mathlib.MeasureTheory.Integral.Lebesgue.Basic

namespace SpatialCvM.Theorem2.Definitions

open SpatialCvM.Definitions.Basic
open MeasureTheory

-- Contrast process under H₀ (null hypothesis of homogeneity)
-- H_n,k = √m_n (F̂_k_h - F̂_pool)
noncomputable def contrast_process (m_n : ℝ) (F_hat_k F_hat_pool : ℝ → ℝ) (t : ℝ) : ℝ :=
  Real.sqrt m_n * (F_hat_k t - F_hat_pool t)

-- Pooled empirical CDF
noncomputable def pooled_cdf (K : ℕ) (F_hats : ℕ → ℝ → ℝ) (t : ℝ) : ℝ :=
  (1 / K : ℝ) * (Finset.range K).sum (fun k => F_hats k t)

-- Test statistic: Cramér-von Mises type
-- T_n = ∫ (∑_k H_{n,k}(t))² dF_pool
-- Axiomatize: the integral is well-defined
axiom test_statistic (K : ℕ) (h : ℝ) (n : ℕ) : ℝ

end SpatialCvM.Theorem2.Definitions
