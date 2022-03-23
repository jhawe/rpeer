# ------------------------------------------------------------------------------
#' Calculate peer factors for given data and covariates
#'
#' Note: to get PEER on your system, there are two relevant options, as compilation
#' on a 'new' system is not straight forward:
#'  - use conda 'bioconda/r-peer'
#'  - use docker image provided here: https://quay.io/repository/biocontainers/r-peer
#'  
#' @param data nxg matrix (n=samples, g=genes/variables)
#' @param covariates nxc matrix (n=samples, c=covariates), (NULL)
#' @param iterations Number of iterations to perform in PEER estimation (1000)
#' @param Nk Number of factors to estimate. (min(100, ceiling(nrow(data) * 0.25)))
#'
#' @return List of results, including 1) the final PEER model 2) the data
#'         3) obtained data residuals 4) the estimated factors
#'
#' @author Johann Hawe
#'
#' @date 20220323
#'
# ------------------------------------------------------------------------------
correct_peer <- function(data, covariates=NULL, iterations = 1000,
                         Nk=min(100, ceiling(nrow(data)*0.25))) {
  
  if(!require(peer)) {
    stop("PEER needs to be installed to perform factor analysis.")
  }
  
  model <- PEER()
  
  # input has to be a matrix
  PEER_setPhenoMean(model, as.matrix(data))
  
  # add the mean estimation as default since it is recommended in the tutorial
  # of peer. will return Nk+1 factors
  PEER_setAdd_mean(model, TRUE)
  
  # set number of hidden factors to identify. If unknown,
  # a good measure is N/4, should not exceed 100
  PEER_setNk(model, Nk)
  
  # typically not necessary to increase, default of 1,000
  PEER_setNmax_iterations(model, iterations)
  
  if(!is.null(covariates)){
    # set matrix of known and important covariates,
    # since we want to acknowledge their effect if available
    PEER_setCovariates(model, as.matrix(covariates))
  }
  
  PEER_update(model)
  
  # gather results
  residuals <- PEER_getResiduals(model)
  colnames(residuals) <- colnames(data)
  rownames(residuals) <- rownames(data)
   factors <- PEER_getX(model)
   
  result <- list(model = model, data = data, 
                 residuals = residuals,
                 factors = factors) 
  
  return(result)
}
