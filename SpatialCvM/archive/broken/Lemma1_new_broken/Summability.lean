-- ============================================================================
-- LEMMA 1: Summability and Non-Vanishing Variance (Steps 2-3)
-- Mathematical Content: Summability of autocovariances, Γ(0,0) > 0
-- ============================================================================

import SpatialCvM.Lemma1.Mixing
import Mathlib.Topology.Instances.ENNReal
import Mathlib.Topology.EMetricSpace

namespace SpatialCvM.Lemma1.Summability

open SpatialCvM.Definitions
open MeasureTheory Function

-- ============================================================================
-- Step 2: Summability and Convergence
-- ============================================================================

/-- Summability of lag-d autocovariances

    Lemma 1 (Step 2 of proof):
    Summing the absolute value of autocovariances over all lags yields:

    |Γ(y,z)| = |Σ_{d=0}^∞ γ_d(y,z)| ≤ Σ_{d=0}^∞ |γ_d(y,z)|

    ≤ C · φ(y) · φ(z) · Σ_{d=0}^∞ α(d) < ∞

    by the strong mixing assumption Σ_{d=1}^∞ α(d) < ∞.
    -/
lemma autocovariance_summable {d n : ℕ} {Ω : Type*} [MeasurableSpace Ω] [IsProbabilityMeasure (ℙ : Measure Ω)]
    (X : (Fin d → ℝ) → Ω → ℝ) (sampling : Fin n → Fin d → ℝ)
    (K : (Fin d → ℝ) → ℝ) (h : ℝ) (hh : h > 0)
    (y z : ℝ)
    (hα : SummableAlphaMixing X) (hK : Kernel.IsAdmissibleKernel K) :
    Summable (fun d : ℕ ↦ spatialAutocovariance X sampling K h hh d y z) := by
  -- Use Davydov bound: |γ_d| ≤ C * α(d) * φ(y) * φ(z)
  -- Since Σ α(d) < ∞ by mixing assumption, and φ(y), φ(z) are finite,
  -- the series converges by comparison test.
  sorry

/-- Explicit bound on asymptotic covariance

    |Γ(y,z)| ≤ C · φ(y) · φ(z) · Σ_{d=0}^∞ α(d)

    where φ(y) = B/h^d is the variance envelope.
    -/
lemma asymptoticCovariance_bound {d n : ℕ} {Ω : Type*} [MeasurableSpace Ω] [IsProbabilityMeasure (ℙ : Measure Ω)]
    (X : (Fin d → ℝ) → Ω → ℝ) (sampling : Fin n → Fin d → ℝ)
    (K : (Fin d → ℝ) → ℝ) {L_K R_K h : ℝ} (hh : h > 0)
    (hK : Kernel.IsKernel K L_K R_K)
    (y z : ℝ)
    (hα : SummableAlphaMixing X) :
    ∃ C S, |asymptoticCovariance X sampling K h hh y z| ≤ C * (1 / h ^ d) * (1 / h ^ d) * S := by
  -- Γ(y,z) = ∑' γ_d(y,z)
  -- |Γ(y,z)| ≤ ∑' |γ_d(y,z)|
  -- ≤ ∑' C * α(d) * (B/h^d) * (B/h^d)
  -- = C * (B/h^d)^2 * ∑' α(d)
  -- < ∞ since ∑' α(d) < ∞
  sorry

/-- Asymptotic covariance is finite

    Γ(y,z) < ∞ for all y, z ∈ [0,1]
    -/
lemma asymptoticCovariance_finite {d n : ℕ} {Ω : Type*} [MeasurableSpace Ω] [IsProbabilityMeasure (ℙ : Measure Ω)]
    (X : (Fin d → ℝ) → Ω → ℝ) (sampling : Fin n → Fin d → ℝ)
    (K : (Fin d → ℝ) → ℝ) (h : ℝ) (hh : h > 0)
    (y z : ℝ)
    (hα : SummableAlphaMixing X) (hK : Kernel.IsAdmissibleKernel K) :
    asymptoticCovariance X sampling K h hh y z < ∞ := by
  -- Follows from summability
  sorry

-- ============================================================================
-- Step 3: Non-Vanishing Variance at (0,0)
-- ============================================================================

/-- Non-vanishing variance condition: Γ(0,0) > 0

    This is the KEY distinction of the fixed-bandwidth regime.

    At (y,z) = (0,0), the variance decomposes as:
    Γ(0,0) = Var(K_h(x₀)[1{X₀ ≤ 0} - H₀(0)]) + (mixing terms)

    Since K(0) = 1 (by kernel normalization) and the kernel is
    non-degenerate on its compact support, the squared kernel
    integral is positive:

    γ_{K,h}(0) = ∫_{ℝ^d} K_h(v)² dv > 0

    Mathematical statement (from paper Equation 3.5):
    γ_{K,h}(0) = h^{-d} · ∫_{ℝ^d} K(v)² dv > 0

    This is > 0 because K is non-degenerate (has positive L² norm).
    -/
lemma kernel_squared_integral_pos {d : ℕ} {K : (Fin d → ℝ) → ℝ}
    {L_K R_K : ℝ} (hK : Kernel.IsKernel K L_K R_K) :
    ∫ v : Fin d → ℝ, (K v) ^ 2 > 0 := by
  -- Proof sketch:
  -- 1. K is bounded and non-zero (from kernel properties)
  -- 2. K has compact support (non-empty by normalization)
  -- 3. Therefore ∫ K² > 0 (L² norm is positive for non-zero functions)
  --
  -- Key properties from IsKernel:
  -- - K is not identically zero (integrates to 1)
  -- - K is bounded and measurable
  -- - Therefore K² is non-negative and not everywhere zero
  sorry

/-- Scaled kernel has positive L² integral

    ∫ K_h(v)² dv = h^{-d} · ∫ K(v)² dv > 0

    This uses change of variables: u = v/h, du = h^{-d} dv
    -/
lemma scaled_kernel_integral_pos {d : ℕ} {K : (Fin d → ℝ) → ℝ}
    {L_K R_K h : ℝ} (hh : h > 0)
    (hK : Kernel.IsKernel K L_K R_K) :
    ∫ v : Fin d → ℝ, (Kernel.scaledKernel K h hh v) ^ 2 > 0 := by
  -- Change of variables:
  -- K_h(v) = h^{-d} · K(v/h)
  -- K_h(v)² = h^{-2d} · K(v/h)²
  -- Let u = v/h, then dv = h^d · du
  -- ∫ K_h(v)² dv = ∫ h^{-2d} · K(u)² · h^d du
  --              = h^{-d} · ∫ K(u)² du
  --              > 0 since ∫ K² > 0 by kernel_squared_integral_pos
  sorry

/-- Main result: Non-vanishing variance

    Lemma 1 (Step 3 and Equation 3.3):
    Γ(0,0) > 0 (non-vanishing variance)

    This is the key innovation of the fixed-bandwidth regime:
    with fixed h > 0, the variance Γ(0,0) remains bounded away
    from zero. Under shrinking-bandwidth (h = h_n → 0), we would
    have Γ_n(0,0) → 0, leading to a degenerate limit.
    -/
theorem nonVanishingVariance {d n : ℕ} {Ω : Type*} [MeasurableSpace Ω] [IsProbabilityMeasure (ℙ : Measure Ω)]
    (X : (Fin d → ℝ) → Ω → ℝ) (sampling : Fin n → Fin d → ℝ)
    (K : (Fin d → ℝ) → ℝ) {L_K R_K h : ℝ} (hh : h > 0)
    (hK : Kernel.IsKernel K L_K R_K)
    (hstationary : StrictlyStationary X) :
    asymptoticCovariance X sampling K h hh 0 0 > 0 := by
  -- Decompose Γ(0,0) = γ_0(0,0) + Σ_{d≥1} γ_d(0,0)
  --
  -- γ_0(0,0) = Var(K_h(X₀)[1{X₀ ≤ 0} - H₀(0)])
  --          = E[K_h(X₀)²] · H₀(0) · (1 - H₀(0))  [assuming independence]
  --          > 0 since E[K_h²] > 0 and H₀(0) ∈ (0,1)
  --
  -- For the mixing terms (d ≥ 1), use:
  -- |Σ_{d≥1} γ_d| ≤ C · Σ_{d≥1} α(d) < ∞
  --
  -- The diagonal term dominates, ensuring positivity.
  sorry

-- ============================================================================
-- Continuity of Asymptotic Covariance
-- ============================================================================

/-- Continuity of Γ(y,z)

    The asymptotic covariance is continuous in (y,z) due to:
    1. Continuity of the kernel (Lipschitz property)
    2. Continuity of the CDF H₀(y)
    3. Dominated convergence for the infinite sum

    For any ε > 0, there exists δ > 0 such that:
    |y₁ - y₂| < δ and |z₁ - z₂| < δ implies
    |Γ(y₁,z₁) - Γ(y₂,z₂)| < ε
    -/
lemma asymptoticCovariance_continuous {d n : ℕ} {Ω : Type*} [MeasurableSpace Ω] [IsProbabilityMeasure (ℙ : Measure Ω)]
    (X : (Fin d → ℝ) → Ω → ℝ) (sampling : Fin n → Fin d → ℝ)
    (K : (Fin d → ℝ) → ℝ) {L_K R_K h : ℝ} (hh : h > 0)
    (hK : Kernel.IsKernel K L_K R_K)
    (hstationary : StrictlyStationary X)
    (y₀ z₀ : ℝ) :
    ContinuousAt (fun (p : ℝ × ℝ) ↦ asymptoticCovariance X sampling K h hh p.1 p.2) (y₀, z₀) := by
  -- Proof via dominated convergence:
  -- 1. Each γ_d(y,z) is continuous (kernel + indicator)
  -- 2. The Davydov bound provides a uniform integrable bound
  -- 3. Σ |γ_d| converges uniformly (Weierstrass M-test)
  -- 4. Therefore Γ = ∑' γ_d is continuous
  sorry

end SpatialCvM.Lemma1.Summability


namespace SpatialCvM.Lemma1.Asymptotics

open SpatialCvM.Definitions

-- ============================================================================
-- Asymptotic Covariance Structure: Final Statement
-- ============================================================================

/-- Lemma 1 (Complete Statement): Asymptotic Covariance Structure

    Under Assumptions 2.1-2.4, the limiting covariance of the empirical
    process exists and is finite:

    Γ(y, z) = Σ_{d=0}^∞ γ_d(y, z) < ∞

    Moreover, under fixed bandwidth h > 0:
    Γ(0, 0) > 0    (non-vanishing variance)

    This is the foundation for Theorem 1 (weak convergence).
    -/
theorem lemma1_asymptoticCovarianceStructure {d n : ℕ} {Ω : Type*} [MeasurableSpace Ω] [IsProbabilityMeasure (ℙ : Measure Ω)]
    (X : (Fin d → ℝ) → Ω → ℝ) (sampling : Fin n → Fin d → ℝ)
    (K : (Fin d → ℝ) → ℝ) {L_K R_K h : ℝ} (hh : h > 0)
    (hK : Kernel.IsKernel K L_K R_K)
    (hstationary : StrictlyStationary X)
    (hmixing : SummableAlphaMixing X) :
    -- (1) Summable and finite
    Summable (fun d ↦ spatialAutocovariance X sampling K h hh d 0 0) ∧
    asymptoticCovariance X sampling K h hh 0 0 < ∞ ∧
    -- (2) Non-vanishing under fixed bandwidth
    asymptoticCovariance X sampling K h hh 0 0 > 0 ∧
    -- (3) Continuous
    Continuous (fun (p : ℝ × ℝ) ↦ asymptoticCovariance X sampling K h hh p.1 p.2) := by
  constructor
  · exact Summability.autocovariance_summable X sampling K h hh 0 0 hmixing ⟨L_K, R_K, hK⟩
  constructor
  · exact Summability.asymptoticCovariance_finite X sampling K h hh 0 0 hmixing ⟨L_K, R_K, hK⟩
  constructor
  · exact Summability.nonVanishingVariance X sampling K hK hstationary
  · exact Continuous.continuous_iff_continuousAt.mpr fun (y, z) ↦
      Summability.asymptoticCovariance_continuous X sampling K hK hstationary y z

end SpatialCvM.Lemma1.Asymptotics