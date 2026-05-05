-- Copula and rank transformation definitions
import SpatialCvM.Definitions.Basic

namespace SpatialCvM.Definitions.Copula

open SpatialCvM.Definitions.Basic

-- Empirical cumulative distribution function for a sample
noncomputable def empirical_cdf (sample : Finset ℝ) (x : ℝ) : ℝ :=
  (Finset.card (sample.filter (fun y => y ≤ x)) : ℝ) / (Finset.card sample : ℝ)

-- Rank of an element in a sample (1-indexed)
noncomputable def rank (sample : Finset ℝ) (x : ℝ) : ℕ :=
  Finset.card (sample.filter (fun y => y ≤ x))

-- Rank transformation: maps to [0,1] via empirical CDF
noncomputable def rank_transform (sample : Finset ℝ) (x : ℝ) : ℝ :=
  (rank sample x : ℝ) / (Finset.card sample : ℝ)

-- Empirical copula process
noncomputable def empirical_copula (samples : Finset (ℝ × ℝ)) (x y : ℝ) : ℝ :=
  let n := Finset.card samples
  (Finset.card (samples.filter (fun p => p.1 ≤ x ∧ p.2 ≤ y)) : ℝ) / (n : ℝ)

-- Transformation via ranks (multivariate)
-- Takes a sample matrix and transforms each component to uniform
noncomputable def multivariate_rank_transform (data : Finset (ℝ × ℝ)) : Finset (ℝ × ℝ) :=
  let xs := data.image Prod.fst
  let ys := data.image Prod.snd
  data.image fun (x, y) => (rank_transform xs x, rank_transform ys y)

end SpatialCvM.Definitions.Copula
