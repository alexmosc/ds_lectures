
# clear environment -----------------

rm(list = ls()); gc()

setwd('C:/Users/burnakov_a/working_codes/experimental_codes/ds_lectures')

## load libs ----------------

library(data.table) #install.packages('data.table', dependencies = T)
library(ggplot2)
library(magrittr)
library(microbenchmark)


## prepare datasets -------------

A <- data.frame(
     col1 = sample(letters, 10, replace = T)
     , col2 = as.integer(sample(1:26, 10, replace = F))
)

B <- data.frame(
     col1 = sample(letters, 10, replace = T)
     , col2 = as.integer(sample(1:26, 10, replace = F))
)

setDT(A); setDT(B)

setkey(A, col1); setkey(B, col1)


## inner join --------------

# we want a table where key values in both tables intersect

C <- A[B, nomatch = 0]


## outer join --------------

# we want a table with all values from one table and values from other table if they exist (or NA)

C <- A[B] # outer left
C <- B[A] #outer right


## full outer join --------------

# we want all key values from both tables and other values if they exist (or NA)

C <- merge(A,B,all=T)


## cartesian join (cross join) ------------

nrow <- 100L * 100L

rand_letters <-
     sapply(
          seq_len(nrow)
          , function(x)
          {
               paste(sample(letters, 3, replace = T), collapse = '')
          }
     )

A <- data.table(
     col1 = rand_letters
     , col2 = as.integer(sample(1:26, nrow, replace = T))
)

rand_letters <-
     sapply(
          seq_len(nrow)
          , function(x)
          {
               paste(sample(letters, 3, replace = T), collapse = '')
          }
     )

B <- data.table(
     col1 = rand_letters
     , col2 = as.integer(sample(1:26, nrow, replace = T))
)

setDT(A); setDT(B)

# cross join function

CJ.dt = function(X,Y) {
     stopifnot(is.data.table(X),is.data.table(Y))
     k = NULL
     X = X[, c(k=1, .SD)]
     setkey(X, k)
     Y = Y[, c(k=1, .SD)]
     setkey(Y, NULL)
     X[Y, allow.cartesian=TRUE][, k := NULL][]
}

microbenchmark(
     {C <- CJ.dt(A, B)}
     , times = 10
)



#load('lecture_2_env.RData')

#save.image('lecture_2_env.RData')
