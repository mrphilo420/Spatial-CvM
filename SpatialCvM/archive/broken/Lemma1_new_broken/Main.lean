-- ============================================================================
-- LEMMA 1: Main Export
-- ============================================================================

import SpatialCvM.Lemma1.Mixing
import SpatialCvM.Lemma1.Summability

namespace SpatialCvM.Lemma1

-- Re-export key results
export SpatialCvM.Lemma1.Mixing (davydov_inequality davydov_indicators sigma_algebra_inclusion
  indicator_measurable centered_indicator_measurable indicator_centered_abs_bound)

export SpatialCvM.Lemma1.Summability (autocovariance_summable asymptoticCovariance_finite
  asymptoticCovariance_bound nonVanishingVariance kernel_squared_integral_pos
  scaled_kernel_integral_pos asymptoticCovariance_continuous)

export SpatialCvM.Lemma1.Asymptotics (lemma1_asymptoticCovarianceStructure)

end SpatialCvM.Lemma1