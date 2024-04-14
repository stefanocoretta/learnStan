data {
  // multivariate outcome
  int N;
  int K;
  array[K] vector[N] y;
  // covariates
  int P;
  array[P] vector[N] X;
  // prior
  vector[K] alpha_loc;
  vector[K] alpha_scale;
  array[P] vector[K] beta_loc;
  array[P] vector[K] beta_scale;
  real Sigma_corr_shape;
  real Sigma_scale_scale;
}
parameters {
  // regression intercept
  vector[K] alpha;
  // regression coefficients
  array[P] vector[K] beta;
  // Cholesky factor of the correlation matrix
  cholesky_factor_corr[K] Sigma_corr_L;
  vector[K] Sigma_scale;
  // student-T degrees of freedom
  real nu;
}
transformed parameters {
  array[K] vector[N] mu;
  matrix[K, K] Sigma;
  // covariance matrix
  Sigma = crossprod(diag_pre_multiply(Sigma_scale, Sigma_corr_L));
  for (i in 1:N) {
    for (k in 1:K) {
      mu[i, k] = alpha[k] + dot_product(X[i], beta[k]);
    }
  }
}
model {
  for (k in 1:K) {
    alpha[k] ~ normal(alpha_loc[k], alpha_scale[k]);
    beta[k] ~ normal(beta_loc[k], beta_scale[k]);
  }
  nu ~ gamma(2, 0.1);
  Sigma_scale ~ cauchy(0., Sigma_scale_scale);
  Sigma_corr_L ~ lkj_corr_cholesky(Sigma_corr_shape);
  y ~ multi_student_t(nu, mu, Sigma);
}
