# Quick Reference: Spatial CvM Asymptotic Theory

## Key Mathematical Objects

### Data and Setup
| Object | Definition | Role |
|--------|-----------|------|
| $\{\mathbf{x}_i\}$ | Spatial locations on bounded domain $D \subset \mathbb{R}^d$ | Observation sites |
| $\{Y_i\}$ | Spatial marks (observations) | Data to be tested |
| $h$ | Bandwidth (fixed) | Kernel width parameter |
| $K_h$ | Spatial kernel: $K_h(\mathbf{u}) = h^{-d}K(\mathbf{u}/h)$ | Localization function |

### Empirical and Limiting Objects
| Object | Definition | Interpretation |
|--------|-----------|-----------------|
| $H_0(y)$ | Null CDF (e.g., uniform on $[0,1]$) | Null hypothesis |
| $\widehat{H}_{n,h}(y)$ | $\frac{1}{n}\sum_i K_h(\mathbf{x}_i)\mathbf{1}_{Y_i \le y}$ | Kernel-weighted empirical CDF |
| $\mathcal{GP}(y)$ | Zero-mean Gaussian process with covariance $\Gamma$ | Limiting empirical process |
| $T_n$ | Test statistic: $n\int(\widehat{H}_{n,h} - H_0)^2 dH_0$ | Goodness-of-fit measure |

### Covariance Structures
| Object | Definition | Property |
|--------|-----------|----------|
| $\gamma_d(y,z)$ | $\text{Cov}(Y_1(y), Y_{1+d}(z))$ | Lag-$d$ covariance |
| $\Gamma(y,z)$ | $\sum_{d=0}^\infty \gamma_d(y,z)$ | Asymptotic covariance (finite!) |
| $\Gamma_c$ | Operator: $(\Gamma_c\phi)(y) = \int \Gamma(y,z)\phi(z)dH_0(z)$ | Contrast covariance operator |
| $\lambda_m^*$ | $m$-th eigenvalue of $\Gamma_c$ (decreasing) | Spectral weights |
| $\phi_m^*$ | $m$-th eigenfunction of $\Gamma_c$ | Spectral basis |

### Distributional Objects
| Object | Definition | Interpretation |
|--------|-----------|-----------------|
| $Z_m$ | $\sim N(0,1)$ i.i.d. | Standard normals (independent) |
| $\chi^2_{k,m}$ | Chi-square with $k$ df, $m$-th copy | Chi-square building blocks |

---

## Four Core Results

### Lemma 1: Asymptotic Covariance
$$\boxed{\Gamma(y,z) = \sum_{d=0}^\infty \text{Cov}(Y_1(y), Y_{1+d}(z)) < \infty \quad \text{and} \quad \Gamma(0,0) > 0}$$

**Key insight**: Fixed bandwidth $\Rightarrow$ non-vanishing covariance (unlike shrinking-h asymptotics)

**Assumptions**:
- $\alpha$-mixing: $\sum_d \alpha(d) < \infty$
- Kernel $K_h$ bounded, continuous, compactly supported
- Marks $\{Y_i\}$ bounded and stationary

**Proof technique**: Davydov's inequality + summability of mixing rates

---

### Theorem 1: Weak Convergence
$$\boxed{\sqrt{n}(\widehat{H}_{n,h} - H_0) \xrightarrow{d} \mathcal{GP} \quad \text{in} \quad \ell^\infty[0,1]}$$

where $\mathcal{GP}$ is a zero-mean Gaussian process with covariance $\Gamma$.

**Three-step proof**:
1. **FDD**: Lindeberg CLT on finite grids → Gaussian limit
2. **Tightness**: Arzelà-Ascoli criterion via mixing bounds
3. **Convergence**: Portmanteau theorem combines FDD + tightness

**Critical feature**: $\Gamma$ remains non-degenerate (unlike classical shrinking-$h$ regime)

---

### Theorem 2: Asymptotic Null Distribution
$$\boxed{T_n \xrightarrow{d} \sum_{m=1}^\infty \lambda_m^* \chi^2_{K-1,m}}$$

where $\lambda_m^*$ are eigenvalues of contrast operator $\Gamma_c$.

**Interpretation**:
- **Weighted chi-square mixture**: Each eigenmode contributes independently
- **Weights $\lambda_m^*$ encode**:
  - Spatial kernel structure (bandwidth $h$)
  - Spatial dependence (mixing rate)
  - Null hypothesis structure
- **Degrees of freedom $K-1$**: From multinomial constraint ($K$ bins, 1 constraint)

**Proof steps**:
1. Continuous mapping: $T_n = \Phi(\sqrt{n}(\widehat{H}_{n,h} - H_0))$
2. Mercer expansion: $\mathcal{GP} = \sum_m \sqrt{\lambda_m^*}\phi_m^* Z_m$
3. Quadratic form: $\int \mathcal{GP}^2 dH_0 = \sum_m \lambda_m^* Z_m^2 = \sum_m \lambda_m^* \chi^2_{K-1,m}$

---

### Theorem 3: Multivariate Extension
$$\boxed{T_n^{(p)} \xrightarrow{d} \sum_{m=1}^\infty \lambda_m^{*,(p)} \chi^2_{K-1,m}}$$

**For multivariate marks** $\mathbf{Y}_i = (Y_{i,1}, \ldots, Y_{i,p})$

**Two innovations**:
1. **Copula decomposition** (Sklar): Factorize joint distribution into marginals + dependence
2. **Functional delta method** (Hadamard): Quantile function is differentiable in Banach space

**Result**: Same asymptotic theory applies to multivariate case
- Margins can have any distribution $F_j$
- Dependence captured by copula $C$ (empirical copula used, no parametric assumption)
- Test is invariant to monotone transformations

---

## Key Asymptotic Objects & Notation

### Convergence Modes
- $\xrightarrow{d}$ : Convergence in distribution
- $\pto$ : Convergence in probability  
- $\xrightarrow{\mathcal{L}}$ : Convergence in $\ell^\infty$
- $\|f\|_\infty = \sup_{y} |f(y)|$ : Supremum norm

### Function Spaces
- $\ell^\infty[0,1]$ : Bounded functions on $[0,1]$ with sup norm
- $L^2(dH_0)$ : Square-integrable functions w.r.t. measure $dH_0$
- $C[0,1]$ : Continuous functions

### Operators and Transforms
- **Kernel operator**: $(Kf)(y) = \int K(y,z) f(z) dz$ (integral transform)
- **Covariance operator**: $\Gamma$ acts as $(Γf)(y) = \int \Gamma(y,z) f(z) dH_0(z)$
- **Spectral decomposition**: $Γ = \sum_m \lambda_m \langle \cdot, \phi_m\rangle \phi_m$ (Mercer)

---

## Essential Inequalities & Lemmas

### 1. Davydov's Inequality (Mixing)
$$|\text{Cov}(X,Y)| \le 2\alpha(d) \|X\|_\infty \|Y\|_\infty$$
for dependent variables at distance $d$ apart.

**Usage**: Bounds covariances between observations at different lags.

### 2. Mercer's Theorem (Spectral Decomposition)
For continuous positive semi-definite kernel $\Gamma$ on $[0,1]^2$:
$$\Gamma(y,z) = \sum_{m=1}^\infty \lambda_m \phi_m(y) \phi_m(z)$$
with $\phi_m$ orthonormal, $\lambda_m \ge 0$ decreasing.

**Usage**: Decomposes Gaussian process into eigenmode expansion for test limit.

### 3. Lindeberg CLT (Mixing Sequences)
If $\{X_i\}$ satisfies Lindeberg condition and mixing $\sum \alpha < \infty$:
$$\frac{1}{\sigma_n}\sum_i X_i \xrightarrow{d} N(0,1)$$

**Usage**: Proves FDD convergence on finite point grids.

### 4. Prokhorov Tightness Criterion
Sequence tight iff: (a) modulus of continuity shrinks, (b) uniform moment bound.

**Usage**: Ensures weak convergence from FDD + tightness.

---

## Assumptions (Standing Conditions)

### A1: Domain & Locations
- $D \subset \mathbb{R}^d$ bounded lattice domain
- Points $\{\mathbf{x}_i\}$ ordered on regular grid
- $n \to \infty$ with asymptotic density

### A2: Mixing
- $\{Y_i\}$ $\alpha$-mixing: $\sum_{d=1}^\infty \alpha(d) < \infty$
- Exponential decay: $\alpha(d) \lesssim \rho^d$ for $\rho < 1$ (typical)

### A3: Kernel
- $K$ symmetric: $K(-\mathbf{u}) = K(\mathbf{u})$
- Compactly supported: $K(\mathbf{u}) = 0$ for $\|\mathbf{u}\| > 1$
- Normalization: $\int K(\mathbf{u}) d\mathbf{u} < \infty$
- Examples: uniform, Epanechnikov, Gaussian (truncated)

### A4: Marks
- Bounded: $|Y_i| \le M$ a.s. (ensures Lindeberg condition)
- Non-degenerate: $\text{Var}(Y_i) > 0$
- Stationarity: Joint distribution of $(Y_i, Y_{i+d})$ depends only on $d$ (not location)

---

## Satterthwaite Approximation (Practice)

The infinite-dimensional weighted chi-square can be approximated by:

$$\sum_{m=1}^\infty \lambda_m^* \chi^2_{K-1,m} \approx c^* \chi^2_{K-1}^*$$

where the effective parameters are:

$$c^* = \frac{\sum_m \lambda_m^*}{K-1}, \quad \text{df}^* = K-1$$

**Computation**:
1. Estimate $\hat{\lambda}_1, \ldots, \hat{\lambda}_M$ (spectrum of sample covariance)
2. Compute $\hat{c}^* = \frac{1}{K-1}\sum_{m=1}^M \hat{\lambda}_m^*$
3. Critical value: $c_\alpha = \hat{c}^* \cdot \chi^2_{K-1, 1-\alpha}$
4. Decision: Reject $H_0$ if $T_n > c_\alpha$

---

## Comparison: Fixed vs. Shrinking Bandwidth

| Aspect | Fixed-$h$ (This Paper) | Shrinking-$h$ (Classical) |
|--------|-------|-----------|
| **Bandwidth** | $h$ fixed for all $n$ | $h_n \to 0$ as $n \to \infty$ |
| **Consistency** | Non-consistent (doesn't reject all alternatives) | Consistent (rejects all alternatives) |
| **Null covariance** | $\Gamma(0,0) > 0$ (bounded away) | $\Gamma_n(0,0) \to 0$ (vanishes) |
| **Limiting distribution** | Weighted $\chi^2$ | Standard $\chi^2$ |
| **Test purpose** | Fixed-scale inference (spatial homogeneity at scale $h$) | Asymptotic power (large-$n$ correctness) |
| **Practical use** | Practitioners fix meaningful $h$ a priori | Data-driven bandwidth selection needed |

**Key innovation**: Fixed-$h$ asymptotic theory is simpler, non-degenerate, and matches practitioner intent.

---

## Computational Workflow

### Phase 1: Estimation
```
Input:  Data {(𝐱_i, Y_i)}, kernel K, bandwidth h, null H₀
1. Compute kernel matrix: K_h(𝐱_i)
2. Form empirical process: Ĥ_n,h(y) = (1/n) Σ_i K_h(𝐱_i) 1_{Y_i ≤ y}
3. Compute residuals: r_i(y) = √n [Ĥ_n,h(y) - H₀(y)]
```

### Phase 2: Spectral Analysis
```
4. Estimate covariance: Γ̂(y,z) = (1/n) Σ_{i,j} r_i(y) r_j(z)
5. Discretize on grid: 0 = y_0 < y_1 < ... < y_K = 1
6. Form covariance matrix: Γ̂_K ∈ ℝ^(K×K)
7. Eigendecomposition: Γ̂_K = U Λ U^T
8. Retain: λ̂_1 ≥ λ̂_2 ≥ ... ≥ λ̂_M > 0
```

### Phase 3: Test
```
9. Compute test statistic: T_n = n Σ_k (p̂_k - p_k)²/p_k
10. Satterthwaite parameter: ĉ^* = (1/(K-1)) Σ_m λ̂_m^*
11. Critical value: c_α = ĉ^* χ²_{K-1, 1-α}
12. Decision: Reject if T_n > c_α
```

---

## Common Pitfalls & Fixes

| Issue | Cause | Fix |
|-------|-------|-----|
| Test rejects everything | Bandwidth $h$ too large | Decrease $h$ (localize more) |
| Test rejects nothing | Bandwidth $h$ too small | Increase $h$ (broaden kernel) |
| Unstable eigenvalues | Undersmoothed covariance estimate | Regularize: use Ridge estimator |
| Negative eigenvalues | Numerical error in spectral decomposition | Use `svds` (truncated SVD) with threshold |
| Slow computation | Dense covariance matrix (large $K$) | Reduce $K$ (coarser bins) or use sparse approximation |

---

## References (Full Citation)

**Core asymptotic theory**:
- van der Vaart & Wellner (1996). *Weak Convergence and Empirical Processes*. Springer.
- Bickel & Wichura (1971). Convergence Criteria for Multiparameter Stochastic Processes. *Ann. Math. Stat.* 42(4), 1656–1670.

**Mixing and covariance**:
- Rio (1993). Covariance Inequalities for Weakly Dependent Random Variables. *Technical Report*, Université Paris-Sud.
- Davydov (1973). Invariance Principle for Stationary Processes. *Theory Probab. Appl.* 15(3), 498–509.

**Spatial statistics**:
- Cressie (1991). *Statistics for Spatial Data*. Wiley.
- Marcon & Puech (2017). Distance-Based Measures for Spatial Econometrics. *Ecol. Model.* 330, 30–37.

**Copula methods**:
- Segers (2012). Copulas: Tails and Limits of Dependence. *J. Econometrics* 172(1), 159–164.
- Sklar (1959). Fonctions de répartition à $n$ dimensions et leurs marges. *Publ. Inst. Stat. Univ. Paris* 8, 229–231.

---

**Document version**: April 2026  
**Purpose**: Quick mathematical reference for Spatial CvM asymptotic theory
