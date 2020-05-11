{
    name: 'Bodendiek',
    num_matrices: '5',
    notes: 'Curl-Curl operator of 2nd order Maxwell\'s equations, A. Bodendiek

From Andre\' Bodendiek, Institut Computational Mathematics,
TU Braunschweig

The following matrix collection consists of the curl-curl-operator
of a second-order Maxwell\'s equations with PEC boundary conditions,
i.e. E x n = 0, where E and n denote the electric field strength
and the unit outer normal of the computational domain. The
curl-curl-operator has been discretized using the Finite Element
Method with first-order Nedelec elements resulting in the weak
formulation

   1/mu0 ( curl E, curl v ),

where v resembles a test function of H(curl) and
mu0 = 1.25 1e-9 H / mm denotes the magnetic permeability of vacuum,
see [Hipt02]. 

In general, the underlying model problem of Maxwell\'s equations
results from a Coplanar Waveguide, which will be considered for
the analysis of parasitic effects in the development of new
semiconductors. Since the corresponding dynamical systems are often
high-dimensional, model order reduction techniques have become an
appealing approach for the efficient simulation and accurate analysis
of the parasitic effects. However, different kinds of model order
techniques require the repeated solution of high-dimensional linear
systems of the original model problem, see [Bai02,An09]. Therefore,
the development of efficient solvers resembles an important task
in model order reduction.

Each matrix CurlCurl_<nr> consists of a different number of degrees
of freedom, given in the following table:

<nr> = 0:   11083
<nr> = 1:  226451
<nr> = 2:  806529
<nr> = 3: 1219574
<nr> = 4: 2380515

References.

@ARTICLE{Bai02,
  author = {Z. Bai},
  title = {Krylov subspace techniques for reduced-order modeling
    of large-scale dynamical systems},
  journal = {Applied Numerical Mathematics},
  year = {2002},
  volume = {43},
  pages = {9--44},
  number = {1--2}
}

@ARTICLE{Hipt02,
  author = {R. Hiptmair},
  title = {Finite elements in computational electromagnetism},
  journal = {Acta Numerica, Cambridge University Press},
  year = {2002},
  pages = {237-339}
}

@BOOK{An09,
  title = {Approximation of {L}arge-{S}cale {D}ynamical {S}ystems},
  publisher = {Society for Industrial Mathematics},
  year = {2009},
  author = {Athanasios C. Antoulas}
}

',

}

