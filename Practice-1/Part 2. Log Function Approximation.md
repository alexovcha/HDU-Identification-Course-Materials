---
Teacher: Alexey Ovcharov
tags:
  - LRM
  - Approximation
date: 2026-10-09
---
> We want to approximate $y = \log(t)$ using polynomials. A polynomial is a sum of terms like $a + bt + ct^2 + \dots$ where the coefficients ($a$, $b$, $c$, ...) are **unknown** and must be found.

We will try three polynomial models, from simple to complex:

**Model 1 — Straight Line (2 parameters):**
$$y = at + b = \begin{bmatrix} t & 1 \end{bmatrix} \begin{bmatrix} a \\ b \end{bmatrix}$$

**Model 2 — Parabola (3 parameters):**
$$y = at^2 + bt + c = \begin{bmatrix} t^2 & t & 1 \end{bmatrix} \begin{bmatrix} a \\ b \\ c \end{bmatrix}$$

**Model 3 — High-Order Polynomial (11 parameters):**
$$y = a_0 + a_1 t + a_2 t^2 + \dots + a_{10} t^{10} = \begin{bmatrix} t^{10} & t^{9} & \dots & t & 1 \end{bmatrix} \begin{bmatrix} a_0 \\ a_1 \\ \vdots \\ a_{10} \end{bmatrix}$$

In each case, the model has the form $y = \boldsymbol{\varphi}^{\top} \boldsymbol{\theta}$, where $\boldsymbol{\varphi}$ contains known values and $\boldsymbol{\theta}$ contains unknown coefficients. More parameters means a more flexible curve, but also more risk of overfitting.

---

## Task

We have data points at $t = 1, 2, 3, \dots, 21$, with true value $y = \log(t)$.

1. **Write the model in vector form:**
   $$y = \boldsymbol{\varphi}^{\top} \boldsymbol{\theta}$$
   This means "output = (known stuff) × (unknown coefficients)".

3. **Build the extended regression:** Stack all 21 equations into one big matrix equation:
   $$Y = \Phi \theta$$
   where $Y$ is the column vector of all 21 outputs, $\Phi$ is the matrix where each row is $\boldsymbol{\varphi}^{\top}$ for one $t$, and $\theta$ is the column vector of unknown coefficients.

4. **Estimate the parameters (Least Squares):**
   $$\hat{\theta} = \left(\Phi^{\top} \Phi\right)^{-1} \Phi^{\top} Y$$
   This formula finds the "best fit" coefficients that make the polynomial as close as possible to $\log(t)$.

5. **Compute the predicted output:**
   $$\hat{Y} = \Phi \hat{\theta}$$
   Plug the estimated coefficients back in to get predicted values.

6. **Measure the error (Loss function):**
   $$J = \left(Y - \hat{Y}\right)^{\top} \left(Y - \hat{Y}\right)$$
   This is the sum of squared differences between true values and predictions. Small $J$ means a good fit; large $J$ means a bad fit.

7. **Repeat with noise:** Real data is never perfect, so we also try:
   $$y = \log(t) + \nu$$
   where $\nu$ is random noise. The question: how do the three models behave when data is noisy? Does the simple model still work? Does the complex model overfit the noise?

---

## Summary

| Model | Polynomial | # of Parameters | Vector Form |
|-------|-----------|-----------------|-------------|
| 1 | $at + b$ | 2 | $[t \;\; 1]\,[a \;\; b]^\top$ |
| 2 | $at^2 + bt + c$ | 3 | $[t^2 \;\; t \;\; 1]\,[a \;\; b \;\; c]^\top$ |
| 3 | $\sum_{k=0}^{10} a_k t^k$ | 11 | $[t^{10} \;\dots\; t \;\; 1]\,[a_0 \;\dots\; a_{10}]^\top$ |

**Goal:** Find which model best approximates $\log(t)$, both with and without noise.