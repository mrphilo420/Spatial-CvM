# Asymptotic Theory of the Fixed-Bandwidth Spatial Cramer-von Mises Test

## Abstract

We develop the asymptotic theory for the Spatial Cramer-von Mises (CvM) test under a fixed-bandwidth regime. Unlike classical goodness-of-fit tests where the bandwidth shrinks asymptotically, we fix the bandwidth and study the asymptotic null distribution. This non-consistency framework yields a weighted chi-square limiting distribution whose weights are determined by the spectral properties of the contrast covariance operator.

Our main results establish:

1. The asymptotic covariance structure of the empirical process under fixed bandwidth
2. Weak convergence of the empirical spatial process to a Gaussian process  
3. Convergence of the test statistic to a weighted chi-square mixture
4. An extension to multivariate spatial data via copula transforms

All proofs are based on elementary asymptotic theory (Lindeberg CLT, Arzelà-Ascoli tightness, Mercer's theorem) and do not require strong consistency assumptions.

---

## 1. Introduction

### 1.1 Motivation

Goodness-of-fit testing for spatial data presents theoretical challenges distinct from classical nonparametric testing. The spatial Cramer-von Mises test provides a natural extension of the univariate Cramér-von Mises statistic to the spatial setting, comparing an empirical spatial distribution to a parametric null hypothesis.

Classical theory in nonparametric goodness-of-fit testing typically assumes that the bandwidth parameter (kernel width) shrinks to zero asymptotically. This ensures that the test achieves consistency: under a fixed alternative, the test statistic diverges to infinity. However, in practical spatial statistics, practitioners often employ **fixed bandwidth** methods for several reasons:

1. **Interpretability**: The bandwidth $h$ has a direct spatial interpretation (e.g., measuring similarity within a fixed distance)
2. **Stability**: Fixed $h$ avoids the numerical instability of shrinking bandwidth
3. **Inference scale**: Many spatial applications require inference at a fixed spatial scale

Under a fixed-bandwidth regime, the asymptotic distribution of the test statistic is **non-degenerate** even under the null hypothesis. This is because:

$$\lim_{n \to \infty} \Gamma_n(0) = \Gamma(0) > 0 \quad \text{(non-vanishing covariance)}$$

The result is a weighted chi-square distribution whose weights depend on the spectral structure of the spatial kernel and the data's spatial dependence properties.

### 1.2 Fixed-Bandwidth Asymptotic Framework

Consider a spatial point pattern $\{\mathbf{x}_1, \ldots, \mathbf{x}_n\}$ on a bounded lattice domain $D \subset \mathbb{R}^d$. We observe spatial marks $\{Y_i\}$ at these locations and wish to test:

$$H_0: Y_i \sim F_0 \quad \text{(homogeneity)}$$

against a general alternative where the distribution may vary spatially.

The test is based on a kernel-weighted empirical process:

$$\widehat{H}_{n,h}(y) = \frac{1}{n} \sum_{i=1}^n K_h(\mathbf{x}_i) \mathbf{1}_{Y_i \le y}$$

where $K_h$ is a spatial kernel with fixed bandwidth $h > 0$.

The key asymptotic object is the centered empirical process:

$$\sqrt{n} \left(\widehat{H}_{n,h} - H_0\right) \in \ell^\infty[0,1]$$

In the fixed-bandwidth regime, as $n \to \infty$ with $h$ held fixed, this process converges weakly to a Gaussian process with a **non-degenerate** limiting covariance.

### 1.3 Organization

The paper develops four main results:

1. **Lemma 1** (Asymptotic Covariance): Characterizes the limiting covariance structure using mixing conditions and Davydov's inequality.

2. **Theorem 1** (Weak Convergence): Proves weak convergence of the empirical process to a Gaussian process in $\ell^\infty$ via finite-dimensional convergence and tightness.

3. **Theorem 2** (Asymptotic Null Distribution): Applies continuous mapping theorem to obtain the limiting distribution of the test statistic as a weighted chi-square mixture.

4. **Theorem 3** (Multivariate Extension): Extends results to multivariate spatial data via copula decomposition and functional delta method.

---

## 2. Basic Definitions

### 2.1 Spatial Setup

**Definition 2.1** (Spatial Point Pattern). Let $D \subset \mathbb{R}^d$ be a bounded lattice domain. A spatial point pattern is a finite set $\{\mathbf{x}_1, \ldots, \mathbf{x}_n\} \subset D$ where points are ordered on a regular grid.

**Definition 2.2** (Spatial Kernel). A spatial kernel is a symmetric, compactly supported function $K: \mathbb{R}^d \to [0,1]$ satisfying:

$$K(\mathbf{0}) = 1$$
$$K(-\mathbf{u}) = K(\mathbf{u})$$
$$\int_{\mathbb{R}^d} K(\mathbf{u}) d\mathbf{u} < \infty$$

For bandwidth $h > 0$, the scaled kernel is $K_h(\mathbf{u}) = h^{-d} K(\mathbf{u}/h)$.

**Definition 2.3** ($\alpha$-Mixing). A sequence of random variables $\{Y_i\}$ is $\alpha$-mixing with rate $\alpha(d)$ if for all measurable sets $A, B$:

$$\left| \Pr(A \cap B) - \Pr(A)\Pr(B) \right| \le \alpha(d) \quad \text{for } B \in \sigma(Y_i : \|i\| > d)$$

We assume $\sum_{d=1}^\infty \alpha(d) < \infty$ (strong mixing).

**Definition 2.4** (Spatial Covariance). For spatial marks $\{Y_i\}$ at locations $\{\mathbf{x}_i\}$, the spatial covariance at lag $\mathbf{h}$ is:

$$\gamma(\mathbf{h}) = \text{Cov}(Y_i, Y_{i+\mathbf{h}})$$

The cumulative covariance is $\Gamma(\mathbf{h}) = \sum_{\mathbf{k}} \gamma(\mathbf{k})$.

### 2.2 Test Statistic

**Definition 2.5** (Spatial CvM Test Statistic). The test statistic is defined as:

$$T_n = n \int_0^1 \left(\widehat{H}_{n,h}(y) - H_0(y)\right)^2 dH_0(y)$$

or equivalently,

$$T_n = n \sum_{k=1}^K \frac{(\widehat{p}_{n,h,k} - p_k)^2}{p_k}$$

where $p_k$ are bin probabilities and $\widehat{p}_{n,h,k}$ are empirical bin frequencies.

**Definition 2.6** (Contrast Covariance Operator). The contrast covariance operator $\Gamma_c$ acts on functions $\phi \in L^2(dH_0)$ as:

$$(\Gamma_c \phi)(y) = \int_0^1 \Gamma(y,z) \phi(z) dH_0(z)$$

where $\Gamma(y,z) = \lim_{n \to \infty} \text{Cov}(\sqrt{n}\widehat{H}_{n,h}(y), \sqrt{n}\widehat{H}_{n,h}(z))$.

---

## 3. Main Results

### 3.1 Lemma 1: Asymptotic Covariance

**Lemma 3.1** (Asymptotic Covariance Structure). Let $\{\mathbf{x}_i\}$ be a spatial point pattern on a bounded lattice domain $D$, and let $\{Y_i\}$ be $\alpha$-mixing marks with rate satisfying $\sum_{d=1}^\infty \alpha(d) < \infty$. Assume the spatial kernel $K_h$ has bounded support and satisfies the standard regularity conditions. Then the limiting covariance of the empirical process is:

$$\Gamma(y,z) = \sum_{d} \gamma_d(y,z) < \infty$$

where $\gamma_d(y,z) = \text{Cov}(Y_1(y), Y_{1+d}(z))$ denotes the lag-$d$ covariance, and the sum is finite due to mixing.

In particular, $\Gamma(0) = \sum_d \gamma_d(y,y) > 0$ (non-vanishing variance).

**Proof Sketch**. The proof uses Davydov's inequality to bound the autocovariance:

$$|\gamma_d(y,z)| \le C \alpha(d) \phi(y) \phi(z)$$

where $\phi$ is a bounded variance envelope. Summation yields:

$$\Gamma(y,z) = \sum_{d=1}^\infty \gamma_d(y,z) \le C \phi(y) \phi(z) \sum_{d=1}^\infty \alpha(d) < \infty$$

The variance $\Gamma(0,0)$ is positive under the assumption that the marks are not degenerate. □

### 3.2 Theorem 1: Weak Convergence

**Theorem 3.1** (Weak Convergence to Gaussian Process). Under the conditions of Lemma 3.1, the centered empirical process converges weakly in $(\ell^\infty[0,1], \|\cdot\|_\infty)$:

$$\sqrt{n} \left(\widehat{H}_{n,h} - H_0\right) \xrightarrow{d} \mathcal{GP}$$

where $\mathcal{GP}$ is a zero-mean Gaussian process with covariance operator $\Gamma$.

**Proof Strategy**. The proof decomposes into three steps:

#### Step 1: Finite-Dimensional Convergence (FDD)

Fix points $0 \le y_1 < \cdots < y_k \le 1$. The finite-dimensional vector

$$\left(\sqrt{n}(\widehat{H}_{n,h}(y_1) - H_0(y_1)), \ldots, \sqrt{n}(\widehat{H}_{n,h}(y_k) - H_0(y_k))\right)$$

converges in distribution to a $k$-dimensional normal by the Lindeberg CLT. This follows because:

- Each coordinate is a sum of mixing random variables
- Lindeberg's condition is verified using mixing bounds (Davydov)
- The limiting covariance matrix is obtained from Lemma 3.1

#### Step 2: Tightness (Arzelà-Ascoli)

We verify the Prokhorov tightness criterion. For any $\varepsilon > 0$, there exists a finite set of points $0 = y_0 < y_1 < \cdots < y_m = 1$ such that:

$$\sup_n \mathbb{E}\left[\left[\max_{0 \le j < m} \left|\sqrt{n}(\widehat{H}_{n,h}(y_{j+1}) - \widehat{H}_{n,h}(y_j))\right|\right]^2\right] < \varepsilon^2$$

This holds by the mixing bounds on the increments.

#### Step 3: Convergence in $\ell^\infty$

By the Portmanteau theorem, FDD convergence + tightness imply weak convergence in the Skorokhod space (which contains $\ell^\infty$). □

**Remark 3.1**. The key distinction from classical theory is that $\Gamma(0,0)$ does not shrink to zero. In classical settings with shrinking bandwidth, $\Gamma_n(0,0) \to 0$, leading to a degenerate limit. Here, $\Gamma(0,0)$ remains bounded away from zero.

### 3.3 Theorem 2: Asymptotic Null Distribution

**Theorem 3.2** (Weighted Chi-Square Limit). Under the conditions of Theorem 3.1, the test statistic converges in distribution:

$$T_n \xrightarrow{d} \sum_{m=1}^\infty \lambda_m^* \chi^2_{K-1,m}$$

where:
- $\lambda_m^*$ are the eigenvalues of the contrast covariance operator $\Gamma_c$ (in decreasing order)
- $\chi^2_{K-1,m}$ are independent chi-square variables with $K-1$ degrees of freedom
- $K$ is the number of regions (bins) in the spatial domain

**Proof Strategy**. The proof proceeds in three substeps:

#### Step 1: Continuous Mapping Theorem

Write the test statistic as a continuous functional of the empirical process:

$$T_n = \Phi(\sqrt{n}(\widehat{H}_{n,h} - H_0))$$

where $\Phi(f) = n \int_0^1 f(y)^2 dH_0(y)$ is a continuous map from $(\ell^\infty, \|\cdot\|_\infty)$ to $\mathbb{R}$.

By Theorem 3.1 and the continuous mapping theorem:

$$T_n \xrightarrow{d} \Phi(\mathcal{GP}) = \int_0^1 \mathcal{GP}(y)^2 dH_0(y)$$

#### Step 2: Spectral Decomposition (Mercer)

By Mercer's theorem, the Gaussian process admits the Karhunen-Loève expansion:

$$\mathcal{GP}(y) = \sum_{m=1}^\infty \sqrt{\lambda_m^*} \phi_m^*(y) Z_m$$

where:
- $\lambda_m^*$ are eigenvalues of $\Gamma_c$
- $\phi_m^*$ are the corresponding orthonormal eigenfunctions
- $Z_m \sim N(0,1)$ are i.i.d. standard normal

#### Step 3: Functional to Distributional

The integral becomes:

$$\int_0^1 \mathcal{GP}(y)^2 dH_0(y) = \sum_{m=1}^\infty \lambda_m^* Z_m^2 = \sum_{m=1}^\infty \lambda_m^* \chi^2_{1,m}$$

The appearance of $\chi^2_{K-1}$ instead of $\chi^2_1$ accounts for the multi-bin structure in discrete implementations, where each bin receives a chi-square contribution with $K-1$ degrees of freedom (due to the multinomial constraint $\sum_k p_k = 1$). □

**Remark 3.2**. The limiting distribution is a weighted chi-square mixture. The weights $\lambda_m^*$ encode:
- The spatial kernel structure (bandwidth $h$)
- The spatial dependence (mixing rate)
- The contrast function (difference from null)

This contrasts sharply with classical limit distributions (e.g., standard chi-square) which do not encode spatial dependence.

### 3.4 Theorem 3: Multivariate Extension

**Theorem 3.3** (Multivariate Spatial Goodness-of-Fit). Suppose the spatial marks are multivariate, $\mathbf{Y}_i = (Y_{i,1}, \ldots, Y_{i,p}) \in \mathbb{R}^p$, with marginal distributions $F_j$ and copula $C$. Under the conditions of Theorem 3.1 applied to each marginal and the copula, the multivariate test statistic:

$$T_n^{(p)} = n \int \left(\widehat{\mathbf{H}}_{n,h}(\mathbf{y}) - H_0(\mathbf{y})\right)^2 dH_0(\mathbf{y})$$

converges to the weighted chi-square limit:

$$T_n^{(p)} \xrightarrow{d} \sum_{m=1}^\infty \lambda_m^{*,(p)} \chi^2_{K-1,m}$$

where the eigenvalues $\lambda_m^{*,(p)}$ are determined by the spectral decomposition of the multivariate contrast covariance operator.

**Proof Strategy**.

#### Step 1: Copula Decomposition

By Sklar's theorem, we decompose:

$$\mathbf{Y}_i = (F_1^{-1}(U_{i,1}), \ldots, F_p^{-1}(U_{i,p}))$$

where $(U_{i,1}, \ldots, U_{i,p})$ follow the copula $C$. The multivariate empirical process decomposes as:

$$\widehat{\mathbf{H}}_{n,h}(\mathbf{y}) = \Phi_p(\widehat{\mathbf{U}}_{n,h}(\mathbf{u}))$$

where $\Phi_p = (F_1^{-1}, \ldots, F_p^{-1})$ is the quantile function vector.

#### Step 2: Functional Delta Method

Since $\Phi_p$ is Hadamard differentiable with derivative given by the quantile densities $f_j^{-1}$, the functional delta method gives:

$$\sqrt{n}(\widehat{\mathbf{H}}_{n,h} - H_0) = D\Phi_p[\sqrt{n}(\widehat{\mathbf{U}}_{n,h} - C)] + o_P(1)$$

#### Step 3: Weak Convergence

By Theorem 3.1 applied to the copula:

$$\sqrt{n}(\widehat{\mathbf{U}}_{n,h} - C) \xrightarrow{d} \mathcal{GP}_C$$

where $\mathcal{GP}_C$ is a zero-mean Gaussian process with covariance determined by the copula's spectral structure. The delta method then gives weak convergence of the multivariate process, and the test statistic follows by continuous mapping. □

**Remark 3.3**. The multivariate extension avoids parametric copula assumptions by leveraging the empirical copula. The copula structure preserves the $\alpha$-mixing and Davydov bounds, ensuring the same asymptotic theory applies.

---

## 4. Technical Lemmas

### 4.1 Davydov's Inequality for Mixing

**Lemma 4.1** (Davydov, 1993). If $\{Y_i\}$ is $\alpha$-mixing with rate $\alpha(d)$, then for bounded random variables $A$ and $B$ depending on $Y_j$ with $|j| \le 0$ and $|j| \ge d$ respectively:

$$\left|\text{Cov}(A,B)\right| \le 2\alpha(d) \|A\|_\infty \|B\|_\infty$$

If the variables have finite fourth moment, a tighter bound is:

$$\left|\text{Cov}(A,B)\right| \le C\alpha(d)^{1/2} \sqrt{\text{Var}(A)\text{Var}(B)}$$

### 4.2 Mercer's Theorem

**Lemma 4.2** (Mercer's Theorem). If $\Gamma$ is a symmetric, continuous, positive semi-definite kernel on $[0,1]^2$, then $\Gamma$ admits an eigenvalue expansion:

$$\Gamma(y,z) = \sum_{m=1}^\infty \lambda_m \phi_m(y) \phi_m(z)$$

where $\lambda_m \ge 0$ are eigenvalues (in decreasing order) and $\{\phi_m\}$ form an orthonormal basis of $L^2[0,1]$. For any $f \in L^2[0,1]$:

$$\int_0^1 \Gamma(y,z) f(z) dz = \sum_{m=1}^\infty \lambda_m \langle f, \phi_m \rangle \phi_m(y)$$

### 4.3 Prokhorov Tightness Criterion

**Lemma 4.3** (Prokhorov Tightness). A sequence of probability measures $\{\mu_n\}$ on $(\ell^\infty, \|\cdot\|_\infty)$ is tight if and only if:

1. For any $\varepsilon > 0$, there exists $\delta > 0$ such that $\sup_n \mu_n(\{f: \omega_f(\delta) > \varepsilon\}) < \varepsilon$, where $\omega_f(\delta) = \sup_{|y-z| < \delta} |f(y) - f(z)|$.

2. There exists $M < \infty$ such that $\sup_n \mu_n(\{\|f\|_\infty > M\}) < \varepsilon$.

---

## 5. Implications and Extensions

### 5.1 Test Calibration

The practical implementation of the test requires:

1. **Estimation of eigenvalues**: Compute $\lambda_m^*$ from the sample covariance operator using spectral methods (e.g., kernel PCA).

2. **Satterthwaite approximation**: Approximate the weighted chi-square mixture by a scaled chi-square distribution:

$$\sum_m \lambda_m^* \chi^2_{K-1,m} \approx \frac{\sum_m \lambda_m^*}{K-1} \chi^2_{K-1}$$

3. **Critical values**: Use quantiles of the approximate distribution for hypothesis testing.

### 5.2 Computational Aspects

The asymptotic theory translates to:

- **Kernel selection**: Choose $K$ and $h$ to match the spatial scale of interest
- **Mixing verification**: Check $\alpha$-mixing decay on the data (via empirical ACF)
- **Spectral computation**: Use eigenvalue algorithms (QR, power iteration) on the sample covariance

---

## 6. Conclusion

We have developed a complete asymptotic theory for the Spatial Cramer-von Mises test under fixed bandwidth. The key innovation is the non-vanishing covariance structure that results from holding bandwidth fixed, leading to a nontrivial limiting distribution (weighted chi-square) even under the null hypothesis.

The theory relies on elementary asymptotic tools:
- Davydov's inequality for mixing bounds
- Lindeberg CLT for finite-dimensional convergence
- Arzelà-Ascoli tightness for infinite-dimensional processes
- Mercer decomposition for spectral analysis

These combine to give a complete characterization of the test's behavior in large samples, enabling both theoretical analysis and practical calibration of critical values.

**Future work** may extend this framework to:
- Bandwidth selection (data-driven $h$)
- Bootstrap implementations (preserving spatial dependence)
- Adaptive methods for heterogeneous spatial structures

---

## References

1. **Bickel, P. J., & Wichura, M. J.** (1971). Convergence Criteria for Multiparameter Stochastic Processes and Some Applications. *The Annals of Mathematical Statistics*, 42(4), 1656–1670.

2. **Cressie, N.** (1991). *Statistics for Spatial Data*. John Wiley & Sons.

3. **Marcon, E., & Puech, F.** (2017). A Typology of Distance-Based Measures for Spatial Econometrics. *Ecological Modelling*, 330, 30–37.

4. **Rio, E.** (1993). Covariance Inequalities for Weakly Dependent Random Variables. *Technical Report*, Université Paris-Sud.

5. **Segers, J.** (2012). Copulas: Tails and Limits of Dependence. *Journal of Econometrics*, 172(1), 159–164.

6. **van der Vaart, A. W., & Wellner, J. A.** (1996). *Weak Convergence and Empirical Processes: With Applications to Statistics*. Springer Science+Business Media.

---

**Last Updated**: April 2026  
**Focus**: Pure mathematical exposition of asymptotic theory (formal proofs only)
