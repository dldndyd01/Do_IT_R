# Q1
mpg <- as.data.frame(ggplot2::mpg)
mpg %>% 
  group_by(class) %>% 
  summarise(mean_city = mean(cty))

# Q2
mpg %>% 
  group_by(class) %>% 
  summarise(mean_city = mean(cty)) %>% 
  arrange(-mean_city)

# Q3
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(-mean_hwy) %>% 
  head(3)

# Q4
mpg %>% 
  filter(class =="compact") %>% 
  group_by(manufacturer) %>% 
  summarise(n = n()) %>% 
  arrange(-n)
          