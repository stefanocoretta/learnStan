data {
  int<lower=0> N;        // Number of data points
  vector[N] x1;          // x coordinates of object 1
  vector[N] y1;          // y coordinates of object 1
  vector[N] x2;          // x coordinates of object 2
  vector[N] y2;          // y coordinates of object 2
}

parameters {
  real mu;
  real<lower=0> sigma;   // Standard deviation of the distance
}

model {
  // Priors
  mu ~ normal(0, 10);
  sigma ~ cauchy(0, 5);  // Cauchy prior on the standard deviation

  // Likelihood
    vector[N] distance = sqrt((x1 - x2)^2 + (y1 - y2)^2);
    distance ~ normal(mu, sigma);
}


