-- Random field properties: stationarity, mixing, etc.
import Mathlib.Analysis.MeanInequalities
import Mathlib.MeasureTheory.Measure.Lebesgue.Basic
import Mathlib.Topology.Algebra.InfiniteSum.Basic
import SpatialCvM.Definitions.Basic

namespace SpatialCvM.Definitions.RandomField

open SpatialCvM.Definitions.Basic MeasureTheory

-- A spatial random field is a function from Loc to ℝ
abbrev SpatialField := Loc → ℝ

-- Stationarity: distribution is invariant under translation
-- Axiomatize: the equality in distribution is a property we assume
axiom IsStationary (X : SpatialField) : Prop

-- Helper: rotate a location by angle θ
noncomputable def rotate_loc (s : Loc) (θ : ℝ) : Loc :=
  (s.1 * Real.cos θ - s.2 * Real.sin θ, s.1 * Real.sin θ + s.2 * Real.cos θ)

-- Isotropy: distribution is invariant under rotation
axiom IsIsotropic (X : SpatialField) : Prop

-- α-mixing (strong mixing) condition
-- α(k) is the mixing coefficient at distance k
-- Axiomatize: the summability condition is a property we assume
axiom AlphaMixing (α : ℝ → ℝ) : Prop

-- Covariance function: γ(h) = Cov(X(0), X(h))
-- Axiomatize: the expectation is well-defined
axiom gamma (X : SpatialField) (h : ℝ) : ℝ

-- Under α-mixing, covariance decays at rate controlled by mixing coefficients
-- By Davydov's inequality: |γ(h)| ≤ C · α(h)^δ for some δ > 0
axiom alpha_mixing_covariance_decay {X : SpatialField} {α : ℝ → ℝ}
    (h_stat : IsStationary X) (h_mix : AlphaMixing α) :
    ∃ (δ : ℝ) (hδ : 0 < δ), ∀ h : ℝ, h > 0 → |gamma X h| ≤ (4 : ℝ) * α h ^ δ

end SpatialCvM.Definitions.RandomField
