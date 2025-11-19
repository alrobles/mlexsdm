vsp <- function(env_data, param_list, return_raster) {
  
  env_m <- env_data_array(env_data)
  
  f <- function(env_) {
    function(mu, sigl, sigr, ctil, pd, o_mat) {
      log_prob_detect(env_, mu, sigl, sigr, ctil, pd, o_mat)
    }
  }
  if (is.null(param_list)) {
    stop("Provide a valid parameter list")
  }
  
  f_par <- f(env_m)
  
  coords <- terra::crds(env_data[[1]])
  crs_val <- terra::crs(env_data[[1]])
  probs <- suppressWarnings(
    do.call(
      f_par,
      args = param_list
    )
  )
  probs <- exp(probs)
  if(!return_raster){
    tibble::tibble(coords, probs)
  } else{
    data.frame(coords, probs) |>
      terra::rast(crs = crs_val)
  }
}
