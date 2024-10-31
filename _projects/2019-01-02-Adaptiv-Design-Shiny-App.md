---
title: "Adaptiv Design Shiny App"
collection: projects
permalink: /projects/2019-01-02-Adaptiv-Design-Shiny-App
excerpt: "The application is used to determine the required sample size of a clinical study."
data: 2019-01-02
image:
  teaser: /projets/ar.jpg
---

# Adaptiv Design Shiny App


<div align="center">
<img src="/images/projets/ar.jpg" style="height:150px; width:300px;" />
</div><br />

[Website](https://armelsoubeiga.shinyapps.io/AdapticvDesign/) \ [Get Started](https://github.com/armelsoubeiga/AdaptivDesign) \ [Docs]()

------

# Power and Sample Size for Two-Sample Proportions Test
The goal of this analysis is to determine the sample size required or evaluate the power for a test intended to determine if there is an association between the probability of an outcome of interest and the level of the exposure factor. The computations are based on the Pearson-s chi-squared test for two independent binomial populations and are performed for a two-sided hypothesis test.


# Parameters used in the computations

These parameters are all inter-related such that if you know some you can estimate the others so need not provide all to get power/sample size.

Risk-ratio : corresponds to the smallest reduction in the risk (effect size) that one would like to be able to detect, e.g. effect size of 20% => RR of 80% . alpha : Confidence level desired . Level of power desired . n1 and/or n2 : sample sizes in the un-exposed and exposed groups respectivelly, corresponding to prevalence of the exposure . p1 and/or p2 : proportion developing the outcome in the unexposed group and exposed group respectively (usually estimated from previous research . nratio : ratio of un-exposed subjects to exposed subjects (n2/n1) .
