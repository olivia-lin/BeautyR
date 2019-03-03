#' This function returns details about the image, such as dimension, width, height, and image ratio.
#'
#' @param input_path (string) ->  The file path for the image we want to return information of.
#' @param detail (string) -> The name of attribute that the function will return. Default set to be 'All'. Available choices are: 'All', 'Dimension', 'Width', 'Height', and 'Aspect Ratio'.
#'
#' @return A data frame that has the detailed information about input image.
#' @export
#'
#' @import png 
#' @import testit
#' @import tibble
#' 
get_image_details <- function(input_path, detail = 'All'){
  
  img <- readPNG(input_path)
  
  h <- dim(img)[1]
  
  w <- dim(img)[2]

  if (w<=h){
    x <- w
    y <- h
  } else{
    x <- h
    y <- w
  }
  
  gcd <- 1
  
  if (y %% x == 0){
    gcd <- x
  } else{
    for (i in ceiling(y/2):1) {
      if (x %% i == 0 & y %% i == 0) {
        gcd <- i
        break
      }
    }
  }
  
  dimension <- paste(c(w, "x", h), collapse = " ")
  
  ratio <- paste(c(w/gcd, ":", h/gcd), collapse = " ")
  
  details <- tribble(
    ~Dimension, ~Width, ~Height, ~AspectRatio,
    dimension, w, h, ratio
  )
  
  if (detail == 'All'){
    return(details)
  } else{
    return(details[detail])
  }
  
}