-- ============================================================================
-- THEOREM 2: Complete Export
-- ============================================================================

import SpatialCvM.Theorem2.Definitions
import SpatialCvM.Theorem2.Mercer
import SpatialCvM.Theorem2.ChiSquare
import SpatialCvM.Theorem2.Main

namespace SpatialCvM.Theorem2

-- Export definitions
export SpatialCvM.Theorem2.Definitions (PhiFunctional MercerDecomposition
  karhunenLoeveExpansion contrastSubspace WeightedChiSquare)

-- Export Mercer results
export SpatialCvM.Theorem2.Mercer (mercer_decomposition eigenvalue_decay
  eigenvalues_contrast karhunenLoeve_valid)

-- Export chi-square conversion
export SpatialCvM.Theorem2.ChiSquare (integral_of_squared_process
  chisquare_representation weightedChiSquareWithDF)

-- Export main theorem
export SpatialCvM.Theorem2.Main (continuous_mapping_theorem asymptotic_null
  classical_vs_spatial_comparison)

end SpatialCvM.Theorem2