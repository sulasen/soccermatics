#' @include soccerTransform.R
#' @include soccerPitchBG.R
#' @import dplyr
NULL
#' Normalises all x,y-coordinate data from StatsBomb data
#'
#' @description Normalises x,y-coordinates from StatsBomb data to metre units for use with soccermatics functions. [StatsBomb pitch coordinates](https://github.com/statsbomb/open-data/blob/master/doc/StatsBomb%20Event%20Data%20Specification%20v1.0.2.pdf) appear to be a 120 x 80 yard pitch, and y-coordinates need to be flipped for use with soccermatics.
#' 
#' @param dat dataframe returned from StatsBombR
#' @return a dataframe
#' @examples
#' # get data
#' library(StatsBombR)
#' Matches <- FreeMatches(37)
#' d <- allinfo(Matches[1])
#' 
#' # transform
#' d <- soccerTransformSB(d)
#' 
#' @seealso \code{\link{soccerPitchBG}} readily visualises StatsBomb data with the argument `SB = TRUE`. \code{\link{soccerTransform}} transforms any arbitrary x,y-coordinates to metre units
#' @export
soccerTransformSB <- function(dat) {
  
  dat %>% 
    mutate_at(vars(contains('.x')), funs((. - 0) / diff(c(0, 120)) * 106 - 0.5)) %>% 
    mutate_at(vars(contains('.y')), funs(70.4 - (. - 0)/diff(c(0, 80)) * 70.4 + 0.5))
}
