# SpatialGrid

Some work on a grid based approach to exogenous specification of spatial weighting matrices. In this example we estimate a simple set of models across a grid comprised of nearest neighbor and alpha variation. This can be seen as a development of Section 3.3 of LeSage and Pace (2014) and Kostov (2010), both based on the Pace and Gilley (1997) amendments which augmented the infamous Harrison and Rubinfeld (1978) data with spatial co-ordinates. We follow the ten-variable specification of LeSage and Pace (2014), and transform the variables accordingly. We then follow their weighting scheme:

\begin{equation}
W_{i,j} =\frac{1}{d(i,j)_m^{\alpha}}
\end{equation}

here d(i,j)m denotes the distance between the m nearest neighboring observations between j and i and α is the decay parameter. We vary the grid between 1-20 nearest neighbors and across 20 alpha intervals between 0.4-4 to show that despite a strong posterior preference for a small number of models, a high variance in the log-likelihoods and the λ parameter, the direct effects (of, for example: Crime) stay relatively constant between -0.0119 and -0.0079. 
