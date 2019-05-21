
# clear environment -----------------

rm(list = ls()); gc()

setwd('C:/Users/burnakov_a/working_codes/experimental_codes/ds_lectures')

## load libs ----------------

library(data.table) #install.packages('data.table', dependencies = T)
library(ggplot2)
library(magrittr)


## vectors --------------

myvec <- 1

length(myvec)

class(myvec)

myvec <- 1L

class(myvec)

myvec <- c(1:5)

myvec <- as.integer(c(1,2,3,4,5))

myvec <- as.integer(seq(from = 1, to = 5, by = 1))

# operations

myvec1 <- c(1:5)
myvec2 <- c(6:10)

myvec1 + myvec2
myvec1 * myvec2
myvec1 / myvec2
myvec1 ^ myvec2

max(myvec1)

which.max(myvec1) #index of largest element

sum(myvec1 * myvec2)

logvec <- T

sum(logvec)

charvec <- c('a', 'b', 'c')

dim(charvec)

rev(charvec)

# subsetting

charvec[1:5]

charvec[charvec %in% c('a', 'b')]

logvec <- charvec %in% c('a', 'b')

sum(logvec)

datevec <- Sys.Date()


## arrays ---------

myarr <- array(1:243, dim = rep(3, times = 5))

dim(myarr)

matr <- array(1:20, c(4,5))

class(matr)

vecc <- array(1:20, dim=20)

class(vecc)

print(vecc)


## matrixes -------------

vec=1:20

vec2 <- runif(20)

is.vector(vec)

set.seed(1)

normnn <- rnorm(20)

plot(density(normnn)) # Gaussian PDF

A <- matrix(normnn, ncol = 4)
B <- matrix(normnn, ncol = 5)

print(
     t(A)
)

colnames(B) <- 1:5
rownames(B) <- 1:4

# linear algebra

AB <- A %*% B

dim(AB)

solve(AB)

diagvec <- diag(AB)

distA <- dist(A)

A <- matrix(rnorm(1000000), ncol = 100)

dim(A)

distA <- dist(A)


## lists ------------------

x <- rnorm(1000)
y <- rnorm(1000)

dt <- data.frame(x, y)

linmod <- summary(lm(x~y, dt))

print(linmod)

mylist <- list()

is.vector(mylist)

mylist[[1]] <- linmod
mylist[[2]] <- 1L
mylist[[3]] <- 1/3

str(mylist)

mysecondlist <- list()

mysecondlist[[1]] <- mylist
mysecondlist[[2]] <- 'Leha'


## data.frames ------------

dt$'z' <- 1:1000L

dt$'w' <- sample(letters, 1000, replace = T)

dt$'L' <- sample(c(T,F), 1000, replace = T)

dt$'Lists'[1] <- list()

sum(
     dt$'z'
)

is.list(dt)

write.csv(dt, 'dt.csv')

dt <- read.csv('dt.csv')


## data.tables -----------------------

dt <- data.table(
     x = rnorm(1000)
)

dt[, y := rnorm(1000)]

dt[, z := sample(letters, 1000, replace = T)]

x = dt[
     , {
          meanx = mean(x)
          meany = mean(y)
          
          list(meanx=meanx, meany=meany)
     }
     , by = z
       ]

dt[sample(1:nrow(dt), 50, replace = F)][sample(50, 5, replace = F)][sample(5, 1, replace = F)]

x = dt[
     , {
          meanx = mean(x)
          meany = mean(y)
          
          list(meanx=meanx, meany=meany)
     }
     , by = z
     ][z == 'a']

setorder(dt, -z)

x = unlist(
          dt[z == 'a'
          , .(x, y)
          ]
     )

names(x)






myfunc=function(x,y) {z = x + y; return(z)}

myfunc(2,3)


#load('lecture_2_env.RData')

#save.image('lecture_2_env.RData')
