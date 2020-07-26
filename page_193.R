# Q1
View(mpg)
mpg_suv <- mpg %>% 
  filter(class =="suv") %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(-mean_cty) %>% 
  head(5)
mpg_suv
ggplot(data = mpg_suv, aes(x = reorder(manufacturer,-mean_cty), y = mean_cty)) + geom_col()
# Q2
ggplot(data = mpg_class, aes(x = class)) + geom_bar()
