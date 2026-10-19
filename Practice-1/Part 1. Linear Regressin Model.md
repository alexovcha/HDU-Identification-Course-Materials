---
Teacher: Alexey Ovcharov
tags:
  - LRM
  - Approximation
date: 2026-10-09
---
> Linear regression [Lecture_2_Approximation, page 11](../Materials/Lectures/Lecture_2_Approximation.pdf#page=11)

## Linear Regression Model

Let's consider the canonical **Linear Regression Model** (LRM):

$$
y = \varphi_{1} \theta_{1} + \varphi_{2} \theta_{2} + \dots + \varphi_{n} \theta_{n}
$$

We can rewrite this equation in matrix form:

$$
y = \begin{bmatrix}
\varphi_{1} & \varphi_{2} & \dots & \varphi_{n}
\end{bmatrix}
\begin{bmatrix}
\theta_{1} \\
\theta_{2} \\
\vdots \\
\theta_{n}
\end{bmatrix}
= \boldsymbol{\varphi}^\top \boldsymbol{\theta}
$$

where:
- $y$ is the **output** (a known scalar),
- $\varphi_{1}, \varphi_{2}, \dots, \varphi_{n}$ are the **regressors** (known values, also called features or basis functions),
- $\theta_{1}, \theta_{2}, \dots, \theta_{n}$ are the **unknown parameters** we want to estimate.

> **Key idea:** The LRM is *linear in the parameters* $\theta_i$, but the regressors $\varphi_i$ can be arbitrary (possibly nonlinear) functions of the measured variables. This is what makes the model so powerful.

---

## How to Build a Linear Regression Model

Given a physical equation, follow these three steps:

1. **Choose the output $y$.** Move all terms that do **not** contain unknown parameters to the left side of the equation. This left side becomes $y$.
2. **Separate** each term on the right side into a product of a *known* factor $\varphi_i$ and an *unknown* factor $\theta_i$.
3. **Write** the LRM in vector/matrix form.

---

## Example 1: RL Circuit (Ohm's Law)

> Consider an electrical circuit with Resistance and Inductance. We can write Ohm's Law [Lecture_1_Identification, page 25](../Materials/Lectures/Lecture_1_Identification.pdf#page=25)

$$
U = RI + L\dot{I}
$$

where $R$ and $L$ are **unknown** parameters, and $U$, $I$, $\dot{I}$ are measured variables.

**Step 1 — Find the output $y$.**  
All three terms are $U$, $RI$, $L\dot{I}$. Only $U$ is free of unknown parameters, so we keep it on the left:

$$
y = U
$$

**Step 2 — Separate known and unknown parts.**  
The right side has two terms, $RI$ and $L\dot{I}$. In each term, the *variable* part is known and the *coefficient* is unknown:

$$
RI + L\dot{I} = \underbrace{I}_{\varphi_1}\underbrace{R}_{\theta_1} + \underbrace{\dot{I}}_{\varphi_2}\underbrace{L}_{\theta_2} = \varphi_1 \theta_1 + \varphi_2 \theta_2
$$

**Step 3 — Write the LRM.**

$$
\begin{align}
y &= \varphi_{1} \theta_{1} + \varphi_{2}\theta_{2} \\
y &= \begin{bmatrix} \varphi_{1} & \varphi_{2} \end{bmatrix}
\begin{bmatrix} \theta_{1} \\ \theta_{2} \end{bmatrix}
\end{align}
$$

with $\varphi_1 = I$, $\varphi_2 = \dot{I}$, $\theta_1 = R$, $\theta_2 = L$.

---

## Example 2: Mass–Spring–Damper System

> Consider a mechanical system with mass $m$, damping coefficient $b$, and spring stiffness $k$, driven by an external force $F$. Newton's second law gives:

$$
F = m\ddot{x} + b\dot{x} + kx
$$

where $m$, $b$, $k$ are **unknown** parameters and $x$ is the measured position.

**Step 1 — Find the output $y$.**  
The only term without unknown parameters is $F$:

$$
y = F
$$

**Step 2 — Separate known and unknown parts.**  
There are three terms on the right, so we get three regressors:

$$
m\ddot{x} + b\dot{x} + kx = \underbrace{\ddot{x}}_{\varphi_1}\underbrace{m}_{\theta_1} + \underbrace{\dot{x}}_{\varphi_2}\underbrace{b}_{\theta_2} + \underbrace{x}_{\varphi_3}\underbrace{k}_{\theta_3}
$$

**Step 3 — Write the LRM.**

$$
y = \begin{bmatrix} \ddot{x} & \dot{x} & x \end{bmatrix}
\begin{bmatrix} m \\ b \\ k \end{bmatrix}
= \boldsymbol{\varphi}^\top \boldsymbol{\theta}
$$

---

## Example 3: Static Nonlinear Function (Linear in Parameters)

> Suppose a measured quantity $z$ depends on a variable $u$ through
>
> $$
> z = a + b\,u + c\,u^2
> $$
>
> where $a$, $b$, $c$ are **unknown** parameters.

Even though $z$ is a *nonlinear* function of $u$, the model is still **linear in the parameters** $a, b, c$.

**Step 1 — Find the output $y$.**  
The whole expression is on the right, so:

$$
y = z
$$

**Step 2 — Separate known and unknown parts.**  
The regressors are the *known functions of $u$*:

$$
a + b\,u + c\,u^2 = \underbrace{1}_{\varphi_1}\underbrace{a}_{\theta_1} + \underbrace{u}_{\varphi_2}\underbrace{b}_{\theta_2} + \underbrace{u^2}_{\varphi_3}\underbrace{c}_{\theta_3}
$$

**Step 3 — Write the LRM.**

$$
y = \begin{bmatrix} 1 & u & u^2 \end{bmatrix}
\begin{bmatrix} a \\ b \\ c \end{bmatrix}
$$

> **Takeaway:** Nonlinearity in the *inputs* is fine. The LRM framework only requires linearity in the *parameters*.

## In-Class Self Tasks: Building a Linear Regression Model

**Instructions:** For each task, follow the 3 steps:
1. Find the output $y$.
2. Separate known ($\varphi_i$) and unknown ($\theta_i$) parts.
3. Write the LRM in matrix form.

### Task 1. Falling Body with Air Drag

A body falls under gravity $g$ with air drag proportional to velocity: $F_d = bv$. The equation of motion is:

$$
mg - bv = m\dot{v}
$$

where $m$ and $b$ are **unknown** parameters, and $g$, $v$, $\dot{v}$ are measured.

#### 1. Divide by $m$

$$
g - \frac{b}{m} v = \dot{v}
$$

#### 2. Find output $y$

$$
y = g - \dot{v}
$$

#### 3. Equation

$$
g - \dot{v} = \frac{b}{m} v
$$


### Task 2. RC Circuit

A capacitor $C$ and resistor $R$ are in series. The measured voltage across the resistor is $U_R = RI$, and the voltage across the capacitor is $U_C$. The total applied voltage is:

$$
U = RI + \frac{1}{C}\int I \, dt
$$

where $R$ and $C$ are **unknown** parameters, and $U$, $I$, $\int I \, dt$ are measured.

### Task 3: Polynomial Fit

A sensor output $z$ depends on temperature $T$ as:

$$
z = a_0 + a_1 T + a_2 T^2 + a_3 T^3
$$

where $a_0, a_1, a_2, a_3$ are **unknown** calibration coefficients, and $z$, $T$ are measured.

## Summary

| Step | Action                                                     | Result                                              |
| ---- | ---------------------------------------------------------- | --------------------------------------------------- |
| 1    | Move known terms to the left                               | Output $y$                                          |
| 2    | Split each right-side term into $\varphi_i \cdot \theta_i$ | Regressors $\varphi_i$, parameters $\theta_i$       |
| 3    | Assemble into matrix form                                  | $y = \boldsymbol{\varphi}^\top \boldsymbol{\theta}$ |

Once the model is in this form, any standard linear estimation method (e.g., least squares) can be applied to find $\boldsymbol{\theta}$.
