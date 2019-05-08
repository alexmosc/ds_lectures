
# clear environment -----------------

rm(list = ls()); gc()

setwd('C:/Users/burnakov_a/working_codes/experimental_codes/ds_lectures')

## load libs ----------------

library(data.table) #install.packages('data.table', dependencies = T)
library(ggplot2)
library(magrittr)


## random data generation -----------

nrow <- 1000 * 1000L

rand_data <- data.table(
     a = rnorm(nrow)
     , b = sample(letters, nrow, replace = T)
     , c = runif(nrow)
)

## store data ----------

data.table::fwrite(rand_data, 'rand_data.csv')


## load data ----------

rand_data <- data.table::fread('rand_data.csv')

#load('lecture_one_env.RData')


## analyze ----------------------

lm_first <- 
     lm(
          a ~ c
          , data = rand_data
     )

summary(lm_first)


## plots --------------

# rand_data %>%
#      ggplot() %>%
#      geom_point(aes(x = a
#                     , y = c)
#                 ,
#                 size = 2
#                 ,
#                 alpha = 0.05
#                 ,
#                 color = 'blue') %>%
#      print()


ggplot(rand_data[sample(nrow(rand_data), 1000, replace = F)]) +
geom_point(
     aes(
          x = c
          , y = a
     )
     , size = 2
     , alpha = 0.05
     , color = 'blue'
     ) +
     geom_smooth(
          aes(
               x = c
               , y = a
          )
          , method = 'lm'
          , level = 0.99
     ) +
     theme_minimal()


## save all to dics --------------

save.image('lecture_one_env.RData')
