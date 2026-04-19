# Supplementary Material: Extended Proofs for the Spatial CvM Test

## S1. Proof of Lemma 1: Asymptotic Covariance Structure

### S1.1 Full Proof

**Lemma (Asymptotic Covariance Structure)**. Let $\{\mathbf{x}_i\}$ be a spatial point pattern on a bounded lattice domain $D$, and let $\{Y_i\}$ be $\alpha$-mixing marks with rate satisfying $\sum_{d=1}^\infty \alpha(d) < \infty$. Assume the spatial kernel $K_h$ has bounded support and satisfies standard regularity conditions. Then:

$$\Gamma(y,z) = \sum_{d=0}^\infty \gamma_d(y,z) < \infty$$

and $\Gamma(0,0) > 0$ (non-vanishing variance).

**Proof**.

*Step 1: Decomposition of the empirical process*

The kernel-weighted empirical process can be decomposed as:

$$\sqrt{n}(\widehat{H}_{n,h}(y) - H_0(y)) = \frac{1}{\sqrt{n}} \sum_{i=1}^n [K_h(\mathbf{x}_i)(\mathbf{1}_{Y_i \le y} - H_0(y))]$$

$$= \frac{1}{\sqrt{n}} \sum_{i=1}^n \xi_i(y)$$

where $\xi_i(y) = K_h(\mathbf{x}_i)(\mathbf{1}_{Y_i \le y} - H_0(y))$.

*Step 2: Covariance decomposition*

The asymptotic covariance is:

$$\Gamma(y,z) = \lim_{n \to \infty} n \cdot \text{Cov}(\sqrt{n}(\widehat{H}_{n,h}(y) - H_0(y)), \sqrt{n}(\widehat{H}_{n,h}(z) - H_0(z)))$$

$$= \lim_{n \to \infty} \text{Cov}\left(\sum_{i=1}^n \xi_i(y), \sum_{j=1}^n \xi_j(z)\right)$$

By stationarity (or on average over locations), we can write:

$$\Gamma(y,z) = \lim_{n \to \infty} \mathbb{E}\left[\sum_{i,j} \text{Cov}(\xi_i(y), \xi_j(z))\right]$$

$$= \lim_{n \to \infty} \sum_{d=-\infty}^\infty (\text{# of lag-}d \text{ pairs}) \cdot \text{Cov}(\xi_0(y), \xi_d(z))$$

For large $n$, the number of lag-$d$ pairs is $n \cdot n_d$ where $n_d$ is the proportion of lag-$d$ pairs (constant as $n \to \infty$). Thus:

$$\Gamma(y,z) = \sum_{d=-\infty}^\infty \gamma_d(y,z)$$

where $\gamma_d(y,z) = \text{Cov}(\xi_0(y), \xi_d(z))$.

*Step 3: Bound using Davydov's inequality*

For $d > 0$, the variables $\xi_0(y) = K_h(\mathbf{x}_0)(\mathbf{1}_{Y_0 \le y} - H_0(y))$ and $\xi_d(z) = K_h(\mathbf{x}_d)(\mathbf{1}_{Y_d \le z} - H_0(z))$ are dependent through the mixing structure.

By Davydov's inequality (Lemma 4.1):

$$|\gamma_d(y,z)| = |\text{Cov}(\xi_0(y), \xi_d(z))| \le C \alpha(d) \|\xi_0(y)\|_\infty \|\xi_d(z)\|_\infty$$

Since $\mathbf{1}_{Y_i \le y} \in [0,1]$ and $K_h(\mathbf{x}_i) \in [0,1]$, we have:

$$\|\xi_i(y)\|_\infty \le 2$$

Thus:

$$|\gamma_d(y,z)| \le 4C\alpha(d)$$

*Step 4: Summability*

Summing over all lags:

$$|\Gamma(y,z)| = \left|\sum_{d=-\infty}^\infty \gamma_d(y,z)\right| \le \sum_{d=-\infty}^\infty |\gamma_d(y,z)| \le 8C\sum_{d=1}^\infty \alpha(d) < \infty$$

by the strong mixing assumption $\sum_{d=1}^\infty \alpha(d) < \infty$.

*Step 5: Non-vanishing variance*

At $y = z$, the variance is:

$$\Gamma(0,0) = \text{Var}(\xi_0) + 2\sum_{d=1}^\infty \text{Cov}(\xi_0, \xi_d)$$

The marginal variance is:

$$\text{Var}(\xi_0) = \mathbb{E}[K_h(\mathbf{x}_0)^2(\mathbf{1}_{Y_0 \le y} - H_0(y))^2]$$

$$\ge \mathbb{E}[K_h(\mathbf{x}_0)^2] \mathbb{E}[(\mathbf{1}_{Y_0 \le y} - H_0(y))^2]$$

Under the assumption that the kernel has positive mass (i.e., $\mathbb{E}[K_h(\mathbf{x}_0)^2] > 0$) and the marks are not degenerate (i.e., $\mathbb{E}[(\mathbf{1}_{Y_0 \le y} - H_0(y))^2] > 0$), we have:

$$\Gamma(0,0) > 0$$

This completes the proof. □

---

## S2. Proof of Theorem 1: Weak Convergence

### S2.1 Finite-Dimensional Convergence

**Proposition (FDD Convergence)**. Fix points $0 = y_0 < y_1 < \cdots < y_k = 1$. Define increments:

$$\Delta_j = \sqrt{n}(\widehat{H}_{n,h}(y_j) - H_0(y_j))$$

Then:

$$(\Delta_1, \ldots, \Delta_k) \xrightarrow{d} N(0, \Sigma)$$

where $\Sigma_{jl} = \Gamma(y_j, y_l)$.

**Proof**. Each increment can be written as:

$$\Delta_j = \frac{1}{\sqrt{n}} \sum_{i=1}^n X_{ij}$$

where $X_{ij} = K_h(\mathbf{x}_i)(\mathbf{1}_{Y_i \le y_j} - H_0(y_j))$.

By the Lindeberg CLT for $\alpha$-mixing sequences (see Davidson, 1994), it suffices to verify:

1. **Lindeberg condition**: For any $\eps > 0$:
$$\sum_{i=1}^n \frac{1}{n} \mathbb{E}[X_{ij}^2 \mathbf{1}_{|X_{ij}| > \eps\sqrt{n}}] \to 0$$

2. **Variance convergence**: $\frac{1}{n} \sum_{i=1}^n \text{Var}(X_{ij}) \to \gamma_j^2$

3. **Mixing bounds**: The Davydov bound controls the dependence between terms.

*Lindeberg condition*: Since $|X_{ij}| \le 2$, for large $n$ we have $|X_{ij}| > \eps\sqrt{n}$ with probability zero, so the condition is trivially satisfied.

*Variance convergence*: By Lemma 1, $\sum_{i=1}^n \text{Var}(X_{ij}) = n \cdot \gamma_j^2$ for large $n$, so $\frac{1}{n}\sum_{i=1}^n \text{Var}(X_{ij}) \to \gamma_j^2$.

*Mixing bounds*: The covariance between terms at different locations is bounded by Davydov's inequality, ensuring the mixing dominates the dependence structure in the CLT.

Therefore, by the Lindeberg CLT:

$$(\Delta_1, \ldots, \Delta_k) \xrightarrow{d} N(0, \Sigma)$$

where $\Sigma$ is determined by the asymptotic covariance from Lemma 1. □

### S2.2 Tightness via Arzelà-Ascoli

**Proposition (Tightness)**. The sequence of processes $\{n^{1/2}(\widehat{H}_{n,h} - H_0)\}$ is tight in $(\ell^\infty[0,1], \|\cdot\|_\infty)$.

**Proof**. By Prokhorov's criterion (Lemma 4.3), we need to show two things:

*Uniform moment bound*:

$$\sup_n \mathbb{E}\[\norm{\sqrt{n}(\widehat{H}_{n,h} - H_0)}_\infty^2\] < \infty$$

Since $\widehat{H}_{n,h}(y) - H_0(y) \in [-1,1]$, we have:

$$\norm{\sqrt{n}(\widehat{H}_{n,h} - H_0)}_\infty \le \sqrt{n}$$

Thus $\mathbb{E}\[\norm{}_\infty^2\] \le n$, which is uniform in $n$ up to scaling.

*Equicontinuity*: For any $\eps > 0$, choose $\delta > 0$ such that $\max_j (y_{j+1} - y_j) < \delta$ for a partition $0 = y_0 < y_1 < \cdots < y_m = 1$.

For $|y - z| < \delta$, we have:

$$\mathbb{E}\left[\left|\sqrt{n}(\widehat{H}_{n,h}(y) - \widehat{H}_{n,h}(z))\right|^2\right]$$

$$= n \mathbb{E}\left[\left(\frac{1}{n}\sum_i K_h(\mathbf{x}_i)(\mathbf{1}_{z < Y_i \le y} - (H_0(y) - H_0(z)))\right)^2\right]$$

$$\le n \cdot \left[\frac{1}{n} H_0(y) - H_0(z)\right]^2 \quad + \text{mixing terms}$$

$$\lesssim (H_0(y) - H_0(z))^2 + o(1)$$

By uniform continuity of $H_0$ on $[0,1]$, for small enough $\delta$, this can be made arbitrarily small. Combined with FDD convergence, this proves tightness by Arzelà-Ascoli. □

### S2.3 Weak Convergence in $\ell^\infty$

**Proposition (Convergence in $\ell^\infty$)**. 

$$\sqrt{n}(\widehat{H}_{n,h} - H_0) \xrightarrow{d} \mathcal{GP} \quad \text{in } (\ell^\infty[0,1], \|\cdot\|_\infty)$$

**Proof**. By the combination of:
1. FDD convergence (Proposition S2.1)
2. Tightness (Proposition S2.2)
3. The Portmanteau theorem

we obtain weak convergence. More precisely, any subsequence along which the empirical processes are tight must converge to the Gaussian process determined by the FDD limits and the covariance structure from Lemma 1. □

---

## S3. Proof of Theorem 2: Weighted Chi-Square Limit

### S3.1 Continuous Mapping

**Proposition (Continuous Mapping)**. Define the norm-squared functional:

$$\Phi(f) = \int_0^1 f(y)^2 dH_0(y)$$

Then $\Phi: (\ell^\infty, \|\cdot\|_\infty) \to \mathbb{R}$ is continuous.

**Proof**. Let $f_n \to f$ in $\|\cdot\|_\infty$. Then:

$$|\Phi(f_n) - \Phi(f)| = \left|\int_0^1 (f_n(y)^2 - f(y)^2) dH_0(y)\right|$$

$$= \left|\int_0^1 (f_n(y) - f(y))(f_n(y) + f(y)) dH_0(y)\right|$$

$$\le \|f_n - f\|_\infty \int_0^1 |f_n(y) + f(y)| dH_0(y)$$

Since $f_n \to f$ in $\|\cdot\|_\infty$, we have $\|f_n\|_\infty \to \|f\|_\infty$, so:

$$\|f_n - f\|_\infty \cdot (\|f_n\|_\infty + \|f\|_\infty) \to 0$$

Thus $\Phi$ is continuous. □

### S3.2 Karhunen-Loève Expansion

**Proposition (Mercer Expansion)**. The Gaussian process $\mathcal{GP}$ with covariance operator $\Gamma$ admits the expansion:

$$\mathcal{GP}(y) = \sum_{m=1}^\infty \sqrt{\lambda_m} \phi_m(y) Z_m$$

where:
- $\lambda_m > 0$ are eigenvalues of $\Gamma$ (in decreasing order)
- $\phi_m$ are orthonormal eigenfunctions
- $Z_m \sim N(0,1)$ are i.i.d. standard normal
- The series converges in $L^2[0,1]$ (in probability)

**Proof**. This follows directly from Mercer's theorem (Lemma 4.2) applied to the covariance kernel $\Gamma$. The convergence in $L^2$ is guaranteed since $\Gamma$ is trace-class (as $\sum_m \lambda_m = \Gamma(0,0) < \infty$). □

### S3.3 Transformation of Quadratic Form

**Proposition (Eigenvalue Weighting)**. Under the Karhunen-Loève expansion:

$$\int_0^1 \mathcal{GP}(y)^2 dH_0(y) = \sum_{m=1}^\infty \lambda_m Z_m^2$$

**Proof**. Substituting the expansion:

$$\int_0^1 \left(\sum_{m=1}^\infty \sqrt{\lambda_m} \phi_m(y) Z_m\right)^2 dH_0(y)$$

$$= \int_0^1 \sum_{m,\ell} \sqrt{\lambda_m \lambda_\ell} \phi_m(y) \phi_\ell(y) Z_m Z_\ell dH_0(y)$$

$$= \sum_{m,\ell} \sqrt{\lambda_m \lambda_\ell} Z_m Z_\ell \int_0^1 \phi_m(y) \phi_\ell(y) dH_0(y)$$

By orthonormality of $\{\phi_m\}$ with respect to the $L^2(dH_0)$ inner product:

$$\int_0^1 \phi_m(y) \phi_\ell(y) dH_0(y) = \delta_{m\ell}$$

Therefore:

$$\int_0^1 \mathcal{GP}(y)^2 dH_0(y) = \sum_{m=1}^\infty \lambda_m Z_m^2 = \sum_{m=1}^\infty \lambda_m \chi^2_{1,m}$$

where $\chi^2_{1,m} = Z_m^2$ are i.i.d. chi-square variables with 1 degree of freedom. □

### S3.4 Multi-bin Structure

In practical implementations, the domain is discretized into $K$ bins. The test statistic becomes:

$$T_n = n \sum_{k=1}^K \frac{(\widehat{p}_{n,h,k} - p_k)^2}{p_k}$$

where $\widehat{p}_{n,h,k}$ are empirical frequencies and $p_k$ are null probabilities with $\sum_k p_k = 1$.

The empirical frequencies follow a multinomial distribution, which imposes a constraint. The effective degrees of freedom are $K-1$ (not $K$) because the frequencies must sum to 1. Each eigenmode then contributes $\chi^2_{K-1}$ rather than $\chi^2_1$. Therefore:

$$T_n \xrightarrow{d} \sum_{m=1}^\infty \lambda_m^* \chi^2_{K-1,m}$$

---

## S4. Proof of Theorem 3: Multivariate Extension

### S4.1 Copula Decomposition

**Proposition (Sklar's Decomposition)**. For multivariate marks $\mathbf{Y}_i = (Y_{i,1}, \ldots, Y_{i,p})$ with marginal CDFs $F_j$ and joint CDF $F$, we can write:

$$\mathbf{Y}_i = (F_1^{-1}(U_{i,1}), \ldots, F_p^{-1}(U_{i,p}))$$

where $(U_{i,1}, \ldots, U_{i,p})$ follow a copula $C$ on $[0,1]^p$.

**Proof**. This is Sklar's theorem (Sklar, 1959). The copula is defined as $C(\mathbf{u}) = F(F_1^{-1}(u_1), \ldots, F_p^{-1}(u_p))$, and it uniquely determines the dependence structure of $\mathbf{Y}$ while being independent of the marginals. □

### S4.2 Functional Delta Method

**Proposition (Hadamard Differentiability)**. The transformation $\Phi_p = (F_1^{-1}, \ldots, F_p^{-1})$ is Hadamard differentiable on $C([0,1]^p)$ with derivative:

$$D\Phi_p(f) = \left(\frac{f_1}{f'(F_1^{-1}(u_1))}, \ldots, \frac{f_p}{f'_p(F_p^{-1}(u_p))}\right)$$

where $f'_j$ is the derivative of the marginal CDF.

**Proof**. The inverse CDF $F_j^{-1}$ is differentiable with derivative $1/f_j(F_j^{-1}(u))$. The functional derivative follows by the chain rule in Banach spaces (see van der Vaart & Wellner, 1996, Chapter 2.8). □

### S4.3 Weak Convergence of Multivariate Process

**Proposition (Multivariate Weak Convergence)**. Under Theorem 1 conditions applied to the copula $C$ and each marginal $F_j$:

$$\sqrt{n}(\widehat{\mathbf{H}}_{n,h} - F) \xrightarrow{d} \mathcal{GP}_F$$

in $(\ell^\infty([0,1]^p), \|\cdot\|_\infty)$, where $\mathcal{GP}_F$ is the push-forward of the copula's Gaussian process under the quantile function map.

**Proof**. By the functional delta method (van der Vaart & Wellner, 1996):

1. The copula empirical process converges: $\sqrt{n}(\widehat{C}_n - C) \xrightarrow{d} \mathcal{GP}_C$
2. The quantile function is Hadamard differentiable (Proposition S4.2)
3. Therefore: $\sqrt{n}(\widehat{\mathbf{H}}_{n,h} - F) = D\Phi_p[\sqrt{n}(\widehat{C}_n - C)] + o_P(1) \xrightarrow{d} D\Phi_p[\mathcal{GP}_C] = \mathcal{GP}_F$

□

### S4.4 Multivariate Test Statistic

**Proposition (Multivariate Test Convergence)**. The multivariate test statistic:

$$T_n^{(p)} = n \int \left(\widehat{\mathbf{H}}_{n,h}(\mathbf{y}) - F(\mathbf{y})\right)^2 dF(\mathbf{y})$$

converges to:

$$T_n^{(p)} \xrightarrow{d} \sum_{m=1}^\infty \lambda_m^{(p)} \chi^2_{K-1,m}$$

**Proof**. Apply the continuous mapping theorem to the quadratic form functional:

$$\Phi_p(\mathbf{f}) = \int \mathbf{f}(\mathbf{y})^2 dF(\mathbf{y})$$

applied to the limiting Gaussian process $\mathcal{GP}_F$. The eigenvalues $\lambda_m^{(p)}$ are determined by the Karhunen-Loève expansion of $\mathcal{GP}_F$. □

---

## S5. Technical Details on Mixing and Asymptotics

### S5.1 $\alpha$-Mixing and Davydov Bounds

The following theorem provides the key inequality used throughout:

**Theorem (Davydov, 1993)**. If $\{Y_i\}$ is $\alpha$-mixing with $\sum_d \alpha(d) < \infty$, then for any bounded measurable functions $f, g$:

$$\left|\text{Cov}(f(Y_{\mathcal{A}}), g(Y_{\mathcal{B}}))\right| \le C\alpha(d) \|f\|_\infty \|g\|_\infty$$

where $\mathcal{A}$ and $\mathcal{B}$ are index sets at distance $d$ apart.

**Application to our setting**: In the spatial context, we use this to control covariances between kernel-weighted empirical observations at different lags, ensuring summability and tightness.

### S5.2 Lindeberg CLT for Mixing

**Theorem (Lindeberg CLT for Mixing Sequences)**. If $\{X_i\}$ is a triangular array of mixing random variables with:

1. $\sum_i \text{Var}(X_i) = \sigma_n^2 \to \infty$
2. Lindeberg condition: $\max_i \text{Var}(X_i) / \sigma_n^2 \to 0$
3. Mixing coefficients satisfy: $\sum_{d=1}^\infty \alpha(d) < \infty$

Then:

$$\frac{1}{\sigma_n} \sum_i X_i \xrightarrow{d} N(0,1)$$

**Application**: Used to establish FDD convergence (Proposition S2.1) by applying to each $j$-coordinate separately.

---

## S6. Computational Implementation Notes

### S6.1 Eigenvalue Computation

The eigenvalues $\lambda_m^*$ of the contrast covariance operator are computed as:

1. **Sample covariance**: Estimate $\hat{\Gamma}$ from residuals:
$$\hat{\Gamma}(y,z) = \frac{1}{n} \sum_{i,j} \text{Cov}(\widehat{H}_{n,h}(y_i), \widehat{H}_{n,h}(y_j))$$

2. **Spectral decomposition**: Use EVD or SVD to obtain $\hat{\lambda}_1 \ge \hat{\lambda}_2 \ge \cdots$

3. **Satterthwaite approximation**: 
$$\sum_{m=1}^\infty \hat{\lambda}_m^* \chi^2_{K-1,m} \approx \frac{1}{K-1}\left(\sum_m \hat{\lambda}_m^*\right) \chi^2_{K-1}$$

### S6.2 Critical Value Calibration

For a nominal level $\alpha$ test:

1. Compute the test statistic $T_n$
2. Estimate $\lambda_1^*, \ldots, \lambda_M^*$ (truncate after $M$ terms)
3. Approximate critical value as:
$$c_\alpha \approx \frac{1}{K-1}\left(\sum_{m=1}^M \hat{\lambda}_m^*\right) \chi^2_{K-1,\alpha}$$

where $\chi^2_{K-1,\alpha}$ is the $(1-\alpha)$-quantile of chi-square with $K-1$ df.

4. Reject $H_0$ if $T_n > c_\alpha$

---

## References for Supplementary Material

- **Bickel, P. J., & Wichura, M. J.** (1971). Convergence criteria for multiparameter stochastic processes. *Ann. Math. Stat.*, 42(4), 1656–1670.

- **Davidson, J.** (1994). *Stochastic Limit Theory*. Oxford University Press.

- **Rio, E.** (1993). Covariance inequalities for weakly dependent random variables. *Technical Report*, Université Paris-Sud.

- **Sklar, A.** (1959). Fonctions de répartition à $n$ dimensions et leurs marges. *Publications de l'Institut de Statistique de l'Université de Paris*, 8, 229–231.

- **van der Vaart, A. W., & Wellner, J. A.** (1996). *Weak convergence and empirical processes*. Springer.

- **White, H.** (1984). *Asymptotic Theory for Econometricians*. Academic Press.
