
# clear environment -----------------

rm(list = ls()); gc()

setwd('C:/Users/burnakov_a/working_codes/experimental_codes/ds_lectures')

## load libs ----------------

library(data.table) #install.packages('data.table', dependencies = T)
library(ggplot2)
library(magrittr)
library(microbenchmark)
library(doParallel)
# library(purrr)
# library(future)
# library(furrr)
# library(promises)


## prepare data -------------

data(mtcars)

mtcars

dat = as.data.table(mtcars)


## simple function -----------------

my.func <- function(a, b) a + b

my.func(a = 1, b = 2)


# for loop
for(i in 1:10) print(my.func(rnorm(1), rnorm(1)))


## not so simple function -----------------

my.func <- function(
     a
     , b
                    )
{
     stopifnot(
          class(a) == 'numeric'
          && class(b) == 'numeric'
     )
     
     a = as.numeric(a)
     b = as.numeric(b)

     c = a + b; c
}


x = my.func(a = 1, b = 2)

x


## function inside function -----------------

my.func <- function(
     a
     , b
)
{
     stopifnot(
          class(a) == 'numeric'
          && class(b) == 'numeric'
     )
     
     .func <- function(a, b){
          a * b
     }
     
     c = .func(a, b)
     
     return(c)
}

my.func(a = 1, b = 2)


# anonimous function

my.func <- function(
     a = 1
     , b = 2
     , .func = function(a, b) a * b
)
{
     stopifnot(
          class(a) == 'numeric'
          && class(b) == 'numeric'
     )

     c = .func(a, b)
     
     return(c)
}

my.func()

my.func(a = 1, b = 2)


## side effects ----------------------

x <- numeric(1)

my.func <- function(
     a = 1
     , b = 2
     , .func = function(a, b) a * b
)
{
     stopifnot(
          class(a) == 'numeric'
          && class(b) == 'numeric'
     )
     
     c = .func(a, b)
     
     x <<- c # side effect
     
     my.env <<- new.env() # side effect
     
     return(c) # main effect
}

c = my.func()



## apply functions on vectors / lists -----------

my.func.0 <- function(vec, ...)
{
     my.sum = 0
     
     for(
          i in seq_along(vec)
         )
     {
          
          my.sum = my.sum + vec[i]
          
     }
     
     my.sum
}

my.func <- function(
     a = 1
     , b = 2
     , x
     , sum.func = my.func.0
     , ...
)
{
     stopifnot(
          class(a) == 'numeric'
          && class(b) == 'numeric'
          && class(x) == 'integer'
     )
     
     my.sum = sum.func(vec = c(a, b))
     
     c = my.sum * x
     
     return(c) # main effect
}

my.vec <- as.list(1:100)

my.result = sapply(my.vec, function(x) {my.func(x = x)})

head(my.result, 3)

my.result = lapply(my.vec, function(x) {my.func(x = x)})



## parallel apply -------

my.func.0 <- function(vec, ...)
{
     my.sum = 0
     
     for(
          i in seq_along(vec)
     )
     {
          
          my.sum = my.sum + vec[i]
          
     }
     
     my.sum
}

my.func <- function(
     a = 1
     , b = 2
     , x
     , sum.func = my.func.0
     , ...
)
{
     stopifnot(
          class(a) == 'numeric'
          && class(b) == 'numeric'
          && class(x) == 'integer'
     )
     
     my.sum = sum.func(vec = c(a, b))
     
     c = my.sum * x
     
     return(c) # main effect
}

my.vec <- as.list(1:10000000)

# run in parallel on multiple cores

my.cores <- parallel::detectCores(all.tests = T) - 2L

cl <- makeCluster(my.cores)
registerDoParallel(cl)

clusterExport(
     cl
     , list('my.func', 'my.func.0')
)

my.result = parLapply(
     cl
     , my.vec
     , function(x)
          {
          my.func(x = x)
     }
)

stopCluster(cl)


## function inside data.table ----

car.func <- function(
     sd
     , by
)
{
     
     my.summ <- summary(
          lm(
               mpg ~ hp, data = sd
          )
     )
     
     results <- list(
          car.label = by
          , summary = my.summ
     )
     
     return(
          list(results)
     )
     
}

dat[, car.label := rownames(mtcars)]

my.result <- dat[
     , list(car.func(sd = .SD, by = .BY))
     , by = vs
]

# result

print(
     my.result[vs == 1, V1]
)


