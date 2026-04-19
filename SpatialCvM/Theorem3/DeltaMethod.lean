-- Theorem 3: Functional delta method
import SpatialCvM.Theorem3.Hadamard

namespace SpatialCvM.Theorem3.DeltaMethod

open Filter

-- Functional delta method (van der Vaart–Wellner 3.9.4)
-- Deep result in empirical process theory
axiom functional_delta_method {E F : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [NormedAddCommGroup F] [NormedSpace ℝ F]
    {fₙ : ℕ → E → F} {f : E → F}
    {φ : E → ℝ} {dφ : E → (E →L[ℝ] ℝ)}
    (h_conv : Tendsto fₙ Filter.atTop (� f))
    (h_hadamard : ∀ x, HasFDerivAt φ (dφ x) x) :
    Tendsto (fun n => φ ∘ fₙ n) Filter.atTop (𝓝 (φ ∘ f))

end SpatialCvM.Theorem3.DeltaMethod
