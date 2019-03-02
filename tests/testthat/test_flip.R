#! /usr/bin/env Rscript

##################################################
## Project: test_flip.R
## Date: Feb 8th, 2019
## Author: Gilbert Lei, Jielin Yu, Olivia Lin
## Script purpose: This scripts is an unit test for the flip.R function
##
## Example: Rscript tests/testthat/test_flip.R
##################################################

context("Flip image")

library(png)
library(testthat)
library(BeautyR)

# initiate file paths 
test_input_file_path <-c( "./test_imgs/flip/test_input.png")
test_output_file_path_h <- c("./test_imgs/flip/test_output_h.png")
test_output_file_path_v <- c("./test_imgs/flip/test_output_v.png")

# prepare test input image matrix
c1 <- c(1,0,1)
c2 <- c(1,1,1)
c3 <- c(1,0,0)
c4 <- c(1,0,1)
c5 <- c(1,1,1)
c6 <- c(1,0,0)
c7 <- c(1,0,1)
c8 <- c(1,1,1)
c9 <- c(1,0,0)
test_input <- array(c(c1,c2,c3,c4,c5,c6,c7,c8,c9),dim = c(3,3,3))

# save test input image matrix as a file on computer
writePNG(test_input, target=test_input_file_path)

# Expected test image for horizontal flip 
c1_h <- c(1,0,0)
c2_h <- c(1,1,1)
c3_h <- c(1,0,1)
c4_h <- c(1,0,0)
c5_h <- c(1,1,1)
c6_h <- c(1,0,1)
c7_h <- c(1,0,0)
c8_h <- c(1,1,1)
c9_h <- c(1,0,1)
img_h_exp <- array(c(c1_h,c2_h,c3_h,c4_h,c5_h,c6_h,c7_h,c8_h,c1_h),dim = c(3,3,3))

# Expected test image for vertical flip 
c1_v <- c(1,0,1)
c2_v <- c(1,1,1)
c3_v <- c(0,0,1)
c4_v <- c(1,0,1)
c5_v <- c(1,1,1)
c6_v <- c(0,0,1)
c7_v <- c(1,0,1)
c8_v <- c(1,1,1)
c9_v <- c(0,0,1)
img_v_exp <- array(c(c1_v,c2_v,c3_v,c4_v,c5_v,c6_v,c7_v,c8_v,c9_v),dim = c(3,3,3))

# Test function 

flip_h <- flip(test_input_file_path,test_output_file_path_h,"h")
flip_v <- flip(test_input_file_path,test_output_file_path_v,"v")

#test case 1 
test_that("Function reuslt is the same as the expected result",{
  flip(test_input_file_path,test_output_file_path_h,"h")
  test_output <- readPNG(test_output_file_path_h)
  expect_equal(test_output,img_h_exp, tolerance=1e1)
  
})

test_that("Function reuslt is the same as the expected result",{
  test_output <- readPNG(test_output_file_path_v)
  expect_equal(test_output,img_v_exp)

})

# test cacse 2 
test_that("The input type is not a .PNG image ",{
  expect_error(flip("tests/test_imgs/flip/test_output_v.jpg",test_output_file_path_v,"v"))
  
})

# test case 3 
test_that("Test if the input image have correct size",{
  expect_equal(length(dim(test_input)), 3)
})

#test case 4
test_that("If user gives an right flip direction", {
  
  expect_error(flip(test_input_file_path,test_output_file_path_v,"a"))
})


#test case 5 
test_that("Test if the input/output path exists or not",{
  expect_error(flip("test_input.jpg",test_output_file_path_v,"v"))
  expect_error(flip(test_input_file_path, "./123/456.jpg","v"))
})


#test case 6 
test_that("Test if the input/output is not a string",{
  expect_error(flip(1,test_output_file_path_h,"h"))
  expect_error(flip(test_input_file_path,1,"h"))
})



