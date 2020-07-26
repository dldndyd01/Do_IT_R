# Q1 ~Q3
mpg <- as.data.frame(ggplot2::mpg)
mpg2 <-mpg
mpg2 <- mpg2 %>% 
  mutate(total = cty+hwy)
mpg2 <- mpg2 %>% 
  mutate(proportion = total/2)
mpg2 %>% 
  arrange(-proportion) %>% 
  head(3)

# Q4
mpg %>% 
  mutate(total = cty+hwy,
         mean = total/2) %>% 
  arrange(-mean) %>% 
  head(3)
