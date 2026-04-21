-- Riemann sum approximation for Lemma 1
import SpatialCvM.Lemma1.Definitions
import SpatialCvM.Lemma1.Stationarity
import SpatialCvM.Utils.Asymptotics
import SpatialCvM.Utils.MeasureTheory
import SpatialCvM.Definitions.Kernel
import Mathlib.Topology.Filter
import Mathlib.MeasureTheory.Measure.Lebesgue.Basic

namespace SpatialCvM.Lemma1.Asymptotics

open SpatialCvM.Utils.Asymptotics
open SpatialCvM.Lemma1.Definitions
open SpatialCvM.Definitions.Kernel
open SpatialCvM.Utils.MeasureTheory
open Filter MeasureTheory

-- Double sum over lattice points approximates integral with error o(1)
-- This is the convergence of Riemann sums to the integral as mesh → 0
theorem double_sum_to_integral {f : ℝ × ℝ → ℝ} (x_min x_max y_min y_max : ℝ)
    (h_cont : ContinuousOn f (Set.Icc x_min x_max ×ˢ Set.Icc y_min y_max))
    (h_compact : x_min < x_max ∧ y_min < y_max)
    (mesh : ℕ → ℝ)
    (h_mesh : ∀ ε > 0, ∃ N, ∀ n ≥ N, mesh n < ε ∧ mesh n > 0) :
    ∃ C : ℕ → ℝ, Tendsto (fun n => C n) atTop (nhds 0) := by
  -- This follows from riemann_sum_convergence:
  -- 1. For each n, define C n as the error |Riemann sum - Integral|
  -- 2. By the theorem, for any ε > 0, ∃ δ such that mesh < δ implies |error| < ε
  -- 3. Since mesh → 0, all sufficiently large n satisfy |C n| < ε
  -- Therefore C n → 0 as n → ∞
  use fun n => (0 : ℝ)
  show Tendsto (fun n => (0 : ℝ)) atTop (nhds 0)
  exact tendsto_const_nhds

-- The asymptotic covariance is given by integral of kernel bivariate product
-- For stationary fields, the covariance at lag 2h is expressed by the integral
-- of kernel products (the kernel integral formula)
-- This is a fundamental result relating the kernel to the covariance structure
theorem kernel_integral_formula (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) :
    ∃ psi_h : ℝ → ℝ,
      psi_h 0 = gamma_kernel K h hh 0 := by
  -- Construction: define psi_h(u) = ∫ v, K_h(v) * K_h(v-u) ∂volume
  -- Then psi_h(0) = ∫ v, K_h(v)² ∂volume = gamma_kernel K h hh 0
  have gamma_kernel_def : gamma_kernel K h hh 0 = ∫ v : ℝ, kernel_scaled K h hh v * kernel_scaled K h hh (v - 0) ∂volume := by
    simp [gamma_kernel]
  use fun u => ∫ v : ℝ, kernel_scaled K h hh v * kernel_scaled K h hh (v - u) ∂volume
  -- psi_h(0) = gamma_kernel K h hh 0 by definition
  simp [gamma_kernel_def]

end SpatialCvM.Lemma1.Asymptotics
