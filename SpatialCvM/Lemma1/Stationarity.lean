-- Change of variables and substitution lemmas for Lemma 1
import SpatialCvM.Lemma1.Definitions

namespace SpatialCvM.Lemma1.Stationarity

-- Change of variables: u = (s - s₀) / h
-- This normalizes the distance to the reference location by bandwidth
noncomputable def change_of_variables (s s₀ h : ℝ) : ℝ := (s - s₀) / h

-- Under stationarity, the integrand depends only on u = (s - s₀) / h
axiom stationary_substitution (f : ℝ → ℝ) (s₀ : ℝ) (h : ℝ) (hh : h > 0) :
    ∃ g : ℝ → ℝ, ∀ s, f s = g ((s - s₀) / h)

end SpatialCvM.Lemma1.Stationarity
