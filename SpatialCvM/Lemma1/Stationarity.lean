-- Change of variables and substitution lemmas for Lemma 1
import SpatialCvM.Lemma1.Definitions

namespace SpatialCvM.Lemma1.Stationarity

-- Change of variables: u = (s - s₀) / h
-- This normalizes the distance to the reference location by bandwidth
noncomputable def change_of_variables (s s₀ h : ℝ) : ℝ := (s - s₀) / h

-- Under stationarity, the integrand depends only on u = (s - s₀) / h
-- For any function f, we can construct g such that f s = g ((s - s₀) / h)
-- Explicitly: g u := f (s₀ + h * u)
theorem stationary_substitution (f : ℝ → ℝ) (s₀ : ℝ) (h : ℝ) (hh : h > 0) :
    ∃ g : ℝ → ℝ, ∀ s, f s = g ((s - s₀) / h) := by
  use fun u => f (s₀ + h * u)
  intro s
  have h_eq : s₀ + h * ((s - s₀) / h) = s := by
    field_simp [hh.ne.symm]
    ring
  simp [h_eq]
