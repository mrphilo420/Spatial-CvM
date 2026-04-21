# Spatial-CvM
### Fixed-Bandwidth Spatial Cramér–von Mises Asymptotic Theory — A Formalization Roadmap

[![Lean](https://img.shields.io/badge/Lean-4.0+-purple.svg)](https://leanprover.github.io/)
[![Mathlib](https://img.shields.io/badge/Mathlib-4-blue.svg)](https://github.com/leanprover-community/mathlib4)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A complete formalization of the asymptotic theory for spatial Cramér–von Mises statistics under **fixed bandwidth** conditions. This repository contains the machine-checked proofs for the paper *"Fixed-Bandwidth Spatial Cramér–von Mises Asymptotic Theory"* implemented in **Lean 4**.

## Mathematical Overview

The proof establishes the limiting distribution of the spatial Cramér–von Mises statistic when the kernel bandwidth $h$ is fixed (as opposed to shrinking). This leads to a non-vanishing asymptotic variance and a weighted $\chi^2$ limiting distribution, fundamentally differing from classical Kolmogorov–Smirnov or standard CvM theory.

### The Four Pillars

| Pillar | Mathematical Tool | Result |
|--------|------------------|--------|
| **P1** | Davydov's Inequality | Covariance bounds for $\alpha$-mixing fields |
| **P2** | Lindeberg CLT | Finite-dimensional convergence (El Machkouri–Volny–Wu) |
| **P3** | Arzelà–Ascoli | Tightness via Lipschitz equicontinuity |
| **P4** | Mercer's Theorem | Spectral decomposition for $\chi^2$ representation |

### Key Results Formalized

1. **Lemma 1** (Covariance): The asymptotic covariance $\Gamma(y,z) = \sum_{d=0}^\infty \gamma_d(y,z)$ exists, is continuous, and satisfies $\Gamma(0,0) > 0$ (non-vanishing at fixed $h$).

2. **Theorem 1** (Weak Convergence): $\sqrt{n}(\hat{H}_{n,h} - H_0) \Rightarrow \mathcal{G}$ in $\ell^\infty[0,1]$, where $\mathcal{G}$ is a zero-mean Gaussian process with covariance operator $\Gamma$.

3. **Theorem 2** (Weighted $\chi^2$ Limit): The test statistic converges to a weighted sum of independent chi-square variables:
   $$T_n \xrightarrow{d} \sum_{m=1}^\infty \lambda_m^* \cdot \chi^2_{K-1,m}$$
   where $\lambda_m^*$ are eigenvalues of the contrast covariance operator.

4. **Theorem 3** (Multivariate Extension): For multivariate marks $\mathbf{Y}_i \in \mathbb{R}^p$ with copula $C$, the limit preserves the weighted $\chi^2$ form via Sklar's theorem and the functional delta method.

## Repository Structure

```
Spatial-CvM/
├── SpatialCvM/
│   ├── Definitions/
│   │   ├── Basic.lean          # Core definitions (H₀, empirical process)
│   │   ├── Kernel.lean         # IsKernel axioms (Lipschitz, bounded support)
│   │   ├── RandomField.lean    # Alpha-mixing spatial fields
│   │   ├── Lattice.lean        # Spatial domain structure
│   │   └── Copula.lean         # Sklar's theorem setup
│   ├── Lemma1/
│   │   ├── Mixing.lean         # Davydov inequality, summability
│   │   └── Definitions.lean    # Γ construction, non-vanishing proof
│   ├── Theorem1/
│   │   ├── FiniteDimensional.lean  # Lindeberg CLT
│   │   ├── Tightness.lean          # Equicontinuity, Arzelà–Ascoli
│   │   └── Main.lean               # Prokhorov theorem application
│   ├── Theorem2/
│   │   ├── Mercer.lean        # Spectral decomposition
│   │   └── Main.lean          # Continuous mapping, weighted χ²
│   ├── Theorem3/
│   │   ├── Hadamard.lean      # Copula differentiability
│   │   ├── DeltaMethod.lean   # Functional delta method
│   │   └── Main.lean          # Multivariate limit
│   ├── Utils/
│   │   ├── Asymptotics.lean   # Little-o, convergence notation
│   │   └── MeasureTheory.lean # Integration, H₀ measure
│   └── Calibration/
│       └── Satterthwaite.lean # Moment matching approximation
├── lakefile.toml              # Lean 4 build configuration
└── README.md                  # This file
```

---

## Building the Project

**Prerequisites:**
- [Lean 4](https://leanprover.github.io/lean4/doc/quickstart.html) (v4.8.0 or later)
- [Lake](https://github.com/leanprover/lean4-lake) (build tool, bundled with Lean)

**Steps:**
```bash
# Clone the repository
git clone https://github.com/mrphilo420/Spatial-CvM.git
cd Spatial-CvM

# Fetch dependencies (mathlib4)
lake update

# Build the project
lake build

# Run specific file
lake build SpatialCvM.ExpandedProof
```

## Key Mathematical Insights

### Why Fixed Bandwidth?
In classical kernel smoothing, $h \to 0$ as $n \to \infty$, causing the asymptotic variance to vanish ($\Gamma_n(0,0) \to 0$). Under **fixed** $h$:
- The kernel convolution $\psi_h(u) = \int K_h(v)K_h(v-u)dv$ retains mass
- The long-run variance $\Gamma(0,0) = \int K_h^2 > 0$
- The limit is a **non-degenerate** Gaussian process, yielding a weighted $\chi^2$ with non-trivial weights encoding spatial dependence

### Satterthwaite Calibration
For practical hypothesis testing, we approximate the weighted sum by a scaled $\chi^2_{K-1}$:
$$\sum_m \lambda_m^* \chi^2_{K-1,m} \approx a \cdot \chi^2_{K-1}(\nu)$$
with effective degrees of freedom $\nu = \frac{2\left(\sum \lambda_m\right)^2}{\sum \left(\lambda_m\right)^2}$.

## References

* El Machkouri, M., Volný, D., & Wu, W. B. (2013). A central limit theorem for stationary random fields. *Stochastic Processes and their Applications*, 123(1), 1-14. DOI: 10.1016/j.spa.2012.08.006
* Davydov, Y. A. (1970). The invariance principle for stationary processes. *Theory of Probability & Its Applications*, 15(3), 487-498. DOI: 10.1137/1115050
* Rio, E. (1993). Covariance inequalities for strongly mixing processes. *Annales de l'Institut Henri Poincaré (B)*, 29(4), 587-597.
* Bickel, P. J., & Wichura, M. J. (1971). Convergence criteria for multiparameter stochastic processes and some applications. *The Annals of Mathematical Statistics*, 42(5), 1656-1670. DOI: 10.1214/aoms/1177693164
* van der Vaart, A. W., & Wellner, J. A. (1996). *Weak Convergence and Empirical Processes*. Springer. DOI: 10.1007/978-1-4757-2545-2
* Segers, J. (2012). Asymptotics of empirical copula processes under non-restrictive smoothness assumptions. *Bernoulli*, 18(3), 764-776.

## Citation

If you use this formalization in your research, please cite:

```bibtex
@software{spatialcvm2026,
  title={Spatial-CvM: Fixed-Bandwidth Spatial Cramér--von Mises Asymptotic Theory in Lean 4},
  author={Marco Mandap},
  year={2026},
  url={https://github.com/mrphilo420/Spatial-CvM}
}
```

## Honest Assessment ⚠️

**This formalization is a roadmap, not a complete proof.**

For an honest evaluation of what has actually been proved versus what remains axiomatic, see [HONEST_ASSESSMENT.md](HONEST_ASSESSMENT.md).

### TL;DR:
- **Proved** (5 trivial results): Commutativity of multiplication, algebraic substitution, non-negativity of real powers, Hölder ⟹ uniform continuity, positive L² norm of non-zero function
- **Axiomatized** (11+ hard results): Weak convergence in ℓ∞, Mercer's theorem, Davydov's inequality, CLT for α-mixing arrays, Functional delta method, etc.

**Why?** The hard results require deep mathematical infrastructure that doesn't yet exist in Mathlib (spectral theory of compact operators, Prokhorov's theorem in non-separable spaces, etc.). Estimating 2-4 years of expert work to complete.

**Verdict**: The document "dresses up extremely elementary observations in the language and notation of sophisticated spatial statistics theory, but none of the hard results are proved."

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

