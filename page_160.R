# Q1
midwest<-as.data.frame(ggplot2::midwest)
midwest_new <- midwest %>% 
  mutate(proportion = (poptotal-popadults)/poptotal*100)
# Q2
midwest_new %>% 
  arrange(-proportion) %>% 
  select(county,proportion) %>% 
  head(5)
# Q3
midwest_new2 <- midwest_new %>% 
  mutate(standard = ifelse(proportion>=40,"large",ifelse(proportion>=30,"middle","small")))
table(midwest_new$standard)
# Q4
midwest_new3 <- midwest_new2 %>%
  mutate(asia_pro = (popasian)/poptotal*100) %>% 
  arrange(asia_pro) %>% 
  head(10) %>% 
  select(state,county,asia_pro)
midwest_new3
