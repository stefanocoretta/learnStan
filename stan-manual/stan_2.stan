data {
  int<lower=0> N;
  vector[N] y;
}
parameters {
  real mu;
  // by setting lower to 0.1 we don't get warnings about scale parameter being 0
  // this is strange because lower=0 should mean > 0
  real<lower=0.1> sigma;
}
model {
  mu ~ normal(0, 1);
  sigma ~ normal(0, 1);

  y ~ normal(mu, sigma);
}
