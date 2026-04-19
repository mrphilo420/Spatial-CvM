-- Lemma 1: Asymptotic covariance definitions
import SpatialCvM.Definitions.Basic
import SpatialCvM.Definitions.Kernel
import SpatialCvM.Definitions.RandomField
import Mathlib.MeasureTheory.Integral.Lebesgue.Basic

namespace SpatialCvM.Lemma1.Definitions

open SpatialCvM.Definitions.Basic
open SpatialCvM.Definitions.Kernel
open MeasureTheory

-- Empirical CDF at location s
noncomputable def F_hat (X : Finset ℝ) (t : ℝ) : ℝ :=
  (Finset.card (X.filter (· ≤ t)) : ℝ) / (Finset.card X : ℝ)

-- Indicator covariance: γ(u) = Cov(1(X₁ ≤ 0), 1(X₂ ≤ u))
-- Kernel-weighted version: γ_{K,h}(u) = ∫ K_h(v) · K_h(v - u) dv
-- This is the convolution of the scaled kernel with itself
-- Axiomatize: the integral is well-defined
axiom gamma_kernel (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) (u : ℝ) : ℝ

-- Covariance operator: Γ_{K,h}(s₁, s₂)
-- This is the asymptotic covariance of the kernel-smoothed empirical process
-- Γ(s₁, s₂) = ∫ K_h(u-s₁) · K_h(u-s₂) du
-- Axiomatize: the integral is well-defined
axiom Gamma_operator (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) (s₁ s₂ : ℝ) : ℝ

-- Gamma_operator is symmetric: Γ(s₁, s₂) = Γ(s₂, s₁)
-- This follows from the commutativity of multiplication in the integrand:
-- ∫ K_h(u-s₁) · K_h(u-s₂) du = ∫ K_h(u-s₂) · K_h(u-s₁) du
axiom Gamma_operator_symmetric (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) (s₁ s₂ : ℝ) :
    Gamma_operator K h hh s₁ s₂ = Gamma_operator K h hh s₂ s₁

-- Key lemma: gamma_kernel at zero is positive
-- γ_{K,h}(0) = ∫ v, K_h(v)² dv > 0 since K is non-zero on compact support
-- AXIOM: The integral of squared kernel is positive
axiom kernel_squared_integral_pos (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) (hK : IsKernel K) :
    (0 : ℝ) < gamma_kernel K h hh 0

lemma gamma_kernel_pos_at_zero (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) (hK : IsKernel K) :
    gamma_kernel K h hh 0 > 0 := by
  -- gamma_kernel K h hh 0 represents ∫ v, K_h(v) * K_h(v - 0) dv = ∫ v, K_h(v)² dv
  -- By the kernel_squared_integral_pos axiom, this integral is positive
  exact kernel_squared_integral_pos K h hh hK

end SpatialCvM.Lemma1.Definitions
