-- Theorem 2: Joint weak convergence
import SpatialCvM.Theorem2.Definitions
import SpatialCvM.Theorem1.Main
import Mathlib.Order.Filter.AtTopBot.Basic

namespace SpatialCvM.Theorem2.JointConvergence

open Filter

-- Joint convergence of (F̂_1, ..., F̂_K, F̂_pool) follows from Theorem 1
-- This is a consequence of Theorem1.weak_convergence via continuous mapping theorem
-- TODO: Prove using CMT applied to the pooling map (F₁, ..., Fₖ) ↦ (F₁, ..., Fₖ, pool(F₁,...,Fₖ))

end SpatialCvM.Theorem2.JointConvergence
