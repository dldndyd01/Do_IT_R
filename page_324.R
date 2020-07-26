mpg<- as.data.frame(ggplot2::mpg)
library("dplyr")
mpg %>% 
  mutate(tot = (cty+hwy)/2) %>% 
  filter(class == "compact" | class == "suv") %>% 
  group_by(class) %>% 
  summarise(mean_tot = mean(tot))

mpg$tot <- (mpg$cty + mpg$hwy)/2
aggregate(data =mpg[mpg$class =="suv" | mpg$class =="compact",], tot~class,mean)
