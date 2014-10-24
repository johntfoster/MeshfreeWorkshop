# Motivation

## Material Failure

### Material Failure
  
\begin{columns}[T] 

    \column{0.55\textwidth}
     
    \vspace{-0.5cm}
    \begin{figure}
        \centering
        \includegraphics[width=0.55\textwidth]{southwest.jpg}
        \caption{Fuselage Rupture. Image c/o AP.}
    \end{figure}
	 
    \vspace{-0.5cm}
    \begin{figure}
        \centering
        \includegraphics[width=0.55\textwidth]{FEM_car_crash1.jpg}
        \caption{Car crash}
    \end{figure}

    \column{0.45\textwidth}
       
    \begin{figure}
        \centering
        \includegraphics[width=0.7\textwidth]{plateperf2.jpg}
        \caption{Plate perforation}
   \end{figure}
   \end{columns}
     
\footcite{borvik1999ballistic}
  
\note{}

# Background

## Peridynamics

### Peridynamics

\begin{center}
    \justify
    ``\ldots seeks to unify the mechanics of continuous media, particles, and cracks with a single mathematically consistent set of equations.''
\end{center}

\begin{figure}
    \centering
    \includegraphics[width=0.7\textwidth]{crack_branch.jpg}
    \caption{Quote \& image c/o S.~Silling, SNL}
\end{figure}

\note{}
  
### Peridynamic EOM

$$
    \rho(\mathbf{x})\mathbf{\ddot{u}}(\mathbf{x},t) = \int_\mathcal{H} \left\{\vstate{T}{\mathbf{x},t}{\mathbf{x'}-\mathbf{x}}-\vstate{T}{\mathbf{x'},t}{\mathbf{x}-\mathbf{x'}}\right\} \; dV_{\mathbf{x'}} + \mathbf{b}(\mathbf{x},t),
$$

\begin{figure}
    \centering
    \scalebox{0.6}{\input{./diagrams/peri_body.tex}}
\end{figure}

\footcite{silling:psa}

\note{}

### Constitutive Model Types

\begin{figure}
    \centering
    \includegraphics[width=0.8\textwidth]{PDmodelTypes}
\end{figure}

\footcite{silling:psa}

\note{}

## Thin Features

### Thin Features
  
\vfill

\begin{columns}[b] 
       
    \column{0.5\textwidth}

    \begin{figure}
        \centering
        \includegraphics[width=0.75\textwidth]{ansysShell}
        \caption{FEA shells. Image c/o ANSYS manual.}
    \end{figure}
       
    \column{0.5\textwidth}

    \vspace{-0.8cm}
    \begin{figure}
        \centering
        \includegraphics[width=0.6\textwidth]{littlewood_cylinder2.jpg}
        \caption{No PD equivalent}
    \end{figure}
     
\end{columns}
     
\footcite{littlewood2010}

\note{}


# Objectives

## Objectives

### Objectives

 * PD constitutive models for beam, plates, shells
 * Simulate material failure in thin features
 * Explore complexities of non-ordinary material models, meta-materials\ldots?

\note{}

# Results

## Bond-pair Models

### Bond Pair Model

\begin{figure}
    \subinputfrom{\diagrampath}{bondPair.eps_tex}
\end{figure}

in which

$$
    \vstate{T}{}{\boldsymbol{\xi}} =\frac{\alpha}{|\vstate{Y}{}{\boldsymbol{\xi}}|} \frac{\vstate{Y}{}{\boldsymbol{\xi}}}{|\vstate{Y}{}{\boldsymbol{\xi}}|} \times \left[\frac{\vstate{Y}{}{\boldsymbol{\xi}}}{|\vstate{Y}{}{\boldsymbol{\xi}}|} \times \frac{\vstate{Y}{}{-\boldsymbol{\xi}}}{|\vstate{Y}{}{-\boldsymbol{\xi}}|}\right]
$$

\footcite{silling:psa}
\footcite{jogrady2014a}

\note{}

### Bond Pair Beam Energy

\vfill

$$
W(x) \approx \int_{-\delta}^\delta \omega(\xi)\alpha\frac{\xi^2}{2}\kappa^2 d\xi = \frac{\alpha}{2}\kappa^2 \int_{-\delta}^\delta \omega(\xi)\xi^2 d\xi,
$$

\vspace{0.5cm}
\begin{center}
    Choosing \(\alpha\) carefully:
\end{center}

\begin{align*}
    \alpha = \frac{EI}{m} ;\; m=\int_{-\delta}^\delta \omega(\xi)\xi^2 d\xi \implies W=\frac{EI}{2}\kappa^2
\end{align*}


\footcite{jogrady2014a}

\note{}


### Discretization

\begin{columns}[T]

    \column{0.33\textwidth}

    \begin{figure}
        \begin{center}
        \resizebox{\linewidth}{!}{\input{./diagrams/PotatoContinuous2.tex}}
        \end{center}
        \caption{Peridynamic Continuum}
    \end{figure}
    
    \column{0.33\textwidth}

    \begin{figure}
        \centering
        \resizebox{0.9\linewidth}{!}{\subinputfrom{\diagrampath}{PotatoMeshed2.eps_tex}}
        \vspace{3mm}
        \caption{Set Massive, Volumeless Nodes at Mesh Centroids}
    \end{figure}

    \column{0.33\textwidth}

    \begin{figure}
        \begin{center}
        \resizebox{\linewidth}{!}{\input{./diagrams/PotatoDiscrete2.tex}}
        \end{center}
        \caption{Discard Mesh, Find Discrete Familes and Bond Pairs}
    \end{figure}
    
\end{columns}


\note{}


### Regular Discretization

$$
\alpha = \frac{c\; \Delta x}{m} ;\; c= EI ;\; m=\sum_{i=1}^n \omega(\boldsymbol{\xi}_i)\boldsymbol{\xi}_i^2; \nonumber \\
$$

\vspace{-10mm}

\begin{align*}
\rho(\mathbf{x})\mathbf{\ddot{u}}(\mathbf{x}) = \mathbf{f}(\mathbf{x})&+\sum_i \omega(\boldsymbol{\xi}_i)\left\{\frac{\alpha(\mathbf{x})}{|\mathbf{p}_i |}\frac{\mathbf{p}_i}{|\mathbf{p}_i |}\times \left[ \frac{\mathbf{p}_i}{|\mathbf{p}_i |}\times \frac{\mathbf{q}_i}{|\mathbf{q}_i |}\right] \right. \notag \\
& \left. -\frac{\alpha(\mathbf{x}+\boldsymbol{\xi}_i)}{|\mathbf{p}_i |}\frac{(-\mathbf{p}_i)}{|\mathbf{p}_i |}\times\left[\frac{(-\mathbf{p}_i)}{|\mathbf{p}_i |}\times \frac{\mathbf{r}_i}{|\mathbf{r}_i |} \right] \right\} \,.
\end{align*}

\begin{center}
    with
\end{center}
\begin{align*}
\mathbf{p}_i &= \boldsymbol{\xi}_i+\mathbf{u}(\mathbf{x}+\boldsymbol{\xi}_i)-\mathbf{u}(\mathbf{x})\, ,\notag\\
\mathbf{q}_i &= -\boldsymbol{\xi}_i+\mathbf{u}(\mathbf{x}-\boldsymbol{\xi}_i)-\mathbf{u}(\mathbf{x})\, ,\notag\\
\mathbf{r}_i &= \boldsymbol{\xi}_i+\mathbf{u}(\mathbf{x}+2\boldsymbol{\xi}_i)-\mathbf{u}(\mathbf{x}+\boldsymbol{\xi}_i)\, ,\notag
\end{align*}


\footcite{jogrady2014a}

\note{}


### Plasticity and Damage

  
\begin{center}
    Brittle material
\end{center}
  
$$
|\vstate{T}{}{\xi}| = 
  \begin{cases}
    \vstate{T}{}{\xi} & \quad \text{if} \quad \theta < \theta_c \\
    0 & \quad \text{if} \quad \theta \geq \theta_c\
  \end{cases}
$$

\begin{center}
    Elastic perfectly-plastic material
\end{center}

$$
|\vstate{T}{}{\xi}| = 
  \begin{cases}
    \alpha \frac{\sin(\theta^e(\vstate{Y}{}{\xi},\vstate{Y}{}{\mathbf{-\xi}}))}{|\vstate{Y}{}{\xi}|} & \quad \text{if} \quad \theta^e < \theta_c\\
    \alpha \frac{\sin(\theta_c)}{|\vstate{Y}{}{\xi}|} & \quad \text{if} \quad \theta^e \geq \theta_c\
  \end{cases}
$$

\footcite{jogrady2014a}

\note{}

### Beam Results
\vspace{-5mm}
\begin{columns}[T] % contents are top vertically aligned

    \column{0.5\textwidth}

    \begin{figure}
        \centering
        \resizebox{\linewidth}{!}{\input{\plotpath/elastic_h20_g2000.pgf}}
        \caption{Elastic}
    \end{figure}

    \column{0.5\textwidth}

    \begin{figure}
        \centering
        \resizebox{\linewidth}{!}{\input{\plotpath/eppu_h10_g2000.pgf}}
        \caption{Elastic-Plastic}
    \end{figure}

\end{columns}
\footcite{jogrady2014a}

\note{}


### Beam Failure

\begin{figure}
    \centering
    \scalebox{0.4}{\input{\plotpath/brittle_h10_n200.pgf}}
\end{figure}

\footcite{jogrady2014a}

\note{}

### Bond Pair Plate

\begin{center}
    Extend beam model to 2D
\end{center}

\begin{columns}[T] % contents are top vertically aligned

    \column{0.5\textwidth}
    
    \vspace{-1.5cm}

    \begin{figure}
        \centering
        \resizebox{0.9\linewidth}{!}{\subinputfrom{\diagrampath}{continuousPlate.eps_tex}}
    \end{figure}

    \column{0.5\textwidth}

    \vfill
    \begin{itemize}
        \item Choosing \(\alpha\) by matching strain energy with \(\nu = \sfrac{1}{3}\)
    \end{itemize}
     
\end{columns}

\begin{align*}
    \alpha &= \frac{c}{m} ;\; c= \frac{G t^3}{6 \pi} ;\; m=\int_{0}^\delta \omega(r)\frac{r^3}{2} dr ;\; \nu=\frac{1}{3} \implies \notag\\
W&=\frac{G t^3}{12(1-\nu)}\left(\left(\kappa_1\right)^2 +\left(\kappa_2\right)^2 +2\nu\left(\kappa_1\kappa_2\right) +2(1-\nu)\left(\kappa_3\right)^2 \right) 
\end{align*}

\footcite{jogrady2014b}

\note{}


### In-Plane Deformation
  
\vfill

\begin{figure}
    \centering
    \resizebox{0.9\linewidth}{!}{\subinputfrom{\diagrampath}{bondPairCombinedV.tex}}
\end{figure}

\note{}

### Arbitrary Poisson's Ratio

  
\begin{figure}
    \resizebox{\linewidth}{!}{\input{\plotpath/BendingDecomp.pgf}}
\end{figure}
  
A bending ``pressure'' proportional to the isotropic curvature $\bar{\boldsymbol{\kappa}}$ allows simulation of arbitrary $\nu$
  
\begin{equation}
     \vstate{T'}{}{\boldsymbol{\xi}}=\frac{8G}{m}\frac{h^3}{12}\frac{3\nu-1}{1-\nu}\frac{\omega(\boldsymbol{\xi})}{\xi^2} \bar{\boldsymbol{\kappa}} \notag
\end{equation}

\footcite{jogrady2014b}

\note{}


<!-- 
### Irregular Discretization

\begin{columns}[B]
     
    \column{0.45\textwidth}

    \begin{figure}
        \begin{center}
        \vspace{-9mm}
        \resizebox{\linewidth}{!}{\input{\plotpath/irregularMesh50.pgf}}
        \caption{Irregular Discretization}
        \end{center}
    \end{figure}

    \column{0.45\textwidth}

    \begin{figure}
        \begin{center}
        \resizebox{.95\linewidth}{!}{\input{./diagrams/VirtualPoint_T.tex}}
        \end{center}
        \caption{Add Virtual Points}
    \end{figure}
    
\end{columns}

\footcite{jogrady2014b}

\note{}
 -->


### Plate Results
\vspace{-5mm}

\begin{columns}[T]
     
    \column{0.5\textwidth}

    \begin{figure}
        \centering
        \resizebox{\linewidth}{!}{\input{\plotpath/plateStiffening.pgf}}
        \caption{Tension-Stiffening}
    \end{figure}

    \column{0.5\textwidth}

    \begin{figure}
        \centering
        \resizebox{\linewidth}{!}{\input{\plotpath/elasticPlatePoissonEffect.pgf}}
        \caption{Arbitrary $\nu$}
    \end{figure}
    
\end{columns}

\footcite{jogrady2014b}

\note{}


### Crack propagation

\vspace{-0.42cm}
\begin{figure}
	\centering
	\scalebox{0.28}{\input{\plotpath/SingleTorsion.pgf}}
\end{figure}
     
\footcite{jogrady2014b}

\note{}


# Conclusions

## Summary

### Summary

 * Plate and beam non-ordinary state-based models that recover classical response.
 * Simple failure models demonstrated.

\note{}

## Ongoing Work

### In progress

 * Irregular discretizations
 * Curved shells
 * Complex failure models
 * Meta-materials???


## Acknowledgment

### Acknowledgment

\vfill

\begin{figure}
    \includegraphics[width=0.3\textwidth]{james.jpg}
    \caption{James O'Grady}
\end{figure}

## Questions

### {}

\vfill
\begin{center}
    Questions?
\end{center}

\note{}

