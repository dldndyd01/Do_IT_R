mpg<-as.data.frame(ggplot2::mpg)
fuel<-data.frame(fl = c("c","d","e","p","r"),
                 연료종류 = c("CNG","diesel","ethanol E85","premium","regular"),
                 가격_갤런당USD = c(2.35,2.38,2.11,2.76,2.22))
fuel

# Q1 Q2
mpg %>% head(5)
mpg_new<-left_join(mpg,fuel,by ="fl")
mpg_new %>%
  select(model,fl,가격_갤런당USD) %>% 
  head(5)
