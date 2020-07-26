mpg<- as.data.frame(ggplot2::mpg)
mpg[c(65,124,131,153,212),"hwy"] <-NA
table(is.na(mpg$hwy))
table(is.na(mpg$drv))

mpg %>% group_by(drv) %>% na.omit(!is.na(hwy)) %>% summarise(mean_hwy = mean(hwy))
