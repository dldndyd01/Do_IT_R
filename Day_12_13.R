# 13-2
mpg <- as.data.frame(ggplot2::mpg)
library(dplyr)
mpg_diff <- mpg %>% 
  select(class,cty) %>% 
  filter(class %in% c("compact","suv"))

head(mpg_diff)
table(mpg_diff$class)
t.test(data = mpg_diff, cty ~ class, var.equal = T)

mpg_diff2 <- mpg %>% 
  select(fl,cty) %>% 
  filter(fl %in% c("r","p"))    # r: regular, p: premium

table(mpg_diff2$fl)
t.test(data = mpg_diff2, cty ~ fl, var.equal = T)

# 13-3 
economics <- as.data.frame(ggplot2::economics)
cor.test(economics$unemploy, economics$pce)
head(mtcars)
car_cor <- cor(mtcars)
round(car_cor,2)

install.packages("corrplot")
library(corrplot)
corrplot(car_cor)


corrplot(car_cor,method = "number")
col <- colorRampPalette(c("#BB4444","#EE9988","#FFFFFF","#77AADD","#4477AA"))
corrplot(car_cor,
         method = "color",
         col = col(200),
         type = "lower",
         order = "hclust",
         addCoef.col = "black",
         tl.col = "black",
         tl.srt = 45,
         diag = F)
