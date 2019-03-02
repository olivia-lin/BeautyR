#! /usr/bin/env Rscript

##################################################
## Project: test_emboss.R
## Date: Feb 28th, 2019
## Author: Gilbert Lei, Jielin Yu, Olivia Lin
## Script purpose: This scripts is an unit test for the emboss.R function
##
## Example: Rscript tests/testthat/test_emboss.R
##################################################

context("Emboss image")

# initiate file paths 
test_input_file_path <- c("./test_imgs/emboss/test_input.jpg")
test_output_file_path <- c("./test_imgs/emboss/test_output.jpg")

# prepare test input image array
test_input <- array(c(c(162, 157, 165, 157, 147, 158,
                        169, 174, 172, 164, 165, 161,
                        166, 171, 171, 171, 168, 182,
                        168, 168, 168, 162, 165, 175,
                        177, 175, 166, 167, 173, 175,
                        175, 174, 169, 160, 158, 160),
                      c(116, 108, 109,  97,  89, 102,
                        121, 122, 114, 104, 105, 103,
                        114, 118, 113, 111, 110, 124,
                        115, 115, 112, 106, 109, 119,
                        124, 122, 115, 116, 122, 122,
                        122, 123, 120, 113, 110, 109), 
                      c(101,  94,  96,  86,  77,  89,
                        107, 109, 102,  93,  94,  91,
                        101, 104, 101, 100,  96, 110,
                        101, 101,  99,  91,  94, 104,
                        110, 108,  98,  99, 105, 106,
                        108, 106, 103,  95,  90,  90)), 
                    dim=c(6, 6, 3))

# save test input image matrix as a file on computer
writeJPEG(test_input, test_input_file_path, quality = 1)

# prepare expected output image matrix
exp_output <- array(c(c(0.5294118, 0.6078431, 0.6235294, 0.4470588,
                        0.5215686, 0.6156863, 0.5568627, 0.4117647,
                        0.5450980, 0.5764706, 0.5019608, 0.3764706,
                        0.5607843, 0.6039216, 0.5254902, 0.4352941),
                      c(0.5294118, 0.6078431, 0.6235294, 0.4470588,
                        0.5215686, 0.6156863, 0.5568627, 0.4117647,
                        0.5450980, 0.5764706, 0.5019608, 0.3764706,
                        0.5607843, 0.6039216, 0.5254902, 0.4352941), 
                      c(0.5294118, 0.6078431, 0.6235294, 0.4470588,
                        0.5215686, 0.6156863, 0.5568627, 0.4117647,
                        0.5450980, 0.5764706, 0.5019608, 0.3764706,
                        0.5607843, 0.6039216, 0.5254902, 0.4352941)), 
                    dim=c(4, 4, 3))

test_that("The image is not correctly embossed", {
  emboss(test_input_file_path, test_output_file_path)
  test_output <- readJPEG(test_output_file_path)
  expect_equal(test_output, exp_output, tolerance=1e1)
})

test_that("The input path is not a string", {
  expect_error(emboss(98999999, test_output_file_path))
})

test_that("The output path is not a string", {
  expect_error(emboss(test_input_file_path, 98999999))
})
# 
# 
# test_that("Test whether the input is not a .jpg image", {
#   expect_error(emboss(list(test_input)))
#   expect_error(emboss("test_imgs/emboss/test_input.pdf", exp_output_file_path))
# })
# 
# test_that("Test whether user provided too many arguments", {
#   expect_error(emboss(test_input_file_path, exp_output_file_path, "hello", "world!"))
# })
# 
# test_that("Test whether the input path does not exist", {
#   expect_error(emboss("test_imgs/hello/world.jpg", test_output_file_path))
# })
# 
# test_that("Test whether the output path does not exist", {
#   expect_error(emboss(test_input_file_path, "test_imgs/hello/world.jpg"))
# })

cat("test_emboss.R unit test.....PASS!!!\n")
