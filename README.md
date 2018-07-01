# Multilevel Bayesian Correlation

This repository contains a jupyter notebook which describes building a multilevel Bayesian correlation in Python using [Stan](http://mc-stan.org/).

Correlations are used to determine how much of a relationship exists between two variables.  Simple versions of a correlation are fine when we have independent samples, but what if we have multiple datapoints per individual or group?  We can't just combine all the data from all individuals/groups, because we have to account for the possibility that there are between-group differences!  A multilevel Bayesian correlation is a modeling technique which allows us to estimate the correlation across all groups, and for each group individually, while accounting for these between-group differences.

We'll start out by seeing exactly how a "basic correlation" works (i.e., a Pearson correlation), and building a Bayesian version of the Pearson correlation.  Then we'll see how we can end up getting the wrong answer when we try to apply this "basic" correlation to data with multiple datapoints per group or individual!  So, we'll tweak our Bayesian correlation to account for differences between subjects and groups, and we'll also tweak it to handle outliers.  Finally, we'll use our model to determine if there's a correlation between school expenditures and student performance at schools across Massachusetts.

## Outline
* Pearson Correlation
* Multilevel Correlation
* Robust Correlation
* Correlating School Expenditures with Student Performance
* Simplifications
