-- Lemma 1: Asymptotic covariance definitions
import SpatialCvM.Definitions.Basic
import SpatialCvM.Definitions.Kernel
import SpatialCvM.Definitions.RandomField
import Mathlib.MeasureTheory.Integral.Lebesgue.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Measure.Haar.Unique

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
-- Defined using the Bochner integral over ℝ with respect to the standard (Haar/volume) measure
noncomputable def gamma_kernel (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) (u : ℝ) : ℝ :=
  ∫ v, (kernel_scaled K h hh v) * (kernel_scaled K h hh (v - u)) ∂volume

-- Covariance operator: Γ_{K,h}(s₁, s₂)
-- This is the asymptotic covariance of the kernel-smoothed empirical process
-- Γ(s₁, s₂) = ∫ K_h(u-s₁) · K_h(u-s₂) du
-- Defined using the Bochner integral over ℝ with respect to the standard measure
noncomputable def Gamma_operator (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) (s₁ s₂ : ℝ) : ℝ :=
  ∫ u, (kernel_scaled K h hh (u - s₁)) * (kernel_scaled K h hh (u - s₂)) ∂volume

/-- Gamma_operator is symmetric: Γ(s₁, s₂) = Γ(s₂, s₁)
This follows from the commutativity of multiplication in the integrand:
∫ K_h(u-s₁) · K_h(u-s₂) du = ∫ K_h(u-s₂) · K_h(u-s₁) du
This is immediate from the definition since multiplication is commutative.

PROOF STATUS: COMPLETE - The proof uses:
1. Function extensionality (congr, funext)
2. Commutativity of multiplication (ring_nf simplifies a*b = b*a)
-/
theorem Gamma_operator_symmetric (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) (s₁ s₂ : ℝ) :
    Gamma_operator K h hh s₁ s₂ = Gamma_operator K h hh s₂ s₁ := by
  -- The symmetry follows from commutativity of multiplication
  -- ∫ K_h(u-s₁) · K_h(u-s₂) du = ∫ K_h(u-s₂) · K_h(u-s₁) du
  -- The integrands are equal by mul_comm
  simp only [Gamma_operator]
  -- Function extensionality: show that for all u, the integrands are equal
  -- Then the integrals are equal
  congr
  funext u
  ring_nf

-- ============================================================================
-- THEOREM: Kernel Squared Integral is Positive
-- STATUS: PROOF SKETCH COMPLETE — Requires additional measurability lemmas
--
-- Mathematical Content:
--   γ_{K,h}(0) = ∫ v, K_h(v)² dv > 0 since K is non-zero on compact support
--
-- Proof Strategy:
--   Since K is not identically zero and has compact support (IsKernel.supported), 
--   there exists a set of positive measure where K ≠ 0.
--   
--   By IsKernel.bounded, |K_h(v)| ≤ B for all v.
--   By IsKernel.supported, K_h(v) = 0 for |v| > r·h.
--   
--   The integral is over the compact set [-r·h, r·h], where:
--   1. K_h is measurable (from IsKernel.measurable)
--   2. K_h is bounded (from IsKernel.bounded)
--   3. K_h² is non-negative and not identically zero
--
--   By measure theory: ∫ K_h² dv > 0 since K_h² ≥ 0 and K_h² ≠ 0 on a set of 
--   positive measure.
--
-- What's Available:
--   - IsKernel.measurable: K is Borel measurable
--   - IsKernel.bounded: |K(x)| ≤ B for all x
--   - IsKernel.supported: K(x) = 0 for |x| > r
--   - Mathlib measure theory for integrals of positive functions
--
-- Implementation Path:
--   1. Show K_h is integrable (bounded × compact support = integrable)
--   2. Show K_h² is measurable (composition of measurable functions)
--   3. Show K_h² is positive on some non-null set
--   4. Apply integral_pos_of_nonneg_of_nonzero
--
-- For now, this remains an axiom pending the development of additional
-- measurability lemmas for squared kernel functions.
-- ============================================================================
axiom kernel_squared_integral_pos (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) (hK : IsKernel K) :
    (0 : ℝ) < gamma_kernel K h hh 0

-- Corollary: gamma_kernel at zero is positive (direct from axiom)
lemma gamma_kernel_pos_at_zero (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) (hK : IsKernel K) :
    gamma_kernel K h hh 0 > 0 := by
  -- gamma_kernel K h hh 0 represents ∫ v, K_h(v) * K_h(v - 0) dv = ∫ v, K_h(v)² dv
  -- By the kernel_squared_integral_pos axiom, this integral is positive
  exact kernel_squared_integral_pos K h hh hK

end SpatialCvM.Lemma1.Definitions
