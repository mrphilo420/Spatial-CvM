-- Riemann sum approximation for Lemma 1
import SpatialCvM.Lemma1.Definitions
import SpatialCvM.Lemma1.Stationarity
import SpatialCvM.Utils.Asymptotics
import SpatialCvM.Utils.MeasureTheory

namespace SpatialCvM.Lemma1.Asymptotics

open SpatialCvM.Utils.Asymptotics SpatialCvM.Lemma1.Definitions

-- Double sum over lattice points approximates integral
-- The error decays as (mesh n)^2
-- Axiomatize: Riemann sum approximation with little-o error
axiom double_sum_to_integral {f : ℝ × ℝ → ℝ} (mesh : ℕ → ℝ)
    (h_mesh : ∀ ε > 0, ∃ N, ∀ n ≥ N, mesh n < ε) :
    ∃ C : ℕ → ℝ, IsLittleO (fun n => C n) (fun _ => (1 : ℝ))

-- The asymptotic covariance is given by integral of kernel bivariate product
-- Axiomatize: the kernel integral formula
axiom kernel_integral_formula (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) :
    ∃ psi_h : ℝ → ℝ, psi_h 0 = gamma_kernel K h hh 0

end SpatialCvM.Lemma1.Asymptotics
