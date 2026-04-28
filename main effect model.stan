// generated with brms 2.22.0
functions {
}
data {
  int<lower=1> N;  // total number of observations
  int<lower=1> N_x1;  // number of observations
  vector[N_x1] Y_x1;  // response variable
  int<lower=1> K_x1;  // number of population-level effects
  matrix[N_x1, K_x1] X_x1;  // population-level design matrix
  int<lower=1> Kc_x1;  // number of population-level effects after centering
  int<lower=1> Ksp_x1;  // number of special effects terms
  int<lower=1> N_x2;  // number of observations
  vector[N_x2] Y_x2;  // response variable
  int<lower=1> K_x2;  // number of population-level effects
  matrix[N_x2, K_x2] X_x2;  // population-level design matrix
  int<lower=1> Kc_x2;  // number of population-level effects after centering
  int<lower=1> Ksp_x2;  // number of special effects terms
  int<lower=1> N_x3;  // number of observations
  vector[N_x3] Y_x3;  // response variable
  int<lower=1> K_x3;  // number of population-level effects
  matrix[N_x3, K_x3] X_x3;  // population-level design matrix
  int<lower=1> Kc_x3;  // number of population-level effects after centering
  int<lower=1> Ksp_x3;  // number of special effects terms
  int<lower=1> N_y2;  // number of observations
  vector[N_y2] Y_y2;  // response variable
  int<lower=1> K_y2;  // number of population-level effects
  matrix[N_y2, K_y2] X_y2;  // population-level design matrix
  int<lower=1> Kc_y2;  // number of population-level effects after centering
  int<lower=1> Ksp_y2;  // number of special effects terms
  int<lower=1> N_y1;  // number of observations
  vector[N_y1] Y_y1;  // response variable
  int<lower=0> Nmi_y1;  // number of missings
  array[Nmi_y1] int<lower=1> Jmi_y1;  // positions of missings
  int prior_only;  // should the likelihood be ignored?
}
transformed data {
  matrix[N_x1, Kc_x1] Xc_x1;  // centered version of X_x1 without an intercept
  vector[Kc_x1] means_X_x1;  // column means of X_x1 before centering
  matrix[N_x2, Kc_x2] Xc_x2;  // centered version of X_x2 without an intercept
  vector[Kc_x2] means_X_x2;  // column means of X_x2 before centering
  matrix[N_x3, Kc_x3] Xc_x3;  // centered version of X_x3 without an intercept
  vector[Kc_x3] means_X_x3;  // column means of X_x3 before centering
  matrix[N_y2, Kc_y2] Xc_y2;  // centered version of X_y2 without an intercept
  vector[Kc_y2] means_X_y2;  // column means of X_y2 before centering
  for (i in 2:K_x1) {
    means_X_x1[i - 1] = mean(X_x1[, i]);
    Xc_x1[, i - 1] = X_x1[, i] - means_X_x1[i - 1];
  }
  for (i in 2:K_x2) {
    means_X_x2[i - 1] = mean(X_x2[, i]);
    Xc_x2[, i - 1] = X_x2[, i] - means_X_x2[i - 1];
  }
  for (i in 2:K_x3) {
    means_X_x3[i - 1] = mean(X_x3[, i]);
    Xc_x3[, i - 1] = X_x3[, i] - means_X_x3[i - 1];
  }
  for (i in 2:K_y2) {
    means_X_y2[i - 1] = mean(X_y2[, i]);
    Xc_y2[, i - 1] = X_y2[, i] - means_X_y2[i - 1];
  }
}
parameters {
  vector[Kc_x1] b_x1;  // regression coefficients
  real Intercept_x1;  // temporary intercept for centered predictors
  vector[Ksp_x1] bsp_x1;  // special effects coefficients
  real<lower=0> sigma_x1;  // dispersion parameter
  vector[Kc_x2] b_x2;  // regression coefficients
  real Intercept_x2;  // temporary intercept for centered predictors
  vector[Ksp_x2] bsp_x2;  // special effects coefficients
  real<lower=0> sigma_x2;  // dispersion parameter
  vector[Kc_x3] b_x3;  // regression coefficients
  real Intercept_x3;  // temporary intercept for centered predictors
  vector[Ksp_x3] bsp_x3;  // special effects coefficients
  real<lower=0> sigma_x3;  // dispersion parameter
  vector[Kc_y2] b_y2;  // regression coefficients
  real Intercept_y2;  // temporary intercept for centered predictors
  vector[Ksp_y2] bsp_y2;  // special effects coefficients
  real<lower=0> sigma_y2;  // dispersion parameter
  vector[Nmi_y1] Ymi_y1;  // estimated missings
  real Intercept_y1;  // temporary intercept for centered predictors
  real<lower=0> sigma_y1;  // dispersion parameter
}
transformed parameters {
  real lprior = 0;  // prior contributions to the log posterior
  lprior += student_t_lpdf(Intercept_x1 | 3, 0, 2.5);
  lprior += student_t_lpdf(sigma_x1 | 3, 0, 2.5)
    - 1 * student_t_lccdf(0 | 3, 0, 2.5);
  lprior += student_t_lpdf(Intercept_x2 | 3, 0, 2.5);
  lprior += student_t_lpdf(sigma_x2 | 3, 0, 2.5)
    - 1 * student_t_lccdf(0 | 3, 0, 2.5);
  lprior += student_t_lpdf(Intercept_x3 | 3, 0.1, 2.5);
  lprior += student_t_lpdf(sigma_x3 | 3, 0, 2.5)
    - 1 * student_t_lccdf(0 | 3, 0, 2.5);
  lprior += student_t_lpdf(Intercept_y2 | 3, 0.2, 2.5);
  lprior += student_t_lpdf(sigma_y2 | 3, 0, 2.5)
    - 1 * student_t_lccdf(0 | 3, 0, 2.5);
  lprior += student_t_lpdf(Intercept_y1 | 3, 0, 2.5);
  lprior += student_t_lpdf(sigma_y1 | 3, 0, 2.5)
    - 1 * student_t_lccdf(0 | 3, 0, 2.5);
}
model {
  // likelihood including constants
  if (!prior_only) {
    // vector combining observed and missing responses
    vector[N_y1] Yl_y1 = Y_y1;
    // initialize linear predictor term
    vector[N_x1] mu_x1 = rep_vector(0.0, N_x1);
    // initialize linear predictor term
    vector[N_x2] mu_x2 = rep_vector(0.0, N_x2);
    // initialize linear predictor term
    vector[N_x3] mu_x3 = rep_vector(0.0, N_x3);
    // initialize linear predictor term
    vector[N_y2] mu_y2 = rep_vector(0.0, N_y2);
    // initialize linear predictor term
    vector[N_y1] mu_y1 = rep_vector(0.0, N_y1);
    Yl_y1[Jmi_y1] = Ymi_y1;
    mu_x1 += Intercept_x1;
    mu_x2 += Intercept_x2;
    mu_x3 += Intercept_x3;
    mu_y2 += Intercept_y2;
    mu_y1 += Intercept_y1;
    for (n in 1:N_x1) {
      // add more terms to the linear predictor
      mu_x1[n] += (bsp_x1[1]) * Yl_y1[n];
    }
    for (n in 1:N_x2) {
      // add more terms to the linear predictor
      mu_x2[n] += (bsp_x2[1]) * Yl_y1[n];
    }
    for (n in 1:N_x3) {
      // add more terms to the linear predictor
      mu_x3[n] += (bsp_x3[1]) * Yl_y1[n];
    }
    for (n in 1:N_y2) {
      // add more terms to the linear predictor
      mu_y2[n] += (bsp_y2[1]) * Yl_y1[n];
    }
    target += normal_id_glm_lpdf(Y_x1 | Xc_x1, mu_x1, b_x1, sigma_x1);
    target += normal_id_glm_lpdf(Y_x2 | Xc_x2, mu_x2, b_x2, sigma_x2);
    target += normal_id_glm_lpdf(Y_x3 | Xc_x3, mu_x3, b_x3, sigma_x3);
    target += normal_id_glm_lpdf(Y_y2 | Xc_y2, mu_y2, b_y2, sigma_y2);
    target += normal_lpdf(Yl_y1 | mu_y1, sigma_y1);
  }
  // priors including constants
  target += lprior;
}
generated quantities {
  // actual population-level intercept
  real b_x1_Intercept = Intercept_x1 - dot_product(means_X_x1, b_x1);
  // actual population-level intercept
  real b_x2_Intercept = Intercept_x2 - dot_product(means_X_x2, b_x2);
  // actual population-level intercept
  real b_x3_Intercept = Intercept_x3 - dot_product(means_X_x3, b_x3);
  // actual population-level intercept
  real b_y2_Intercept = Intercept_y2 - dot_product(means_X_y2, b_y2);
  // actual population-level intercept
  real b_y1_Intercept = Intercept_y1;
}
