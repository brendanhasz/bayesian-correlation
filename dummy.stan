// Pearson Correlation

data {
    int<lower=0> N;      //number of datapoints
    real X[N];      //datapoints
}

parameters {
    real mu;               //mean
    real<lower=0> sig;
}

model {

    X ~ normal(mu, sig);

}
