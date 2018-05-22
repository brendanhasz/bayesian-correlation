// Pearson Correlation w/ random effect of subject

data {
    int<lower=0> Ns;     //number of subjects
    int<lower=0> N;      //number of datapoints
    int<lower=0> sid[N]; //subject ID
    vector[2] X[N];      //datapoints
}

parameters {
    vector[2] mu;                     //population mean
    vector<lower=0>[2] sig;           //population std dev
    real<lower=0> cov;                //population effect covariance
    vector[2] mu_s[Ns];               //per-subject mean
    vector<lower=0>[2] sig_s[Ns];     //per-subject std dev
    real<lower=-1,upper=1> rho;       //population rho
    real<lower=0> rho_sig;            //std dev of pop rho
    real<lower=-1,upper=1> rho_s[Ns]; //per-subject rho
}

transformed parameters {
    // Covariance matrix for each subject
    cov_matrix[2] T[Ns]; 
    for (iS in 1:Ns) { //compute for each subject
        T[iS][1,1] <- square(sig_s[iS][1]);
        T[iS][1,2] <- rho_s[iS] * sig_s[iS][1] * sig_s[iS][2];
        T[iS][2,1] <- rho_s[iS] * sig_s[iS][1] * sig_s[iS][2];
        T[iS][2,2] <- square(sig_s[iS][2]);
    }

    // Covariance matrix for population means
    cov_matrix[2] Tm;
    Tm[1,1] = square(sig[1]);
    Tm[1,2] = cov * sig[1] * sig[2];
    Tm[2,1] = cov * sig[1] * sig[2];
    Tm[2,2] = square(sig[2]);
}

model {

    // Multilevel / random effect for rho
    // population rhos drawn from beta distribution on [-1, 1]
    real a;
    real b;
    real m;
    real s;
    m = (rho+1)/2;
    s = rho_sig/2;
    a = -m*(s+m*m-m)/s;    //alpha of the beta distribution
    b = (s+m*m-m)*(m-1)/s; //beta of the beta distribution
    (rho_s+1)/2 ~ beta(a, b);

    // Multilevel / random effect for means
    mu_s ~ multi_normal(mu, Tm);

    // Correlation of data
    for (iD = 1:N) { //for each datapoint,
        X[iD] ~ multi_normal(mu_s[sid[iD]], T[sid[iD]])
        // or use T distribution for robust correlation?
        // either have nu be a parameter, or just set to 1?
        // X[iD] ~ multi_student_t(nu, mu_s[sid[iD]], T[sid[iD]]);
    }

}




