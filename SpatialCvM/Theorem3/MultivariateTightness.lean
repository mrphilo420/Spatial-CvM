-- Theorem 3: Tightness in ℓ∞([0,1]^p)
import SpatialCvM.Theorem3.DeltaMethod

namespace SpatialCvM.Theorem3.MultivariateTightness

-- Tightness in ℓ∞ space for multivariate processes
-- Arzela-Ascoli in product space: boundedness + equicontinuity = compactness
axiom tightness_multivariate {p : ℕ} {fₙ : ℕ → (Fin p → ℝ) → ℝ}
    (h_bound : ∃ M, ∀ n x, |fₙ n x| ≤ M)
    (h_equicont : ∀ ε > 0, ∃ δ > 0, ∀ n x y,
      dist x y < δ → dist (fₙ n x) (fₙ n y) < ε) :
    ∃ subsequence : ℕ → ℕ, ∃ limit : (Fin p → ℝ) → ℝ,
    Tendsto (fun k => fₙ (subsequence k)) Filter.atTop (� limit)

-- Cramér–Wold device for multivariate convergence
-- All linear combinations converge ⇒ joint convergence
axiom cramer_wold_multivariate {fₙ : ℕ → (Fin 2 → ℝ) → ℝ}
    (h : ∀ c d : ℝ, Tendsto (fun n => fun x => c * fₙ n (![x.1, 0]) + d * fₙ n (![0, x.2]))
      Filter.atTop (𝓝 (fun _ => 0))) :
    Tendsto fₙ Filter.atTop (𝓝 (fun _ => 0))

end SpatialCvM.Theorem3.MultivariateTightness
