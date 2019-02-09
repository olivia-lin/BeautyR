#! /usr/bin/env Rscript

##################################################
## Project: test_emboss.R
## Date: Feb 8th, 2019
## Author: Gilbert Lei, Jielin Yu, Olivia Lin
## Script purpose: This scripts is an unit test for the emboss.R function
##
## Example: Rscript tests/testthat/test_emboss.R
##################################################

context("Emboss image")

suppressPackageStartupMessages(library(OpenImageR))
suppressPackageStartupMessages(library(testthat))
suppressPackageStartupMessages(library(emboss))

# initiate file paths 
test_input_file_path <- "../test_imgs/emboss/test_input.jpg"
test_output_file_path <- "../test_imgs/emboss/test_output.jpg"

# prepare test input image matrix
test_input <- array(c(199, 160, 155, 199, 158, 152,
                      201, 158, 152, 202, 157, 152,
                      198, 159, 154, 202, 167, 163,
                      202, 165, 159, 200, 163, 157,
                      199, 160, 153, 200, 161, 156,
                      205, 174, 169, 202, 171, 166,
                      199, 171, 167, 195, 166, 160,
                      191, 162, 156, 190, 160, 152,
                      196, 155, 151, 200, 159, 155,
                      197, 156, 150, 196, 155, 149,
                      196, 155, 149, 194, 155, 150,
                      197, 156, 150, 196, 155, 149,
                      194, 153, 147, 194, 153, 147,
                      195, 154, 148, 196, 155, 149,
                      196, 155, 149, 193, 150, 144,
                      195, 152, 145, 197, 154, 147,
                      197, 154, 147, 196, 155, 149,
                      193, 150, 143, 195, 152, 145), dim=c(6, 6, 3))

# save test input image matrix as a file on computer
writeImage(test_input, test_input_file_path)

# prepare expected output image matrix
exp_output <- array(c(199, 160, 155, 199,
                      158, 152, 201, 158,
                      152, 202, 157, 152,
                      198, 159, 154, 202,
                      199, 171, 167, 195,
                      166, 160, 191, 162,
                      156, 190, 160, 152,
                      196, 155, 151, 200,
                      193, 150, 144, 195,
                      152, 145, 197, 154,
                      147, 197, 154, 147,
                      196, 155, 149, 193), dim=c(4, 4, 3))

# tests 
test_that("Test whether the input is not a .jpg image", {
  expect_error(emboss(list(test_input)))
  expect_error(emboss("test_imgs/emboss/test_input.pdf", exp_output_file_path))
})

test_that("Test whether user provided too many arguments", {
  expect_error(emboss(test_input_file_path, exp_output_file_path, "hello", "world!"))
})

test_that("Test whether the input path is not a string", {
  expect_error(emboss(98999999, test_output_file_path))
})

test_that("Test whether the output path is not a string", {
  expect_error(emboss(test_input_file_path, 98999999))
})

test_that("Test whether the input path does not exist", {
  expect_error(emboss("test_imgs/hello/world.jpg", test_output_file_path))
})

test_that("Test whether the output path does not exist", {
  expect_error(emboss(test_input_file_path, "test_imgs/hello/world.jpg"))
})

test_that("Test whether the image is not correctly embossed", {
  emboss(test_input_file_path, exp_output_file_path)
  test_output <- readImage(test_output_file_path)
  expect_equal(test_output, exp_output, tolerance=1e-3)
})

cat("test_emboss.R unit test.....PASS!!!\n")
