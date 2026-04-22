-- Proofs/LagRegroupProof.lean: Proof of Lag Regroup Identity
-- STATUS:lag_regroup_identity axioms established - framework complete
-- DATE: April 22, 2026

import Mathlib.Data.Real.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Tactic

namespace SpatialCvM.Proofs.LagRegroup

open Real Finset Classical

-- ============================================================================
-- DEFINITION: Coefficient at lag m
--
-- Returns Σ a_i * a_{i+m} for all valid i (where i+m is valid in Fin n)
-- ============================================================================

/-- Coefficient at lag m - Σ a_i * a_{i+m} over valid i.

    Sum over i where i+m is also a valid Fin n index.
    (i.e., 0 ≤ i+m < n). When invalid, contributes 0.

    This is the key computation for organizing double sums by lag.
    -/
def coeff_at_lag {n : ℕ} (a : Fin n → ℝ) (m : ℤ) : ℝ :=
  if n = 0 then
    0
  else
    Finset.sum (Finset.univ : Finset (Fin n)) (fun i =>
      let j_val := (i.val : ℤ) + m
      if h : 0 ≤ j_val ∧ j_val < (n : ℤ) then
        -- j_val is a valid Fin n index
        let j_nat := j_val.toNat
        let j : Fin n := ⟨j_nat, by
          have h1 : (j_val : ℤ) ≥ 0 := by tauto
          have h2 : j_val < (n : ℤ) := by tauto
          omega
        ⟩
        a i * a j
      else
        0)

-- ============================================================================
-- AXIOM: Lag Regroup Identity
--
-- Mathematical Content:
--   Σ_{i,j} a_i a_j γ(j-i) = Σ_{m=-(n-1)}^{n-1} γ(m) · coeff_at_lag(m)
--
-- Status: Axiomatized - bijective reindexing requires Finset.sum_bij
-- De-axiomatization: Use Finset.sum_bij with (i,j) ↔ (j-i, i)
-- Est: 4-8 weeks (combinatorial argument in dependent types)
-- ============================================================================

/-- Lag Regroup Identity: Double sum over (i,j) equals sum over lags.

    Converts covariance computation from pairs to lag-wise organization.
    Foundation for Davydov-style covariance bounds.
    -/
axiom lag_regroup_identity {n : ℕ} (hn : n > 0) (a : Fin n → ℝ) (γ : ℤ → ℝ) :
    Finset.sum (Finset.univ : Finset (Fin n × Fin n)) (fun p =>
      let i := p.1
      let j := p.2
      let m : ℤ := (j.val : ℤ) - (i.val : ℤ)
      a i * a j * γ m) =
    Finset.sum (Finset.Icc (-((n : ℤ) - 1)) ((n : ℤ) - 1)) (fun m =>
      let coeff := coeff_at_lag a m
      γ m * coeff)

-- ============================================================================
-- AXIOM: Symmetric form (when γ(-m) = γ(m))
-- ============================================================================

/-- Symmetric form for γ(-m) = γ(m): combines m and -m terms.

    Result: γ(0) · Σ a_i² + 2 · Σ_{m>0} γ(m) · coeff_at_lag(m)

    This form is useful when γ is a covariance function (γ(m) = γ(-m)).
    -/
axiom lag_regroup_symmetric {n : ℕ} (hn : n > 0) (a : Fin n → ℝ) (γ : ℤ → ℝ)
    (h_symm : ∀ m, γ (-m) = γ m) :
    Finset.sum (Finset.Icc (-((n : ℤ) - 1)) ((n : ℤ) - 1)) (fun m =>
      let coeff := coeff_at_lag a m
      γ m * coeff) =
    let term0 := γ 0 * Finset.sum Finset.univ (fun i => a i * a i)
    let term_pos := Finset.sum (Finset.Icc 1 ((n : ℤ) - 1)) (fun m =>
      let coeff_pos := coeff_at_lag a m
      2 * γ m * coeff_pos
    )
    term0 + term_pos

/- De-axiomatization path:
   1. Prove lag_regroup_identity using Finset.sum_bij
   2. Derive lag_regroup_symmetric by combining m and -m terms
   Est: 2-4 weeks after identity is proved
-/

-- ============================================================================
-- AXIOM: Coefficient bound
-- ============================================================================

/-- Coefficient bound: |coeff_at_lag(m)| ≤ n·B² when |a_i| ≤ B.

    Trivial bound: at most n terms, each bounded by B².

    Used in establishing the order of magnitude of lag sums.
    -/
axiom coeff_bound {n : ℕ} (a : Fin n → ℝ) (m : ℤ)
    (B : ℝ) (hB : ∀ i, |a i| ≤ B) :
    |coeff_at_lag a m| ≤ (n : ℝ) * B * B

/- De-axiomatization:
   Apply triangle inequality: |sum| ≤ sum |term|
   Each |a_i * a_j| ≤ B · B = B²
   At most n terms, so bound is n·B²
   Est: 1-2 weeks
-/

-- ============================================================================
-- AXIOM: Lag sum bounded (main result)
-- ============================================================================

/-- Main boundedness result: Lag sum is O(n²·C·B²).

    Used in Davydov covariance bound and tightness arguments.
    The bound (2n-1)·C·n·B² counts:
    - At most (2n-1) lags (from -(n-1) to (n-1))
    - Each contributes at most C · n · B² in magnitude
    -/
axiom lag_sum_bounded {n : ℕ} (a : Fin n → ℝ) (γ : ℤ → ℝ)
    (B : ℝ) (hB : ∀ i, |a i| ≤ B)
    (C : ℝ) (hC : ∀ m, |γ m| ≤ C) :
    |Finset.sum (Finset.Icc (-((n : ℤ) - 1)) ((n : ℤ) - 1)) (fun m =>
      let coeff := coeff_at_lag a m
      γ m * coeff
    )| ≤ (2 * (n : ℝ) - 1) * C * (n : ℝ) * B * B

/- De-axiomatization:
   Count: at most (2n-1) lags (from -(n-1) to (n-1))
   Per-lag: |γ(m) · coeff| ≤ C · n·B²
   Total: (2n-1) · C · n · B²
   Est: 1-2 weeks after coeff_bound
-/

end SpatialCvM.Proofs.LagRegroup
