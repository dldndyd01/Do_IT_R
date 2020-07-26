mpg <- as.data.frame(ggplot2::mpg)
mpg %>% 
  filter(manufacturer == "audi") %>% 
  arrange(-hwy) %>% 
  head(5)