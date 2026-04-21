-- Theorem 1: Tightness via equicontinuity (SUB-LEMMA 2)
-- Strategy: Use Arzelà-Ascoli criterion (boundedness + equicontinuity ⟹ compactness)
-- Reference: van der Vaart & Wellner (1996), Appendix A.2
import SpatialCvM.Theorem1.Variance
import SpatialCvM.Theorem1.Definitions
import SpatialCvM.Definitions.RandomField
import SpatialCvM.Definitions.Kernel
import SpatialCvM.Lemma1.Main
import SpatialCvM.Lemma1.Mixing
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Topology.MetricSpace.Holder

namespace SpatialCvM.Theorem1.Tightness

open Filter Metric
open SpatialCvM.Definitions.RandomField
open SpatialCvM.Definitions.Kernel
open SpatialCvM.Theorem1.Definitions
open SpatialCvM.Lemma1.Mixing

-- ============================================================================
-- HELPER: Hölder Continuity
-- Hölder continuity implies uniform continuity on compact sets (like [0,1])
-- This is a standard result in analysis
@[simp]
theorem holder_continuity {f : ℝ → ℝ} (C : ℝ≥0) {γ : ℝ} (hγ : 0 < γ) 
    (h : HolderOnWith C ⟨γ, le_of_lt hγ⟩ f (Set.Icc 0 1)) :
    UniformContinuousOn f (Set.Icc 0 1) := by
  exact h.uniformContinuousOn hγ

-- ============================================================================
-- HELPER AXIOM: Arzelà-Ascoli (Compactness from Boundedness + Equicontinuity)
-- STATUS: Documented Axiom — Deep Theorem in Probability Theory
--
-- Mathematical Content:
--   Boundedness + equicontinuity ⟹ tightness (in the weak topology on C[0,1])
--
-- Context:
--   The Arzelà-Ascoli theorem states that a subset of C[0,1] (continuous functions
--   on [0,1]) is relatively compact if and only if it is bounded and equicontinuous.
--   For tightness of stochastic processes, this is applied pointwise in probability:
--   if the empirical process is bounded and equicontinuous with high probability,
--   then the sequence of probability measures is tight.
--
-- Why it Remains an Axiom:
--   Mathlib does not yet have the full theory of:
--   1. Weak convergence in the space of continuous functions C([0,1]) → ℝ
--   2. Prokhorov's theorem (relative compactness ⟺ tightness)
--   3. Empirical process theory (functional central limit theorems)
--   4. The specific topology of ℓ∞ (bounded functions under sup norm)
--
-- Implementation Path (when Mathlib is ready):
--   1. Use `Mathlib.Topology.Compactness.ArzelaAscoli` for the deterministic version
--   2. Lift to probability measures using `Mathlib.MeasureTheory.Measure.ProbabilityMeasure`
--   3. Apply Prokhorov's theorem from weak convergence theory
--   4. Connect to empirical process definition via sample paths
--
-- Reference: van der Vaart & Wellner (1996), "Weak Convergence and Empirical Processes",
--            Theorem 1.3.9 and Theorem 1.5.4
-- ============================================================================
axiom tightness_via_equicontinuity {fₙ : ℕ → ℝ → ℝ}
    (h_bound : ∃ M, ∀ n x, |fₙ n x| ≤ M)
    (h_equicont : ∀ ε > 0, ∃ δ > 0, ∀ n x y,
      |x - y| < δ → |fₙ n x - fₙ n y| < ε) :
    IsTight (fun n => fₙ n)

-- ============================================================================
-- HELPER: Empirical Process Properties (Axiomatized)
-- These axiomatize key properties of the empirical process needed for tightness proofs
-- In a full formalization, these would be proved from the definition of empirical_process

-- AXIOM: The empirical process is bounded by the scaled kernel supremum
-- Mathematical content: |Ẑₙ(t)| ≤ sup_u |K_h(u)| where K_h is the scaled kernel
axiom empirical_process_bound (K : ℝ → ℝ) (h : ℝ) (hh : h > 0)
    (n : ℕ) (t : ℝ) :
    |empirical_process K h hh n t| ≤ (1 / h^2) * sup_norm K (Set.Icc (-1) 1)

-- AXIOM: The empirical process differences are bounded by kernel differences
-- Mathematical content: |Ẑₙ(s) - Ẑₙ(t)| ≤ (1/h²) sup_u |K(s-u) - K(t-u)|
axiom empirical_process_diff_bound (K : ℝ → ℝ) (h : ℝ) (hh : h > 0)
    (n : ℕ) (s t : ℝ) :
    |empirical_process K h hh n s - empirical_process K h hh n t| ≤
    (1 / h^2) * sup_norm (fun u => K (s - u) - K (t - u)) (Set.Icc (-1) 1)

-- ============================================================================
-- SUB-LEMMA 2.1: Uniform Boundedness of Empirical Process
-- Mathematical Content:
--   The empirical process (kernel-smoothed CDF deviation) is bounded by kernel supremum
--   |Ẑₙ(t)| ≤ C for some constant C depending on kernel bounds and bandwidth h
--
-- Proof Strategy:
--   1. Extract bounded property from IsKernel (kernel has sup norm bound B)
--   2. Empirical process is average of kernel evaluations → bounded by kernel bound
--   3. Scale by h^{-2} factor from kernel smoothing
--
-- Reference: Follows from kernel boundedness (IsKernel property)

lemma empirical_process_bounded (K : ℝ → ℝ) (h : ℝ) (hh : h > 0)
    (hK : IsKernel K)
    (_α : ℝ → ℝ) (_h_mix : AlphaMixing _α) (_δ : ℝ) (_hδ : _δ > 0) :
    ∃ C > 0, ∀ (n : ℕ) (t : ℝ),
    |empirical_process K h hh n t| ≤ C := by
  obtain ⟨B, hB_pos, hB_bound⟩ := hK.bounded
  use B / (h ^ 2), by positivity
  intro n t
  have h_bound := empirical_process_bound K h hh n t
  have h_sup_le_B : sup_norm K (Set.Icc (-1) 1) ≤ B := by
  -- Show the set is nonempty (required for sSup to be well-defined)
  have h_nonempty : (Set.Icc (-1 : ℝ) 1).Nonempty := by
    use 0
    simp
  exact sup_norm_le_of_bound h_nonempty (fun x _ => hB_bound x)
  calc |empirical_process K h hh n t|
      ≤ (1 / h ^ 2) * sup_norm K (Set.Icc (-1) 1) := h_bound
    _ ≤ (1 / h ^ 2) * B := by
        apply mul_le_mul_of_nonneg_left h_sup_le_B
        positivity
    _ = B / h ^ 2 := by ring

-- ============================================================================
-- SUB-LEMMA 2.2: Equicontinuity via Skorokhod Modulus
-- Mathematical Content:
--   The empirical process is equicontinuous in the sense of Skorokhod
--   For all ε > 0, ∃ δ > 0 such that |s - t| < δ ⟹ |Ẑₙ(s) - Ẑₙ(t)| < ε
--
-- Proof Strategy:
--   1. Extract Lipschitz constant L from IsKernel
--   2. Kernel differences: |K(s) - K(t)| ≤ L|s - t|
--   3. Empirical process inherits Lipschitz property (kernel evaluations differ by ≤ L|s - t|)
--   4. Choose δ = ε / (2L) to ensure equicontinuity
--   5. Mixing bounds ensure probability concentration
--
-- Reference: Skorokhod modulus ω_δ(f) = sup_{|s-t|<δ} |f(s) - f(t)|

lemma empirical_process_equicontinuous (K : ℝ → ℝ) (h : ℝ) (hh : h > 0)
    (hK : IsKernel K)
    (_α : ℝ → ℝ) (_h_mix : AlphaMixing _α) (_δ : ℝ) (_hδ : _δ > 0) :
    ∀ ε > 0, ∃ δ' > 0, ∀ (n : ℕ) (s t : ℝ),
    |s - t| < δ' → |empirical_process K h hh n s - empirical_process K h hh n t| < ε := by
  intro ε hε
  obtain ⟨L, hL_pos, hL_lip⟩ := hK.lipschitz
  use ε * h ^ 2 / (2 * L)
  refine ⟨by positivity, fun n s t hst => ?_⟩
  have h_emp_diff := empirical_process_diff_bound K h hh n s t
  have h_kernel_diff_bound :
    sup_norm (fun u => K (s - u) - K (t - u)) (Set.Icc (-1) 1) ≤ L * |s - t| := by
    -- Show the set is nonempty
    have h_nonempty : (Set.Icc (-1 : ℝ) 1).Nonempty := by
      use 0
      simp
    apply sup_norm_le_of_bound h_nonempty
    intro u _
    calc |K (s - u) - K (t - u)|
        ≤ L * |(s - u) - (t - u)| := hL_lip (s - u) (t - u)
      _ = L * |s - t| := by ring_nf
  have h_emp_bound :
    |empirical_process K h hh n s - empirical_process K h hh n t| ≤ (L / h ^ 2) * |s - t| := by
    calc |empirical_process K h hh n s - empirical_process K h hh n t|
        ≤ (1 / h ^ 2) * sup_norm (fun u => K (s - u) - K (t - u)) (Set.Icc (-1) 1) := h_emp_diff
      _ ≤ (1 / h ^ 2) * (L * |s - t|) := by
          apply mul_le_mul_of_nonneg_left h_kernel_diff_bound
          positivity
      _ = (L / h ^ 2) * |s - t| := by ring
  have hhalf : (L / h ^ 2) * (ε * h ^ 2 / (2 * L)) = ε / 2 := by
    field_simp [ne_of_gt hL_pos, ne_of_gt hh]
  calc |empirical_process K h hh n s - empirical_process K h hh n t|
      ≤ (L / h ^ 2) * |s - t| := h_emp_bound
    _ < (L / h ^ 2) * (ε * h ^ 2 / (2 * L)) := by
        apply mul_lt_mul_of_pos_left hst
        positivity
    _ = ε / 2 := hhalf
    _ < ε := by linarith
-- ============================================================================
-- MAIN LEMMA: SUB-LEMMA 2 (Tightness)
--
-- Theorem Statement:
--   The empirical process is tight: the sequence {Ẑₙ : n ∈ ℕ} is relatively compact
--   in the space of continuous functions under the supremum norm.
--
-- Mathematical Meaning:
--   For any ε > 0, we can find a compact set K such that P(Ẑₙ ∈ K) > 1 - ε for all n
--   This is the key condition for weak convergence (Prokhorov's theorem)
--
-- Proof:
--   Apply Arzelà-Ascoli criterion: boundedness + equicontinuity ⟹ compactness
--   1. Uniform Boundedness (Sub-Lemma 2.1): |Ẑₙ(t)| ≤ C for all n, t
--   2. Equicontinuity (Sub-Lemma 2.2): Skorokhod modulus → equicontinuity
--   3. Arzelà-Ascoli (tightness_via_equicontinuity): Conclude tightness
--
-- Reference: van der Vaart & Wellner (1996), Theorem 1.5.4

lemma tightness_empirical_process (K : ℝ → ℝ) (h : ℝ) (hh : h > 0)
    (hK : IsKernel K)
    (α : ℝ → ℝ) (h_mix : AlphaMixing α) (δ : ℝ) (hδ : δ > 0) :
    IsTight (fun n => empirical_process K h hh n) := by
  -- Step 1: Extract uniform boundedness
  obtain ⟨C, hC_pos, hC_bound⟩ := empirical_process_bounded K h hh hK α h_mix δ hδ
  -- Step 2: Extract equicontinuity
  have h_equicont := empirical_process_equicontinuous K h hh hK α h_mix δ hδ
  -- Step 3: Apply Arzelà-Ascoli via tightness_via_equicontinuity
  -- This axiom encodes: boundedness + equicontinuity ⟹ compactness
  have h_bound : ∃ M, ∀ n t, |empirical_process K h hh n t| ≤ M := ⟨C, hC_bound⟩
  -- Apply tightness criterion with explicit boundedness and equicontinuity
  exact tightness_via_equicontinuity h_bound h_equicont

end SpatialCvM.Theorem1.Tightness
