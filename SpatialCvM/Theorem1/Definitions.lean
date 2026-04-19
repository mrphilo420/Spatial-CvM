-- Theorem 1: Process definitions and empirical deviations
import SpatialCvM.Definitions.Kernel
import SpatialCvM.Lemma1.Main
import Mathlib.MeasureTheory.Integral.Lebesgue.Basic

namespace SpatialCvM.Theorem1.Definitions

open SpatialCvM.Definitions.Basic
open SpatialCvM.Definitions.Kernel
open MeasureTheory

-- True CDF process: the kernel-smoothed true distribution function
-- F_k(t) = ∫ K_h(u - s_k) F(u) du  (kernel-smoothed CDF at location s_k)
-- Axiomatize: the integral is well-defined
axiom true_process (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) (t : ℝ) : ℝ

-- Empirical process: kernel-smoothed empirical CDF deviation
-- F̂_k_h(t) = ∫ K_h(u - s_k) dF̂_n(u)
-- G_n(t) = √n (F̂_k_h(t) - F_k(t))
-- Axiomatize: the empirical process is well-defined
axiom empirical_process (K : ℝ → ℝ) (h : ℝ) (hh : h > 0) (n : ℕ) (t : ℝ) : ℝ

-- Supremum norm on functions
-- Axiomatize: the supremum is well-defined
axiom sup_norm (f : ℝ → ℝ) (domain : Set ℝ) : ℝ

-- If a function is bounded by B on a domain, its supremum norm is at most B
axiom sup_norm_le_of_bound {f : ℝ → ℝ} {domain : Set ℝ} {B : ℝ}
    (hbound : ∀ x ∈ domain, |f x| ≤ B) :
    sup_norm f domain ≤ B

-- Tightness: a sequence of random processes is tight
-- Mathematical meaning: for all ε > 0, there exists a compact set K
-- such that P(Xₙ ∈ K) > 1 - ε for all n
-- This is a key condition for weak convergence (Prokhorov's theorem)
axiom IsTight (Xₙ : ℕ → ℝ → ℝ) : Prop

end SpatialCvM.Theorem1.Definitions
