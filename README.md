# Spatial-CvM
### Fixed-Bandwidth Spatial Cramér–von Mises Asymptotic Theory

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

* Davydov, Y. A. (1993). On the strong mixing property for linear sequences. *Theory of Probability & Its Applications*.
* El Machkouri, M., Volný, D., & Wu, W. B. (2013). A central limit theorem for stationary random fields. *Stochastic Processes and their Applications*.
* Segers, J. (2012). Asymptotics of empirical copula processes under non-restrictive smoothness assumptions. *Bernoulli*.

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

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

