-- Spatial lattice definitions and fixed-domain asymptotics
import SpatialCvM.Definitions.Basic

namespace SpatialCvM.Definitions.Lattice

open SpatialCvM.Definitions.Basic

-- A spatial lattice is a finite set of locations on [0,1]²
structure SpatLat where
  locations : Finset Loc
  bounded : ∀ s ∈ locations, s.1 ∈ Set.Icc 0 1 ∧ s.2 ∈ Set.Icc 0 1

-- Mesh size: minimum distance between locations
noncomputable def mesh (L : SpatLat) : ℝ :=
  if h : L.locations.card ≤ 1 then 1
  else 0  -- Placeholder: would compute minimum pairwise distance

-- Notation for lattice size
abbrev n_sites (L : SpatLat) := L.locations.card

-- Fixed-domain asymptotics: infill sampling on fixed domain [0,1]²
-- The effective sample size is m_n = h² / Δₙ²
-- where Δₙ is the mesh size and h is the kernel bandwidth
noncomputable def effective_sample_size (h : ℝ) (mesh_size : ℝ) : ℝ :=
  h^2 / mesh_size^2

-- Condition for infill asymptotics: mesh → 0 as n → ∞
def InfillAsymptotics (lattices : ℕ → SpatLat) : Prop :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, mesh (lattices n) < ε

end SpatialCvM.Definitions.Lattice
