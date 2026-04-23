-- Custom tactics for common proof patterns
import SpatialCvM.Lemma1.Mixing
import SpatialCvM.Utils.MeasureTheory
import SpatialCvM.Utils.Asymptotics

namespace SpatialCvM.Utils.Tactics

-- Tactic: davydov
-- Applies Davydov inequality
macro "davydov" : tactic => `(tactic|
  apply davydov_inequality)

-- Tactic: riem_sum
-- Applies Riemann sum convergence
macro "riem_sum" : tactic => `(tactic|
  apply riemann_sum_convergence)

-- Tactic: asymp_eq
-- Simplifies asymptotic equality proofs
macro "asymp_eq" : tactic => `(tactic|
  simp [Filter.Tendsto])

end SpatialCvM.Utils.Tactics
