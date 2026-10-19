---
Teacher: Alexey Ovcharov
tags:
  - LRM
  - Approximation
date: 2026-10-14
---

> We want to approximate $y = \sin(t)$ using polynomials. A polynomial is a sum of terms like $a + bt + ct^2 + \dots$ where the coefficients ($a$, $b$, $c$, ...) are **unknown** and must be found.

We will try three polynomial models, from simple to complex:

**Model 1 — Straight Line (2 parameters):**
$$
y = at + b = \begin{bmatrix} t & 1 \end{bmatrix} \begin{bmatrix} a \\ b \end{bmatrix}
$$

**Model 2 — Parabola (3 parameters):**
$$
y = at^2 + bt + c = \begin{bmatrix} t^2 & t & 1 \end{bmatrix} \begin{bmatrix} a \\ b \\ c \end{bmatrix}
$$

**Model 3 — High-Order Polynomial (11 parameters):**
$$
y = a_0 + a_1 t + a_2 t^2 + \dots + a_{10} t^{10} = \begin{bmatrix} t^{10} & t^{9} & \dots & t & 1 \end{bmatrix} \begin{bmatrix} a_0 \\ a_1 \\ \vdots \\ a_{10} \end{bmatrix}
$$

In each case, the model has the form $y = \boldsymbol{\varphi}^{\top} \boldsymbol{\theta}$, where $\boldsymbol{\varphi}$ contains known values and $\boldsymbol{\theta}$ contains unknown coefficients. More parameters means a more flexible curve, but also more risk of overfitting.

---

## Task

We have data points on the interval $t \in [-2\pi, 2\pi]$ with step $\pi/100$, with true value $y = \sin(t)$.

Then complete the following steps for each of the three models:
1. **Write the model in vector form:**
   $$
   y = \boldsymbol{\varphi}^{\top} \boldsymbol{\theta}
   $$
   This means "output = (known stuff) × (unknown coefficients)".

2. **Build the extended regression:** For each measurement point $t_i$, we can write a single equation:
   $$
   \begin{aligned}
   y(t_1) &= \boldsymbol{\varphi}(t_1)^{\top} \boldsymbol{\theta} \\
   y(t_2) &= \boldsymbol{\varphi}(t_2)^{\top} \boldsymbol{\theta} \\
   &\vdots \\
   y(t_N) &= \boldsymbol{\varphi}(t_N)^{\top} \boldsymbol{\theta}
   \end{aligned}
   $$
   Stacking all equations into one big matrix equation:
   $$
   Y = \Phi \theta
   $$
   where
   $$
   Y = \begin{bmatrix} y(t_1) \\ y(t_2) \\ \vdots \\ y(t_N) \end{bmatrix}, \quad
   \Phi = \begin{bmatrix} \boldsymbol{\varphi}(t_1)^{\top} \\ \boldsymbol{\varphi}(t_2)^{\top} \\ \vdots \\ \boldsymbol{\varphi}(t_N)^{\top} \end{bmatrix}
   $$
   **Model 1 (2 parameters):**
   $$
   \begin{bmatrix} y(t_1) \\ y(t_2) \\ \vdots \\ y(t_N) \end{bmatrix}
   =
   \begin{bmatrix}
   t_1 & 1 \\
   t_2 & 1 \\
   \vdots & \vdots \\
   t_N & 1
   \end{bmatrix}
   \begin{bmatrix} a \\ b \end{bmatrix}
   $$
   **Model 2 (3 parameters):**
   $$
   \begin{bmatrix} y(t_1) \\ y(t_2) \\ \vdots \\ y(t_N) \end{bmatrix}
   =
   \begin{bmatrix}
   t_1^2 & t_1 & 1 \\
   t_2^2 & t_2 & 1 \\
   \vdots & \vdots & \vdots \\
   t_N^2 & t_N & 1
   \end{bmatrix}
   \begin{bmatrix} a \\ b \\ c \end{bmatrix}
   $$
   **Model 3 (11 parameters):**
   $$
   \begin{bmatrix} y(t_1) \\ y(t_2) \\ \vdots \\ y(t_N) \end{bmatrix}
   =
   \begin{bmatrix}
   t_1^{10} & t_1^{9} & \dots & t_1 & 1 \\
   t_2^{10} & t_2^{9} & \dots & t_2 & 1 \\
   \vdots & \vdots & \ddots & \vdots & \vdots \\
   t_N^{10} & t_N^{9} & \dots & t_N & 1
   \end{bmatrix}
   \begin{bmatrix} a_0 \\ a_1 \\ \vdots \\ a_{10} \end{bmatrix}
   $$
   In each case, the matrix $\Phi$ has size $N \times p$, where $N$ is the number of data points and $p$ is the number of parameters. The vector $Y$ has size $N \times 1$, and $\theta$ has size $p \times 1$.

3. **Estimate the parameters (Least Squares):**
   $$
   \hat{\theta} = \left(\Phi^{\top} \Phi\right)^{-1} \Phi^{\top} Y
   $$
   This formula finds the "best fit" coefficients that make the polynomial as close as possible to $\sin(t)$.

4. **Compute the predicted output:**
   $$
   \hat{Y} = \Phi \hat{\theta}
   $$
   Plug the estimated coefficients back in to get predicted values.


5. **Measure the error (Loss function):**
   $$
   J = \left(Y - \hat{Y}\right)^{\top} \left(Y - \hat{Y}\right)
   $$
   This is the sum of squared differences between true values and predictions. Small $J$ means a good fit; large $J$ means a bad fit.

6. **Repeat with noise:** Real data is never perfect, so we also try:
   $$
   y = \sin(t) + \nu
   $$
   where $\nu$ is random noise. The noise is drawn from a uniform distribution on the interval $[-0.25, 0.25]$, so each measurement is randomly shifted up or down by a small amount. Then repeat all steps with the noised output and observe:
   - How do the loss values $J_1$, $J_2$, $J_3$ change compared to the clean case?
   - Which model gives the most stable results?
   - Does the high-order polynomial (Model 3) overfit the noise?

---
## Summary Table
| Model | Polynomial | # of Parameters | Vector Form |
|-------|-----------|-----------------|-------------|
| 1 | $at + b$ | 2 | $[t \;\; 1]\,[a \;\; b]^\top$ |
| 2 | $at^2 + bt + c$ | 3 | $[t^2 \;\; t \;\; 1]\,[a \;\; b \;\; c]^\top$ |
| 3 | $\sum_{k=0}^{10} a_k t^k$ | 11 | $[t^{10} \;\dots\; t \;\; 1]\,[a_0 \;\dots\; a_{10}]^\top$ |

**Goal:** Find which model best approximates $\sin(t)$, both with and without noise.
