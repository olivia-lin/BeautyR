#! /usr/bin/env Rscript

##################################################
## Project: test_calculate_bytes.R
## Date: Feb 8th, 2019
## Author: Gilbert Lei, Jielin Yu, Olivia Lin
## Script purpose: This scripts is an unit test for the calculate_bytes.R function
##
## Example: Rscript tests/testthat/test_calculate_bytes.R
##################################################

context("Calculate bytes of image")

suppressPackageStartupMessages(library(OpenImageR))
suppressPackageStartupMessages(library(testthat))
suppressPackageStartupMessages(library(calculate_bytes))

# initiate file paths 
test_input_file_path <- "test_imgs/calculate_bytes/test_input.jpg"

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
exp_output <- 6*6*24/8

# tests 
test_that("Test whether the input is not a .jpg image", {
  expect_error(calculate_bytes(list(test_input)))
  expect_error(calculate_bytes("test_imgs/calculate_bytes/test_input.pdf", exp_output_file_path))
})

test_that("Test whether user provided too many arguments", {
  expect_error(calculate_bytes(test_input_file_path, exp_output_file_path, "hello", "world!"))
})

test_that("Test whether the input path is not a string", {
  expect_error(calculate_bytes(98999999, test_output_file_path))
})

test_that("Test whether the input path does not exist", {
  expect_error(calculate_bytes("test_imgs/hello/world.jpg", test_output_file_path))
})

test_that("Test whether the image is not correctly calculated bytes", {
  test_output <- calculate_bytes(test_input_file_path)
  expect_equal(test_output, exp_output, tolerance=1e-3)
})

cat("test_calculate_bytes.R unit test.....PASS!!!\n")
