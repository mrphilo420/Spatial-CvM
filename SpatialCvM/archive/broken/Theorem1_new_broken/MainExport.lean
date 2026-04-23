-- ============================================================================
-- THEOREM 1: Complete Export
-- ============================================================================

import SpatialCvM.Theorem1.Definitions
import SpatialCvM.Theorem1.FiniteDimensional
import SpatialCvM.Theorem1.Tightness
import SpatialCvM.Theorem1.Main

namespace SpatialCvM.Theorem1

-- Export definitions
export SpatialCvM.Theorem1.Definitions (centeredEmpiricalProcess supNorm
  gaussianCovarianceKernel ZeroMeanGaussianProcess weakConvergenceEllInfinity)

-- Export finite-dimensional convergence results
export SpatialCvM.Theorem1.FiniteDimensional (lindeberg_condition elmachkouri_clt
  finiteDimensionalConvergence cramerWold_device)

-- Export tightness results
export SpatialCvM.Theorem1.Tightness (empirical_process_bounded empirical_process_equicontinuous
  relativeCompactness_ArzelaAscoli tightness_via_equicontinuity)

-- Export main theorem
export SpatialCvM.Theorem1.Main (theorem1_weakConvergence limitIsGaussian limitIsNonDegenerate)

end SpatialCvM.Theorem1