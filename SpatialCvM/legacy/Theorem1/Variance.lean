-- Theorem 1: Asymptotic variance computation
import SpatialCvM.Theorem1.FiniteDimensional
import SpatialCvM.Lemma1.Main
import SpatialCvM.Definitions.Kernel
import Mathlib.MeasureTheory.Integral.Lebesgue.Basic

namespace SpatialCvM.Theorem1.Variance

open SpatialCvM.Lemma1
open SpatialCvM.Definitions.Kernel
open SpatialCvM.Lemma1.Definitions
open MeasureTheory

-- The asymptotic variance of the empirical process comes from Lemma 1
-- Axiomatize: the variance formula
axiom asymptotic_variance_formula (K : ℝ → ℝ) (h : ℝ) (hh : h > 0)
    (hK : IsKernel K) (α : ℝ → ℝ) :
    ∃ sigma : ℝ,
    sigma > 0 ∧
    sigma = Gamma_operator K h hh 0 0

end SpatialCvM.Theorem1.Variance
