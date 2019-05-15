
# clear environment -----------------

rm(list = ls()); gc()

setwd('C:/Users/burnakov_a/working_codes/experimental_codes/ds_lectures')

## load libs ----------------

library(data.table) #install.packages('data.table', dependencies = T)
library(ggplot2)
library(magrittr)


## random data generation -----------

# nrow <- 1000L * 1000L
# 
# rand_letters <- 
#      sapply(
#           seq_len(nrow)
#           , function(x)
#           {
#                paste(sample(letters, 3, replace = T), collapse = '')
#           }
#      )
# 
# head(rand_letters, 10L)
# 
# rand_data <- data.table(
#      a = rnorm(nrow)
#      , b = sample(letters, nrow, replace = T)
#      , c = runif(nrow)
#      , d = rand_letters
# )

## store data ----------

#data.table::fwrite(rand_data, 'rand_data.csv')


## load data ----------

#rand_data <- data.table::fread('rand_data.csv')

#load('lecture_2_env.RData')


## analyze ----------------------

pivot.table.1 <- 
     data.table::dcast(
          rand_data
          , d ~ b
          , sum
          , value.var = 'c'
     )

long.table.1 <- 
     data.table::melt(
          pivot.table.1
          , id.vars = 'd'
          , measure.vars = letters
          , variable.name = 'random_word'
          , value.name = 'runif_val'
          , value.factor = F
     )

long.table.1[, runif_val := as.numeric(runif_val)]

data.table::setkey(long.table.1, d, random_word)

data.table::setkey(rand_data, d, b)

left.join.table <- rand_data[long.table.1]

right.join.table <- rand_data[long.table.1, nomatch = 0]


## plots --------------

# ggplot_theme <- theme(
#      panel.grid.minor = element_blank() # remove minor grid marks
#      , text = element_text(size = 18) # general text size
#      , axis.text = element_text(size = 18) # changes axis labels
#      , axis.title = element_text(size = 18) # change axis titles
#      , plot.title = element_text(size = 24) # change title size
#      , axis.text.x = element_text(angle = 90, hjust = 1)
#      , legend.text = element_text(size = 20)
# )
# 
# 
# plo1 <- ggplot(rand_data[sample(nrow(rand_data), 1000, replace = F)]) +
# geom_point(
#      aes(
#           x = c
#           , y = a
#      )
#      , size = 2
#      , alpha = 0.05
#      , color = 'blue'
#      ) +
#      geom_smooth(
#           aes(
#                x = c
#                , y = a
#           )
#           , method = 'lm'
#           , level = 0.99
#      ) +
#      theme_minimal() +
#      ggplot_theme


## save all to dics --------------

save.image('lecture_2_env.RData')
