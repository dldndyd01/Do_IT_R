# 08-2
library(ggplot2)
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3,6) +
  ylim(10,30)                 # 데이터축 + 그래프종류 + 세부설정 순서

# 08-3
library(dplyr)
df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
df_mpg
ggplot(data = df_mpg,aes(x = reorder(drv,-mean_hwy),y = mean_hwy)) + geom_col() 

# 08-4
ggplot(data = economics, aes(x = date, y=unemploy)) + geom_line()

# 08-5
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()
