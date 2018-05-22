// Pearson Correlation

data {
    int<lower=0> N;      //number of datapoints
    vector[2] X[N];      //datapoints
}

parameters {
    vector[2] mu;               //mean
    vector<lower=0>[2] sig;     //std dev of each variable
    real<lower=-1,upper=1> rho; //Pearson's rho
}

transformed parameters {
    cov_matrix[2] T; //covariance matrix
    T[1,1] <- sig[1] * sig[1];
    T[1,2] <- rho * sig[1] * sig[2];
    T[2,1] <- rho * sig[1] * sig[2];
    T[2,2] <- sig[2] * sig[2];
    }
}

model {

    X ~ multi_normal(mu, T);

    // or use T distribution for robust correlation:
    // X ~ multi_student_t(1, mu, T);

}
