
# clear environment -----------------

rm(list = ls()); gc()

setwd('C:/Users/burnakov_a/working_codes/experimental_codes/ds_lectures')

## load libs ----------------

library(data.table) #install.packages('data.table', dependencies = T)
library(ggplot2)
library(magrittr)
library(lubridate)


## prepare data -------------

## http://www.gks.ru/wps/wcm/connect/rosstat_main/rosstat/ru/statistics/population/demography/#


# population total

dat_pop_count <- fread('dat_pop_count1.csv')

# plot1

ggplot(dat_pop_count) +
     geom_line(
          aes(
               x = is_year
               , y = as.numeric(total)
          )
     ) +
     theme_minimal() +
     geom_vline(
          aes(
               xintercept = 1991
          )
          , color = 'red'
          , size = 1
     ) +
     geom_vline(
          aes(
               xintercept = 2000
          )
          , color = 'blue'
          , size = 2
     ) +
     geom_hline(
          aes(
               yintercept = max(dat_pop_count$total)
          )
          , color = 'brown'
          , size = 1
     )

## city/rural

dat_pop_melt <-
     melt(
          dat_pop_count
          , id.vars = 'is_year'
          , measure.vars = c("city", "peasant")
     )

# plot 2

ggplot(dat_pop_melt) +
     geom_line(
          aes(
               x = is_year
               , y = as.numeric(value)
               , group = variable
               , color = variable
          )
          , size = 2
     ) +
     geom_vline(
          aes(
               xintercept = 1991
          )
          , color = 'red'
          , size = 1
     ) +
     geom_vline(
          aes(
               xintercept = 2000
          )
          , color = 'blue'
          , size = 2
     ) +
     geom_vline(
          aes(
               xintercept = 2016
          )
          , color = 'green'
          , size = 2
     ) +
     theme_minimal()


## Population Age ---------------

dat_age <- 
     fread('age_pop.csv', header = T)


age_melt <-
     melt(
          dat_age
          , id.vars = 'age'
          , measure.vars = colnames(dat_age)[!colnames(dat_age) == 'age']
     )

# plot 3

ggplot(age_melt) +
     geom_violin(
          aes(
               x = variable
               , y = age
               , weight = value
               , group = variable
               , fill = variable
          )
          #, stat = "identity"
          , size = 1
     ) +
     theme_minimal()


## Mortality and birth rate ----------

dat_birt <- fread('mort_birt.csv', header = T)

dat_birt_melt <-
     melt(
          dat_birt
          , id.vars = 'is_year'
          , measure.vars = c("births" , "death" ,  "delta")
     )

# plot 4

ggplot(dat_birt_melt) +
     geom_line(
          aes(
               x = is_year
               , y = as.numeric(value)
               , group = variable
               , color = variable
          )
          , size = 2
     ) +
     geom_vline(
          aes(
               xintercept = 1991
          )
          , color = 'red'
          , size = 1
     ) +
     geom_vline(
          aes(
               xintercept = 2000
          )
          , color = 'blue'
          , size = 2
     ) +
     geom_vline(
          aes(
               xintercept = 2016
          )
          , color = 'green'
          , size = 2
     ) +
     geom_hline(
          aes(
               yintercept = 0
          )
          , color = 'black'
          , size = 1
     ) +
     theme_minimal()

