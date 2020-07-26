# Q1
mpg <- as.data.frame(ggplot2::mpg)
mpg %>% 
  select(class,cty) %>% 
  head
# Q2
a <-mpg %>% 
  filter(class =="suv")
b <- mpg %>% 
  filter(class == "compact")
mean(a$cty)
mean(b$cty)
