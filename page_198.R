mpg_data <- mpg %>% filter(class %in% c("compact","subcompact","suv"))
ggplot(data = mpg_data,aes(x = class,y=cty))+
  geom_boxplot()
