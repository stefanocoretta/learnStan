data {
  int<lower=0> N;            // Number of data points
  vector[N] x;               // x coordinates
  vector[N] y;               // y coordinates
}

parameters {
  real mean_x;               // Mean of x
  real mean_y;               // Mean of y
  real<lower=0> sigma_x;     // Standard deviation of x
  real<lower=0> sigma_y;     // Standard deviation of y
}

model {
  // Priors
  mean_x ~ normal(0, 10);
  mean_y ~ normal(0, 10);
  sigma_x ~ cauchy(0, 5);
  sigma_y ~ cauchy(0, 5);

  // Likelihood
  x ~ normal(mean_x, sigma_x);
  y ~ normal(mean_y, sigma_y);
}
