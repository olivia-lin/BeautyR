#! /usr/bin/env Rscript

##################################################
## Project: test_get_image_details.R
## Date: Feb 8th, 2019
## Author: Gilbert Lei, Jielin Yu, Olivia Lin
## Script purpose: This scripts is an unit test for the get_image_details.R function
##
## Example: Rscript tests/testthat/test_get_image_details.R
##################################################

context("Get Image Details")

library(OpenImageR)
library(testthat)
library(BeautyR)
library(png)


# initiate file paths
test_input_1 <- "test_imgs/get_image_details/input_1.png"

test_input_2 <- "test_imgs/get_image_details/input_2.png"


# prepare test input image matrix
input_1 <- array(c  (10, 12, 210, 140, 55, 60,
                     66, 21, 130, 77, 123, 209,
                     21, 35, 156, 33, 75, 178,   
                     45, 121, 21, 160, 155, 60,
                     60, 121, 10, 177, 12, 29,
                     21, 35, 156, 33, 75, 178,   
                     11, 122, 10, 145, 55, 34,
                     56, 123, 67, 145, 213, 209,
                     121, 135, 16, 67, 98, 90), 
                 dim = c(6,3,3))


input_2 <- array(c(c(10, 12, 210, 
                     140, 55, 60,
                     66, 21, 130, 
                     77, 123, 209,
                     21, 35, 156),   
                   c(45, 121, 21, 
                     160, 155, 60,
                     60, 121, 10, 
                     177, 12, 29,
                     21, 35, 156),    
                   c(11, 122, 10, 
                     145, 55, 34,
                     56, 123, 67, 
                     145, 213, 209,
                     121, 135, 16)),  
                 dim = c(3,5,3))


# save test input image matrix as a file
writeImage(input_1, "test_imgs/get_image_details/input_1.png")

writeImage(input_2, "test_imgs/get_image_details/input_2.png")



# tests 
test_that("Test whether the input is not a .png image", {
  expect_error(get_image_details("test_imgs/get_image_details/input.docs"))
})

test_that("Test whether user provided too many arguments", {
  expect_error(get_image_details(test_input_1, "All", "world!"))
})

test_that("Test whether the input path is not a string", {
  expect_error(get_image_details(98999999))
})

test_that("Test whether the input path does not exist", {
  expect_error(get_image_details("test_imgs/hello/world.jpg"))
})


# prepare expected output image matrix
exp_output_1 <-  tribble(
  ~Dimension, ~Width, ~Height, ~AspectRatio,
  "3 x 6", 3, 6, "1 : 2")

exp_output_2 <-  tribble(
   ~AspectRatio,
   "5 : 3")


test_that("Test whether the returned details are correct", {
  test_output <- get_image_details(test_input_1)
  expect_equal(test_output, exp_output_1)
})


test_that("Test whether the returned details are correct", {
  test_output <- get_image_details(test_input_2, "AspectRatio")
  expect_equal(test_output, exp_output_2)
})

cat("test_get_image_details.R unit test.....PASS!!!\n")


