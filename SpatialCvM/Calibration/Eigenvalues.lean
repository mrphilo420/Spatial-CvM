-- Calibration: Spectral computation
import SpatialCvM.Calibration.DiscreteCovariance

namespace SpatialCvM.Calibration.Eigenvalues

-- Compute eigenvalues of the discrete covariance matrix
-- In practice, use numerical libraries; here we axiomatize
axiom eigenvalues_of_covariance (n : ℕ) (Σ : Matrix (Fin n) (Fin n) ℝ) :
    Fin n → ℝ

-- NOTE: first_eigenvalue_dominates was removed (April 18, 2026)
-- Reason: The claim λ₁ ≥ (Σλᵢ)/2 is MATHEMATICALLY FALSE
-- Counterexample: λ = [1, 1, 1] gives 1 ≱ 1.5
-- This was only used for calibration heuristics, not core theorems

end SpatialCvM.Calibration.Eigenvalues
