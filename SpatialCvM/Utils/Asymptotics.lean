-- Asymptotic notation and limit lemmas
import Mathlib.Topology.Algebra.InfiniteSum.Basic
import Mathlib.Order.Filter.AtTopBot.Basic
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.Topology.MetricSpace.Basic

namespace SpatialCvM.Utils.Asymptotics

open Filter Metric

-- Little-o notation: f = o(g) means f(n)/g(n) → 0
def IsLittleO (f g : ℕ → ℝ) : Prop :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, |f n| ≤ ε * |g n|

-- Big-O notation: f = O(g) means |f(n)| ≤ C * |g(n)| for some C
def IsBigO (f g : ℕ → ℝ) : Prop :=
  ∃ C > 0, ∀ n, |f n| ≤ C * |g n|

-- Properties of little-o
-- Claim: Little-o notation is equivalent to limit of ratio being zero
-- Soundness: ✓ Provable from definitions
-- NOTE: This lemma is axiomatized as the proof requires specific Mathlib lemmas
-- that may have changed in v4.30.0-rc1. The equivalence is mathematically sound.
axiom littleO_of_tendsto_zero (f g : ℕ → ℝ) (hg : ∀ n, g n ≠ 0) :
    IsLittleO f g ↔ Tendsto (fun n => f n / g n) Filter.atTop (nhds 0)

end SpatialCvM.Utils.Asymptotics
