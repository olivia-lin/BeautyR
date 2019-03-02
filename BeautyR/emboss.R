#' This function embosses the original JPG image and saves the embossed image to out_path.
#'
#' @param input_path (character) -> the file path for the original image we want to emboss
#' @param output_path (character) ->  the file path to save the embossed image 
#'
#' @return No return. Transformed image will be saved into the output_path
#' @export
#'
#' @import jpeg
#' @import testit
#' 
#' @examples 

emboss <- function(input_path, output_path) { 
  # require(jpeg)
  # require(testit)
  
  # exception handling
  assert("Please provide a string as the path for the input image file.", is.character(input_path))
  assert("Please provide a string as the path for the output image file.", is.character(output_path))
  
  # read in the image that needs to be embossed
  input_img <- readJPEG(input_path) 
  
  # store image height and width 
  h <- dim(input_img)[1]    # number of rows 
  w <- dim(input_img)[2]    # number of columns 
  
  # initialize emboss filter matrix 
  emboss_filter <- t(array(c(1, 0, 0, 0, 0, 0, 0, 0, -1), dim = c(3, 3)))
  
  # set up output image matrix 
  output_img <- array(0L, dim = c(h-2, w-2, 3))
  
  # use for loops to transform each pixel in the original image using emboss filter 
  for (i in 2:(h-1)) {
    for (j in 2:(w-1)) {
      
      # set up a vector to store the transformed R, G, B values of each pixel 
      rgb <- c() 
      
      # use this for loop to go through each channel (R/G/B) 
      for (k in 1:3) {
        tl <- input_img[i-1, j-1, k]
        tm <- input_img[i-1, j, k]
        tr <- input_img[i-1, j+1, k]
        ml <- input_img[i, j-1, k]
        mm <- input_img[i, j, k]
        mr <- input_img[i, j+1, k]
        bl <- input_img[i+1, j-1, k]
        bm <- input_img[i+1, j, k]
        br <- input_img[i+1, j+1, k]
        
        # store the neighbours of a pixel as a matrix 
        neighbours <- t(array(c(tl, tm, tr, ml, mm, mr, bl, bm, br), dim = c(3, 3))) 
        
        # use emboss filter to transform each pixel 
        sum <- 0 
        for (row in 1:3) {
          for (col in 1:3) {
            sum <- sum + emboss_filter[row, 1] * neighbours[1, col] 
            sum <- sum + emboss_filter[row, 2] * neighbours[2, col] 
            sum <- sum + emboss_filter[row, 3] * neighbours[3, col] 
          }
        }
        sum <- sum + 128/255
        rgb <- c(rgb, sum)
      }
      
      # grayscale to make sure there is no color in the output image  
      newcolor <- 0.3*rgb[1] + 0.59*rgb[2] + 0.11*rgb[3] 
      newcolor <- min(1, max(0, newcolor))
      
      output_img[i-1, j-1, 1] <- newcolor
      output_img[i-1, j-1, 2] <- newcolor 
      output_img[i-1, j-1, 3] <- newcolor
    }
  }
  
  writeJPEG(output_img, output_path, quality=1) 
  
}