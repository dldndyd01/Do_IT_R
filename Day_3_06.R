# 06-2
library(dplyr)
exam <- read.csv("Data/Data/csv_exam.csv")
exam

exam %>% filter(math > 50 | science >80)
exam %>% filter(class ==1 | class ==3 | class ==5)
exam %>% filter(class %in% c(1,3,5))


# 06-3
exam %>% select(math)
exam %>% select(math, english, class)
exam %>%select(-math) # math 제외
exam %>% select(-math,-english)

exam %>% filter(class==1) %>% select(english)
exam %>% 
  filter(class ==1) %>% 
  select(english)

exam %>% 
  select(id,math) %>% 
  head
exam %>% 
  select(id,math) %>% 
  head(10)

# 06-4
exam %>% arrange(math)
exam %>% arrange(desc(math))  # -math로 입력해도 됨
exam %>% arrange(class,math)

# 06-5
exam %>% 
  mutate(total = math+english + science,
         mean = (total)/3) %>% 
  head

exam %>% 
  mutate(test = ifelse(science>=60,"pass","fail")) %>% 
  head

exam %>% 
  mutate(total = math+english+science) %>% 
  arrange(total) %>% 
  head

# 06-6
exam %>%
  summarise(mean_math = mean(math))
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math=mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n = n())        #class 별로 몇명의 학생(데이터)이 있는지 알 수 있음.

mpg %>% 
  group_by(manufacturer,drv) %>%
  summarise(mean_cty = mean(cty)) %>% 
  head(10)

mpg %>% 
  group_by(manufacturer) %>%
  filter(class =="suv") %>% 
  mutate(total = cty+hwy) %>% 
  summarise(mean_total = mean(total)) %>% 
  arrange(-mean_total) %>% 
  head(5)

# 06-7
test1 <- data.frame(id = c(1,2,3,4,5),
                    midterm = c(60,80,70,90,85))
test2 <- data.frame(id=c(1,2,3,4,5),
                    final = c(70,83,65,95,80))

total <- left_join(test1,test2,by = "id")
total

name <- data.frame(class = c(1,2,3,4,5),
                   teacher = c("kim","lee","park","choi","jung"))
exam_new <- left_join(exam, name, by = "class")
exam_new

group_a <- data.frame(id = c(1,2,3,4,5),
                      test = c(60,80,70,90,85))

group_b <- data.frame(id =c(6,7,8,9,10),
                      test = c(70,83,65,95,80))
group_a
group_b
group_all <- bind_rows(group_a,group_b)
group_all
