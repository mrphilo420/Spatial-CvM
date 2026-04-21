-- Calibration: Spectral computation
import SpatialCvM.Calibration.DiscreteCovariance

namespace SpatialCvM.Calibration.Eigenvalues

-- ============================================================================
-- AXIOM: Eigenvalues of Covariance Matrix
-- STATUS: Documented Axiom — Numerical Linear Algebra Operation
--
-- Mathematical Content:
--   For a covariance matrix Σ (symmetric positive semi-definite), computes
--   its eigenvalues λ₁, λ₂, ..., λₙ in non-increasing order:
--     λ₁ ≥ λ₂ ≥ ... ≥ λₙ ≥ 0
--
--   The eigenvalues are roots of the characteristic polynomial:
--     det(Σ - λI) = 0
--
-- Context:
--   The eigenvalues of the covariance matrix determine the limiting
--   distribution of the test statistic. Under Mercer's decomposition,
--   these correspond to the weights in the weighted χ² distribution.
--
-- Why it Remains an Axiom:
--   Full computation requires:
--   1. Matrix type from Mathlib (Matrix (Fin n) (Fin n) ℝ)
--   2. Characteristic polynomial computation
--   3. Root-finding for the polynomial
--   4. Sorting eigenvalues by magnitude
--   While Mathlib has matrices, the spectral decomposition computation
--   is typically handled by numerical libraries in practice.
--
-- Implementation Path (when needed):
--   1. Use `Mathlib.LinearAlgebra.Eigenspace` for theoretical results
--   2. Use `Mathlib.LinearAlgebra.Spectrum` for spectral theory
--   3. For computation, connect to BLAS/LAPACK via foreign function interface
--   4. Or implement QR algorithm / power iteration in Lean
--
-- Note: In practice, this is computed numerically via LAPACK's DSYEV
--
-- Reference: Golub & Van Loan (2013), "Matrix Computations", Chapter 8.
--           Mercer (1909), "Functions of positive and negative type".
-- ============================================================================
axiom eigenvalues_of_covariance (n : ℕ) (Σ : Matrix (Fin n) (Fin n) ℝ) :
    Fin n → ℝ

-- NOTE: first_eigenvalue_dominates was removed (April 18, 2026)
-- Reason: The claim λ₁ ≥ (Σλᵢ)/2 is MATHEMATICALLY FALSE
-- Counterexample: λ = [1, 1, 1] gives 1 ≱ 1.5
-- This was only used for calibration heuristics, not core theorems

end SpatialCvM.Calibration.Eigenvalues
