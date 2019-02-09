#! /usr/bin/env Rscript

##################################################
## Project: test_emboss.R
## Date: Feb 8th, 2019
## Author: Gilbert Lei, Jielin Yu, Olivia Lin
## Script purpose: This scripts is an unit test for the emboss.R function
##
## Example: Rscript tests/testthat/test_emboss.R
##################################################

context("Compress image")

suppressPackageStartupMessages(library(OpenImageR))
suppressPackageStartupMessages(library(testthat))
suppressPackageStartupMessages(library(emboss))

# initiate file paths 
test_input_file_path <- "test_imgs/compress/test_input.jpg"
test_output_file_path <- "test_imgs/compress/test_output.jpg"

# prepare test input image matrix
test_input <- array(0:300,dim=c(6,6,3))

# save test input image matrix as a file on computer
writeImage(test_input, test_input_file_path)

# prepare expected output image matrix
exp_output <- array(c(c(199, 160, 155, 199,
                        158, 152, 201, 158,
                        152, 202, 157, 152,
                        198, 159, 154, 202),
                      c(199, 171, 167, 195,
                        166, 160, 191, 162,
                        156, 190, 160, 152,
                        196, 155, 151, 200),
                      c(193, 150, 144, 195,
                        152, 145, 197, 154,
                        147, 197, 154, 147,
                        196, 155, 149, 193)))
#test case 1 
test_that("Test if the output is equal to the expected output",{
  compress(test_input_file_path,test_output_file_path)
  test_output <- readImage(test_output_file_path)
  expect_equal(test_output,exp_output,tolerance = 1e-3)
})

# test cacse 2 
test_that("Test the if the input type is a .jpg image ",{
  expect_error(compress(image,test_output_file_path),"This is not a right image path")
  expect_error(compress("test_imgs/emboss/input.pdf",test_output_file_path),"This is not a right image path")
  
})

# test case 3 
test_that("Test if the input image have correct size",{
  expect_equal(length(dim(test_input)), 3)
})

#test case 4
test_that("Test if the image has correct shape",{
  compress(test_input_file_path,test_output_file_path)
  test_output <- readImage(test_output_file_path)
  expect_equal(2*dim(test_output)[1],dim(test_input)[1])
  expect_equal(2*dim(test_output)[2],dim(test_input)[2])
  expect_equal(dim(test_output)[3],dim(test_input)[3])
})

#test case 5 
test_that("Test if the input path exists or not",{
  expect_error(compress("test_input.jpg",test_output_file_path),"cannot find the image")
})


#test case 6 
test_that("Test if the output path exists or not",{
  expect_error(compress(test_input_file_path, "./123/456.jpg"),"cannot find the output path")
})

