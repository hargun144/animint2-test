# Animint2 GSoC 2026 Tests - Hargun Kaur

## Easy Test
Interactive Gapminder visualization — GDP vs Life Expectancy bubble chart animated by year, with linked time series. Click a country to track its history.
* Live viz: https://hargun144.github.io/animint2-easy
* Source code: viz.R

## Medium Test 1 — Simple Random Sampling
Ported from `sample.simple()` in the animation package. A population grid animates through random samples each iteration, with a linked plot showing how the sample mean converges to the true population mean.
* Live viz: https://hargun144.github.io/animint2-medium
* Source code: medium_test.R

## Medium Test 2 — Stratified Random Sampling
Ported from `sample.strat()` in the animation package. Shows stratified sampling across multiple strata, with a linked bar chart showing sampled vs population count per stratum.
* Live viz: https://hargun144.github.io/animint2-medium2
* Source code: medium_test2.R

## Medium Test 3 — Cluster Sampling
Ported from `sample.cluster()` in the animation package. Displays a population divided into clusters, animating through random cluster selections each iteration, with selected clusters and points highlighted.
* Live viz: https://hargun144.github.io/animint2-cluster
* Source code: cluster.R

## Medium-Hard Test — Animint2 Gallery
Created a gallery that organizes multiple Animint visualizations inspired by the Ports of animation examples, providing a structured view of different interactive visualizations.
* Live viz: https://hargun144.github.io/animint2-gallery/

## Hard Test — Renderer Unit Test
Implemented a testthat-based renderer test for the Simple Random Sampling visualization. The test renders the visualization in a remote-controlled browser and verifies correctness by parsing SVG elements.

Two test cases are implemented:
* Minimum rendering check: ensures at least 100 circle elements are present.
* Exact count validation: verifies the exact number of circle elements (102), including additional elements such as legends.
* Demo video: https://vimeo.com/1178247289/53f9231ac6
  
