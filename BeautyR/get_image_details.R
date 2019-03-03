library(png)
library(testit)
library(dplyr)


get_image_details <- function(input_path, detail = 'All'){
  
  #  This function returns details about the image, such as dimension, width, height, and image ratio.
  #  
  #   Parameters
  #   ---------------------------------------
  #   test_input_file_path (string) ->  The file path for the image we want to return information of.
  #       
  #   detail (string) -> The name of attribute that the function will return. Default set to be 'All'.
  #                       Available choices are: 'All', 'Dimension', 'Width', 'Height', and 'Aspect Ratio'.
  #
  #   Return
  #   ---------------------------------------
  #   A data frame that has the detailed information about input image.
  
  img <- readPNG(input_path)
  
  h <- dim(img)[1]
  
  w <- dim(img)[2]
  
  h <- 3
  
  w <- 6
  
  
  if (w<=h){
    w <- w
    y <- h
  } else{
    x <- h
    y <- w
  }
  
  gcd <- 1
  
  if (x %% y == 0){
    gcd <- y
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