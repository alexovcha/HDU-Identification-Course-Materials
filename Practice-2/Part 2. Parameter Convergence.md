---
Teacher: Alexey Ovcharov
tags:
  - LRM
  - Approximation
  - Convergence
  - Hypotheses
date: 2026-10-14
---

Consider a system of linear regression equations (LRE) with noise $v$:
$$
\begin{aligned}
y &= 2x_{1} + 5x_{2} + v \\
y &= -3x_{1} + 8x_{2} + v \\
y &= -5x_{1} + 2x_{2} + v \\
y &= 12x_{1} - 8.3x_{2} + v \\
y &= 7x_{1} - 3x_{2} + v \\
y &= -2x_{1} - 8x_{2} + v \\
y &= 1.1x_{1} + 5.32x_{2} + v \\
y &= 1.1x_{1} + 5.32x_{2} + v
\end{aligned}
$$

In vector form: 
$$
y = \begin{bmatrix} x_{1} & x_{2} \end{bmatrix}
    \begin{bmatrix} 2 \\ 5 \end{bmatrix}
$$
For each LRE, you have to check five hypotheses to guarantee that $\mathbb{E}\{\hat{\theta}\} = \theta$.

---
## Theorem 2
[[Lecture_3_Estimation.pdf#page=10&selection=0,0,0,14|Lecture_3_Estimation, page 10]]

Let a linear estimate be formed as: 
$$
\hat{\theta} = \left(\Phi^{\top} \Phi\right)^{-1} \Phi^{\top} Y
$$
Then **if**
- $\mathbb{E}\{v\} = 0$ **(H1)**,
- $v$ and $\varphi_i$ are independent, meaning $\mathbb{E}\{v \varphi_i\} = \mathbb{E}\{v\}\,\mathbb{E}\{\varphi_i\}$ **(H2)**,
the estimate $\hat{\theta}$ is **unbiased**, i.e., $\mathbb{E}\{\hat{\theta}\} = \theta$.

**Moreover, if**
- $\mathbb{D}\{v\} = \sigma^{2}_{v} = \text{const}$ **(H4)**,
- $\mathbb{D}\{v\} = \sigma^{2}_{v} \mathcal{I}$, i.e., $R_{v}(\tau) = 0$ for $\tau \neq 0$ **(H5)**,
then $\hat{\theta}$ is an **effective estimate**, i.e., the best within the linear class.

---

## Task

We have a system with two regressors $x_1$ and $x_2$, and the output $y$. The noise $v$ is unknown. Load the data from the `*.mat` file provided by the teacher.

Then complete the following steps:

1. **Write the model in vector form:** $$
   y = \boldsymbol{\varphi}^{\top} \boldsymbol{\theta}
   $$This means "output = (known stuff) × (unknown coefficients)".

2. **Build the extended regression:** Stack all equations into one big matrix equation: $$
   Y = \Phi \theta
   $$ where $Y$ is the output vector, $\Phi = [x_1, x_2]$ is the regressor matrix, and $\theta = [2, 5]^\top$ is the parameter vector.

3. **Estimate the parameters (Least Squares):**$$
   \hat{\theta} = \left(\Phi^{\top} \Phi\right)^{-1} \Phi^{\top} Y
   $$

4. **Find the error:** The noise $v$ is usually an unknown signal. Assume that the error of the output approximately equals the noise:$$
   v \approx \tilde{Y} = Y - \hat{Y} = Y - \Phi \hat{\theta}
   $$

5. **Check the hypotheses below** using the estimated error $v=\tilde{Y}$ and the regressors $\varphi_1$, $\varphi_2$. For each hypothesis, use the corresponding threshold from the [[#Threshold Values]] table. Mark **+** if the hypothesis passes and **−** if it fails, and record the result in the [[#Results Table]].

---

## Hypotheses to Check

### H1 — Zero mean
The expected value of the noise is zero:
$$
\mathbb{E}\{v\} = 0
$$
**How to check:** Compute the mean of $v$ (or $\tilde{Y}$) and compare it to a small threshold. Also plot a histogram to visually confirm the distribution is centered at zero.

---

### H2 — Independence from regressors
The noise signal $v$ is independent of all regressor elements $\varphi_i$: 
$$
\mathbb{E}\{v \varphi_i\} = \mathbb{E}\{v\}\,\mathbb{E}\{\varphi_i\}
$$
**How to check:** Compute the correlation coefficient between each regressor and the noise:
$$
\text{corr}(\varphi_i, v)
$$
If the correlation is close to zero, the regressor and noise are independent. Use `corrcoef` in MATLAB to compute this.

---

### H3 — Nonsingular regressor matrix
$$
\det\left(\Phi^{\top} \Phi\right) \neq 0
$$
**How to check:** Compute the determinant and the condition number of $\Phi^{T} \Phi$. If
$$
\det\left(\Phi^{T} \Phi\right) \approx 0 \quad \text{or} \quad \text{cond}\left(\Phi^{T} \Phi\right) > 1000
$$
the matrix is close to singular, and the parameters cannot be estimated reliably.

---

### H4 — Constant dispersion
$$
\mathbb{D}\{v\} = \sigma^{2}_{v} = \text{const}
$$
**How to check:** Split the noise signal into several windows (e.g., 10 parts) and compute the variance in each window. If the variance stays roughly constant across all windows, H4 holds. Plot the variance versus the window index — the curve should be approximately flat.

---

### H5 — No autocorrelation
The noise $v(k)$ is not an autocorrelated process: 
$$
\mathbb{D}\{v\} = \sigma^{2}_{v} \mathcal{I}, \quad R_{v}(\tau) = 0 \text{ for } \tau \neq 0
$$
**How to check:** Compute the autocorrelation function of $v$. If the autocorrelation is close to zero for all non-zero lags, H5 holds. Use `autocorr` in MATLAB — the plot should show a single peak at lag 0 and values within the confidence bounds elsewhere.

---

## Threshold Values

Use the following thresholds when checking each hypothesis:

| Hypothesis | Quantity                        | Threshold            | Condition to pass                                                         |     |
| ---------- | ------------------------------- | -------------------- | ------------------------------------------------------------------------- | --- |
| H1         | $\mathbb{E}\{v\}$               | $\varepsilon = 0.01$ | $\lvert \mathbb{E}\{v\} \rvert < \varepsilon \cdot (v_{\max} - v_{\min})$ |     |
| H2         | $\text{corr}(\varphi_i, v)$     | $\varepsilon = 0.1$  | $\lvert \text{corr}(\varphi_i, v) \rvert < \varepsilon$                   |     |
| H3         | $\text{cond}(\Phi^{\top}\Phi)$  | $\varepsilon = 1000$ | $\text{cond}(\Phi^{\top}\Phi) < \varepsilon$                              |     |
| H4         | $\mathbb{D}(v)$ over windows    | $\varepsilon = 1$    | $\max(\mathbb{D}) - \min(\mathbb{D}) < \varepsilon$                       |     |
| H5         | $R_{v}(\tau)$ for $\tau \neq 0$ | confidence bounds    | all values inside bounds                                                  |     |
|            |                                 |                      |                                                                           |     |

---
## Results Table

Fill in the table below: put **+** if the hypothesis passes and **−** if it fails for each case.

| Case | Equation                   | H1  | H2  | H3  | H4  | H5  |
| ---- | -------------------------- | --- | --- | --- | --- | --- |
| 1    | $y = 2x_1 + 5x_2 + v$      | +   |     |     |     |     |
| 2    | $y = -3x_1 + 8x_2 + v$     |     |     |     |     |     |
| 3    | $y = -5x_1 + 2x_2 + v$     |     |     |     |     |     |
| 4    | $y = 12x_1 - 8.3x_2 + v$   |     |     |     |     |     |
| 5    | $y = 7x_1 - 3x_2 + v$      |     |     |     |     |     |
| 6    | $y = -2x_1 - 8x_2 + v$     |     |     |     |     |     |
| 7    | $y = 1.1x_1 + 5.32x_2 + v$ |     |     |     |     |     |
| 8    | $y = 1.1x_1 + 5.32x_2 + v$ |     |     |     |     |     |

---
## Results to Show the Teacher

- **Graphics** of $Y$, $\varphi_{1}$, and $\varphi_{2}$
- **Graphics** of $v$ and $\tilde{Y}$
- **Histogram** of $v$ and $\tilde{Y}$
- **Graphic** of $\mathbb{D}\left(\Phi^{\top} \Phi\right)$
- **Graphics** with the autocorrelation for $v$ and $\tilde{Y}$

---
## Submission

You must complete all tasks and submit the following files.

> **Important:** Save each file with the **exact name** shown below. Do not rename the files.

- `Part_1_task.m`
- `Part_1_task_noise.m`
- `Part_2_task_case_1.m`
- `Part_2_task_case_2.m`
- `Part_2_task_case_3.m`
- `Part_2_task_case_4.m`
- `Part_2_task_case_5.m`
- `Part_2_task_case_6.m`
- `Part_2_task_case_7.m`
- `Part_2_task_case_8.m`
- `Part_2_results.csv`

Each Part 2 file corresponds to one case from the task (1, 2, 3, ..., 8). The case number must match the equation number in the task.

You must also submit a **CSV file** with the results table. Fill in **+** if the hypothesis passes and **−** if it fails for each case. Save the file as `Part_2_results.csv`.

Example of the CSV file format:
```csv
Case, Equation,                     H1, H2, H3, H4, H5
1,    y = 2*x1 + 5*x2 + v,          +,  +,  +,  +,  +
2,    y = -3*x1 + 8*x2 + v,         -,  +,  +,  -,  +
3,    y = -5*x1 + 2*x2 + v,         +,  +,  -,  +,  +
4,    y = 12*x1 - 8.3*x2 + v,       +,  +,  +,  +,  +
5,    y = 7*x1 - 3*x2 + v,          +,  +,  +,  +,  +
6,    y = -2*x1 - 8*x2 + v,         +,  +,  +,  +,  +
7,    y = 1.1*x1 + 5.32*x2 + v,     +,  +,  +,  +,  +
8,    y = 1.1*x1 + 5.32*x2 + v,     +,  +,  +,  +,  +
```
Note: the example above is a template — fill in your own results based on your analysis.

Upload all files here: **[https://forms.yandex.ru/cloud/6acec2a02c4f89fcfd1bb19c](https://forms.yandex.ru/cloud/6acec2a02c4f89fcfd1bb19c)**

Good luck!