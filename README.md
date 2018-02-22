# SpatialGrid

This repo provides a very simple example of a grid based approach to exogenous specification of spatial weighting matrices (and represents the supplementary material from [this paper](https://www.dropbox.com/s/a4hcuamrnzzj87y/Spatial_Article.pdf?dl=0). In this example we estimate a simple set of models across a grid comprised of nearest neighbor and alpha variation. This can be seen as a development of Section 3.3 of [LeSage and Pace (2014)](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=1725503) and [Kostov (2010)](http://clok.uclan.ac.uk/11551/1/postprint.EPB.2010.pdf), both based on the [Pace and Gilley (1997)](https://link.springer.com/article/10.1023/A:1007762613901) amendments which augmented the infamous Harrison and Rubinfeld (1978) data with spatial co-ordinates. We follow the ten-variable specification of [LeSage and Pace (2014)](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=1725503), and transform the variables accordingly. We then follow their weighting scheme: W_{i,j} =1/(d(i,j)_m^α) where d(i,j)m denotes the distance between the m nearest neighboring observations between j and i and α is the decay parameter. We vary the grid between 1-20 nearest neighbors and across 20 alpha intervals between 0.4-4 to show that despite a strong posterior preference for a small number of models, a high variance in the log-likelihoods and the λ parameter, the direct effects (of, for example: Crime) stay relatively constant between -0.0119 and -0.0079. 

The Boston dataset augmented by Pace and Gilley (1997) can be found [here](https://artax.karlin.mff.cuni.cz/r-help/library/spdep/html/boston.html). 

Some support functions come from the MATLAB toolbox of [James LeSage](http://www.spatial-econometrics.com/).


### Figures 

<img src="https://github.com/crahal/SpatialGrid/blob/master/Figure_DEcrime.png" width="425"/> <img src="https://github.com/crahal/SpatialGrid/blob/master/Figure_bar3modelprobs.png" width="425"/> 

<img src="https://github.com/crahal/SpatialGrid/blob/master/Figure_histloglik.png" width="425"/> <img src="https://github.com/crahal/SpatialGrid/blob/master/Figure_lambda.png" width="425"/> 

### References

Harrison, D. and Rubinfeld, D.L. (1978) Hedonic housing prices and the demand for clean air. Journal
of Environmental Economics and Management, 5 (1): 81–102. 

Kostov, P. (2010) Model boosting for spatial weighting matrix selection in spatial lag models.
Environment and Planning B: Planning and Design, 37 (3): 533–549. 

LeSage, J. and Pace, R.K. (2014) The biggest myth in spatial econometrics. Econometrics, 2 (4): 1–33.

Pace, R.K. and Gilley, O. (1997) Using the spatial configuration of the data to improve estimation. The
Journal of Real Estate Finance and Economics, 14 (3): 333–340.
