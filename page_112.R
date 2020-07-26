mpg_data<- as.data.frame(ggplot2::mpg)
mpg_new <- rename(mpg_data, city = cty, highway = hwy)
summary(mpg_new)
