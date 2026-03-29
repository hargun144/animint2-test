## Animint2 GSoC 2026 Tests - Hargun Kaur

### Easy Test
Interactive Gapminder visualization — GDP vs Life Expectancy bubble chart 
animated by year, with linked time series. Click a country to track its history.

- Live viz: https://hargun144.github.io/animint2-easy
- Source code: viz.R

### Medium Test 1 — Simple Random Sampling
Ported from `sample.simple()` in the animation package. A population grid 
animates through random samples each iteration, with a linked plot showing 
how the sample mean converges to the true population mean.

- Live viz: https://hargun144.github.io/animint2-medium
- Source code: medium_test.R

### Medium Test 2 — Stratified Random Sampling
Ported from `sample.strat()` in the animation package. Shows stratified 
sampling across multiple strata, with a linked bar chart showing sampled 
vs population count per stratum.

- Live viz: https://hargun144.github.io/animint2-medium2
- Source code: medium_test2.R
