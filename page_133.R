# Q1
mpg <- as.data.frame(ggplot2::mpg)
View(mpg)
class1 <- mpg %>% filter(displ<=4)
class2 <- mpg %>% filter(displ>=5)
mean(class1$hwy)
mean(class2$hwy)
# Q2
class1 <- mpg %>% filter(manufacturer == "audi")
class2 <- mpg %>% filter(manufacturer == "toyota")
mean(class1$cty)
mean(class2$cty)
# Q3
class1 <- mpg %>% filter(manufacturer == "chevrolet" |manufacturer =="honda" | manufacturer =="ford")
mean(class1$hwy)
