data {
  int<lower=0> N;            // Number of data points
  int<lower=0> C;
  matrix[C, N] x;               // x coordinates
  matrix[C, N] y;               // y coordinates
}

parameters {
  real<lower=0> mean_a;
  real<lower=0> sd_a;
}

model {
  real area = 0.5 * abs(sum(x[1:N-1,] .* y[2:N,] - y[1:N-1,] .* x[2:N,]));

  // Prior for mean_a and sd_a
  mean_a ~ normal(0, 50);
  sd_a ~ cauchy(0, 20);
  
  // Likelihood
  target += normal_lpdf(area | mean_a, sd_a);
}