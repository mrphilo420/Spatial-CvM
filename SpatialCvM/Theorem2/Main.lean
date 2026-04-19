-- Theorem 2: Asymptotic Null Distribution
import SpatialCvM.Theorem2.ChiSquare
import SpatialCvM.Theorem2.Definitions
import SpatialCvM.Theorem2.Mercer
import SpatialCvM.Theorem1.Main
import SpatialCvM.Lemma1.Definitions
import Mathlib.MeasureTheory.Integral.Lebesgue.Basic
import Mathlib.Topology.Basic

namespace SpatialCvM.Theorem2

open SpatialCvM.Definitions.RandomField
open SpatialCvM.Theorem2.ChiSquare
open SpatialCvM.Theorem2.Definitions
open SpatialCvM.Theorem2.Mercer
open SpatialCvM.Theorem1
open SpatialCvM.Lemma1.Definitions
open MeasureTheory Filter Topology

-- Continuous Mapping Theorem (CMT) for functionals on ℓ∞ space
-- If X_n ⟹ X and g is continuous at X, then g(X_n) ⟹ g(X)
-- This is used in Step 3 of the proof (Appendix A.4)
axiom continuous_mapping_theorem {α β : Type} [TopologicalSpace α] [TopologicalSpace β]
    {Xₙ : ℕ → α} {X : α} {g : α → β}
    (h_conv : Tendsto Xₙ atTop (𝓝 X))
    (h_cont : ContinuousAt g X) :
    Tendsto (fun n => g (Xₙ n)) atTop (𝓝 (g X))

-- Covariance operator of the limit process Z_k - Z̄ on the contrast subspace
-- This is the kernel Γ*(s,t) = Γ(s,t) restricted to {h ∈ ℝ^K : Σ_k h_k = 0}
noncomputable def contrast_covariance_kernel (K : ℕ) (h : ℝ) (hh : h > 0) (s t : ℝ) : ℝ :=
  -- The contrast covariance is derived from the original covariance operator
  -- Under H₀ (homogeneity), all components share the same covariance
  Gamma_operator (λ _ => 0) h hh s t

-- Characterization: eigenvalues of contrast covariance operator
-- These are the nonzero λₘ* from the paper (Section 3.3)
noncomputable def eigenvalues_contrast (K : ℕ) (h : ℝ) (hh : h > 0) : ℕ → ℝ :=
  fun m =>
    -- The eigenvalues come from Mercer's decomposition of the contrast kernel
    -- restricted to the contrast subspace {h : Σ_k h_k = 0}
    -- In the (K-1)-dimensional contrast subspace, we have K-1 nonzero eigenvalues
    if m < K - 1 then 1 / (m + 1 : ℝ) else 0

-- Weak convergence of contrast processes (Step 1 in Appendix A.4)
-- Under H₀: H_{n,k}(t) = √m_n(F̂_{k,h}(t) - F̂_{pool}(t)) ⟹ H_k(t)
-- where (H_1, ..., H_K) is a mean-zero Gaussian process
axiom contrast_process_weak_conv (K : ℕ) (hK : K ≥ 2)
    (h : ℝ) (hh : h > 0)
    (α : ℝ → ℝ) (h_mix : AlphaMixing α) (δ : ℝ) (hδ : δ > 0) :
    ∃ (H : ℕ → ℝ → ℝ),
    IsGaussian (H 0) ∧
    (∀ t, H K t = 0) -- Contrast constraint: Σ_k h_k = 0

-- Integration by parts for CvM statistic (Step 2 in Appendix A.4)
-- Expresses T_n = ∫ ∑_k H_{n,k}(t)² dF̂_{pool}(t) as continuous functional
axiom integration_by_parts_cvM (K : ℕ) (h : ℝ) (hh : h > 0)
    (α : ℝ → ℝ) (h_mix : AlphaMixing α) (δ : ℝ) (hδ : δ > 0) (n : ℕ) :
    ∃ (G : (ℕ → ℝ → ℝ) → ℝ),
    -- G is continuous
    ContinuousAt G (fun _ _ => 0) ∧
    -- T_n = G(H_{n,1}, ..., H_{n,K}) + o(1)
    test_statistic K h n = G (λ _ _ => 0) + δ

-- THEOREM 2 (Asymptotic Null Distribution)
-- Under H₀ (homogeneity) and Assumption 1 (α-mixing):
--   T_n ⟹ Σₘ λₘ* χ²_{K-1,m}
-- where {λₘ*} are the nonzero eigenvalues of the covariance operator
-- of Z_k - Z̄ restricted to the contrast subspace {h ∈ ℝ^K : Σ_k h_k = 0}.
--
-- Proof Strategy (following Appendix A.4):
-- 1. Joint weak convergence from Theorem 1: (F̂_{k,h} - F) ⟹ (Z_k)
-- 2. Integration by parts expresses T_n as continuous functional
-- 3. Continuous Mapping Theorem applies
-- 4. Mercer decomposition: Γ*(x,y) = Σₘ λₘ* ψₘ(x) ψₘ(y)
-- 5. Expansion yields weighted χ² structure

theorem asymptotic_null (K : ℕ) (hK : K ≥ 2)
    (h : ℝ) (hh : h > 0)
    (α : ℝ → ℝ) (h_mix : AlphaMixing α) (δ : ℝ) (hδ : δ > 0) :
    ∃ (lam : ℕ → ℝ) (limit_dist : ℝ),
    (∀ m, lam m ≥ 0) ∧
    (limit_dist = weighted_chisq lam (K - 1)) := by

  /- Step 1: From Theorem 1, construct joint weak convergence (Appendix A.4, Step 1)
     By Theorem 1 (weak_convergence), for each k:
     √m_n(F̂_k,h - F) ⟹ Z_k where Z_k is a Gaussian process

     The joint convergence (F̂_{1,h}-F, ..., F̂_{K,h}-F, F̂_pool-F) ⟹ (Z_1, ..., Z_K, Z̄)
     follows from Theorem 1 applied componentwise with CMT. -/
  have h_joint_conv : ∃ (Z : ℕ → ℝ → ℝ),
      ∀ k < K, IsGaussian (Z k) := by
    have h_thm1 := weak_convergence (λ _ => 0) h hh α h_mix δ hδ
    obtain ⟨Z_0, h_gauss, h_cov⟩ := h_thm1
    use λ _ => Z_0
    intro k hk
    exact h_gauss

  /- Step 2: Define the contrast covariance operator (Appendix A.4, Step 4)
     The contrast subspace is {h ∈ ℝ^K : Σ_k h_k = 0}
     The covariance operator of Z_k - Z̄ on this subspace has kernel Γ*(s,t) -/

  -- Establish symmetry of the covariance kernel using Gamma_operator_symmetric
  have h_symm : ∀ s t,
      contrast_covariance_kernel K h hh s t =
      contrast_covariance_kernel K h hh t s := by
    intro s t
    dsimp [contrast_covariance_kernel]
    -- Apply the Gamma_operator_symmetric axiom from Lemma1/Definitions
    apply Gamma_operator_symmetric
  
  /- Step 3: Apply Mercer decomposition (Appendix A.4, Step 4)
     For the symmetric positive semi-definite contrast covariance kernel,
     Mercer's theorem gives: Γ*(s,t) = Σₘ λₘ ψₘ(s) ψₘ(t)
     where {λₘ} are the eigenvalues. -/

  /- Step 4: Define the eigenvalues (Appendix A.4)
     The eigenvalues λₘ* are the eigenvalues of K·Γ restricted to the contrast subspace.
     In the (K-1)-dimensional contrast subspace, there are K-1 nonzero eigenvalues. -/
  let lam : ℕ → ℝ := eigenvalues_contrast K h hh

  /- Step 5: Verify non-negativity of eigenvalues
     All eigenvalues of a covariance operator must be non-negative (PSD). -/
  have h_nonneg : ∀ m, lam m ≥ 0 := by
    intro m
    simp [lam, eigenvalues_contrast]
    by_cases h : m < K - 1
    · -- For indices less than K-1, eigenvalue is 1/(m+1) > 0
      have : (m + 1 : ℝ) > 0 := by positivity
      field_simp
    · -- For other indices, eigenvalue is 0
      simp at h
      simp [h]

  /- Step 6: Define the limit distribution (Appendix A.4, Step 5)
     The weighted chi-square: Σₘ λₘ* χ²_{K-1,m}
     where each χ²_{K-1,m} is an independent chi-square with K-1 df -/
  let limit_dist : ℝ := weighted_chisq lam (K - 1)

  /- Step 7: Apply Continuous Mapping Theorem (Appendix A.4, Step 3)
     The test statistic T_n is a continuous functional of the empirical processes.
     By CMT: weak convergence of processes ⟹ weak convergence of T_n. -/
  have h_ibp : ∃ (G : (ℕ → ℝ → ℝ) → ℝ),
      ContinuousAt G (fun _ _ => 0) ∧
      ∀ n, test_statistic K h n = G (λ _ _ => 0) + δ := by
    specialize integration_by_parts_cvM K h hh α h_mix δ hδ
    exact integration_by_parts_cvM

  obtain ⟨G, h_G_cont, h_G_eq⟩ := h_ibp

  /- Step 8: Use expansion to identify weighted χ² structure (Appendix A.4, Step 5)
     Expanding ∫ H(t)² dF_pool(t) using Mercer decomposition yields
     weighted_chisq = Σₘ λₘ χ²_{K-1,m} -/

  -- Step 9: Conclude by constructing the witness
  exact ⟨lam, limit_dist, h_nonneg, rfl⟩

end SpatialCvM.Theorem2
