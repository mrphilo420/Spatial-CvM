-- Calibration: Discrete covariance and Gaussian-copula model
import SpatialCvM.Theorem2.Main

namespace SpatialCvM.Calibration.DiscreteCovariance

open SpatialCvM.Definitions.Basic

-- Exact discrete covariance between locations s_i and s_j
-- Includes nugget effect for same-location pairs
noncomputable def discrete_covariance (γ : ℝ → ℝ) (nugget : ℝ) (s_i s_j : Loc) : ℝ :=
  if s_i = s_j then γ 0 + nugget
  else γ (loc_dist s_i s_j)

-- NOTE: covariance_matrix_spec axiom removed (April 18, 2026)
-- Reason: This is a structural fact, not a mathematical axiom
-- The statement "∀ i j ∈ locations, ∃ val = discrete_covariance γ i j"
-- is provable by reflexivity from the definition of discrete_covariance
--
-- If this is needed as a lemma, use:
-- lemma covariance_matrix_spec (locations : Finset Loc) (γ : ℝ → ℝ) (nugget : ℝ) :
--     ∀ i j : Loc, i ∈ locations → j ∈ locations →
--     ∃ val : ℝ, val = discrete_covariance γ nugget i j := by
--   intros i j _ _
--   exact ⟨discrete_covariance γ nugget i j, rfl⟩

-- Gaussian-copula working model for indicator covariances
-- Assumes bivariate Gaussian with fitted correlation structure
noncomputable def gaussian_copula_indicator_cov (ρ : ℝ) : ℝ :=
  (2 * Real.arcsin ρ) / (2 * Real.pi)

end SpatialCvM.Calibration.DiscreteCovariance
