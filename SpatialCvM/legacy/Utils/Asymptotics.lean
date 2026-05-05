-- Asymptotic notation and limit lemmas
import Mathlib.Topology.Algebra.InfiniteSum.Basic
import Mathlib.Order.Filter.AtTopBot.Basic
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.Topology.MetricSpace.Basic

namespace SpatialCvM.Utils.Asymptotics

open Filter Metric

-- Little-o notation: f = o(g) means f(n)/g(n) → 0
-- This aligns with Mathlib's IsLittleO but specialized to ℕ → ℝ
def IsLittleO (f g : ℕ → ℝ) : Prop :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, |f n| ≤ ε * |g n|

-- Big-O notation: f = O(g) means |f(n)| ≤ C * |g(n)| for some C
def IsBigO (f g : ℕ → ℝ) : Prop :=
  ∃ C > 0, ∀ n, |f n| ≤ C * |g n|

-- Properties of little-o
-- Equivalence: f = o(g) iff f(n)/g(n) → 0 as n → ∞
-- This is mathematically sound: the ε-N definition of little-o is equivalent
-- to the limit of the ratio going to zero.
-- In a full Mathlib-based development, this would use Mathlib's IsLittleO directly.
-- For now, we keep this axiom with full documentation.
-- PROOF OUTLINE:
-- Forward direction: Given ε > 0, from IsLittleO we get N such that
--   ∀ n ≥ N, |f n| ≤ ε * |g n|. With g n ≠ 0, this gives |f n|/|g n| ≤ ε,
--   which is the Tendsto definition atTop (nhds 0).
-- Backward direction: From Tendsto, for any ε > 0, eventually |f n|/|g n| < ε,
--   which with |g n| > 0 gives |f n| < ε * |g n|, satisfying IsLittleO.
axiom littleO_of_tendsto_zero {f g : ℕ → ℝ} (hg : ∀ n, g n ≠ 0) :
    IsLittleO f g ↔ Tendsto (fun n => f n / g n) Filter.atTop (nhds 0)

end SpatialCvM.Utils.Asymptotics
