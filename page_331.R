mpg<- as.data.frame(ggplot2::mpg)
class(mpg$drv)

mpg$drv <- as.factor(mpg$drv)
class(mpg$drv)
levels(mpg$drv)
