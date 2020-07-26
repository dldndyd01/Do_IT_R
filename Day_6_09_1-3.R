# 09-1
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)
raw_welfare <- read.spss(file = "Data/Data/Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T) #to data frame = T 는 spss파일을 데이터 프레임 형태로 변환하는 기능

welfare <- raw_welfare     # 복사본 만들기
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)
welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_region = h10_reg7)
# 09-2
class(welfare$sex)
table(welfare$sex)

welfare$sex <- ifelse(welfare$sex ==1,"male","female")
table(welfare$sex)
qplot(welfare$sex)

class(welfare$income)
summary(welfare$income)
qplot(welfare$income) + xlim(0,1000)
welfare$income <-ifelse(welfare$income ==0,NA,welfare$income)
table(is.na(welfare$income))
sex_income <- welfare %>% 
  filter(!is.na(welfare$income)) %>% 
  group_by(sex) %>% 
  summarise(mean_sexincome = mean(income))

ggplot(data = sex_income, aes(x = sex,y=mean_sexincome)) + geom_col()

# 09-3

class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)
table(is.na(welfare$birth)) #결측치 확인
welfare$birth<- ifelse(welfare$birth ==0000,NAA,welfare$birth)
table(is.na(welfare$birth))

welfare$age <- 2015 - welfare$birth +1
summary(welfare$age)

qplot(welfare$age)
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))
head(age_income)
ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()
# 09-4
welfare <- welfare %>% 
  mutate(ageg = ifelse(age<30,"young",
                       ifelse(age<=59,"middle","old")))
table(welfare$ageg)
qplot(welfare$ageg)

ageg_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income = mean(income))
ageg_income
ggplot(data = ageg_income ,aes(x = ageg, y = mean_income)) + geom_col() +
  scale_x_discrete(limits = c("young","middle","old"))

# 09-5
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg,sex) %>% 
  summarise(mean_income = mean(income))
sex_income
ggplot(data = sex_income, aes(x = ageg, y = mean_income,fill = sex)) +
  geom_col() +
  scale_x_discrete(limits = c("young","middle","old"))  
ggplot(data = sex_income, aes(x = ageg, y = mean_income,fill = sex)) +
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young","middle","old"))
sex_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age,sex) %>% 
  summarise(mean_income = mean(income))

head(sex_age)
ggplot(data = sex_age, aes(x = age, y=mean_income,col = sex)) +geom_line()

# 09-6
class(welfare$code_job)
table(welfare$code_job)

library(readxl)
list_job <- read_excel("Data/Data/Koweps_codebook.xlsx",col_names =T,sheet = 2)
head(list_job)
dim(list_job)
summary(list_job)

welfare <- left_join(welfare, list_job, id = "code_job")

welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job,job) %>% 
  head(10)

job_income <- welfare %>% 
  filter(!is.na(job)& !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))
head(job_income)

top10 <- job_income %>%
  arrange(-mean_income) %>% 
  head(10)
top10
ggplot(data = top10, aes(x = reorder(job,mean_income),y = mean_income)) + geom_col() + coord_flip()

bottom10 <- job_income %>% 
  arrange(mean_income) %>% 
  head(10)
bottom10
ggplot(data = bottom10, aes(x = reorder(job,mean_income),y = mean_income)) + geom_col() + 
  coord_flip()+
  ylim(0,850)


# 09-7
job_male <- welfare %>% 
  filter(!is.na(job) & sex =="male") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(-n) %>% 
  head(10)
job_male

job_female <- welfare %>% 
  filter(!is.na(job) & sex =="female") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(-n) %>% 
  head(10)
job_female

ggplot(data = job_male, aes(x = reorder(job,n),y = n)) + geom_col() + coord_flip()
ggplot(data = job_female, aes(x = reorder(job,n), y= n)) + geom_col() + coord_flip()

# 09-8
class(welfare$religion)
summary(welfare$religion)
table(welfare$religion)

welfare$religion <- ifelse(welfare$religion == 1,"yes", "no")
table(welfare$religion)
qplot(welfare$religion)

class(welfare$marriage)
table(welfare$marriage)

welfare$group_marriage <- ifelse(welfare$marriage ==1,"marriage",
                                 ifelse(welfare$marriage ==3,"divorce",NA))
table(welfare$group_marriage)
table(is.na(welfare$group_marriage))
qplot(welfare$group_marriage)

religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(religion,group_marriage) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n*100/tot_group,1))
religion_marriage

# religion_marriage <- welfare %>% 
#   filter(!is.na(group_marriage)) %>% 
#   count(religion, group_marriage)
# religion_marriage

divorce <- religion_marriage %>% 
  filter(group_marriage =="divorce") %>% 
  select(religion,pct)
divorce
ggplot(data = divorce, aes( x = religion,y = pct)) + geom_col()

ageg_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(ageg, group_marriage) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,1))
ageg_marriage

# ageg_marriage <- welfare %>% 
#   filter(!is.na(group_marriage)) %>% 
#   count(ageg,group_marriage) %>% 
#   group_by(ageg) %>% 
#   mutate(pct = round(n/sum(n)*100,1))

ageg_divorce <- ageg_marriage %>% 
  filter(ageg != "young" & group_marriage == "divorce") %>% 
  select(ageg,pct)
ageg_divorce
ggplot(data = ageg_divorce,aes(x = ageg,y = pct)) + geom_col()

ageg_religion_marriage <- welfare %>% 
  filter(!is.na(group_marriage) & ageg !="young") %>% 
  group_by(ageg,religion,group_marriage) %>% 
  summarise(n=n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,1))
ageg_religion_marriage

df_divorce <- ageg_religion_marriage %>% 
  filter(group_marriage == "divorce") %>% 
  select(ageg, religion,pct)
ggplot(data = df_divorce, aes(x = ageg, y = pct, fill = religion)) + geom_col(position = "dodge")

# 09-9
class(welfare$code_region)
table(welfare$code_region)

list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기)",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주도"))
list_region                          
welfare <- left_join(welfare,list_region,id = "code_region")
welfare %>% 
  select(code_region,region) %>% 
  head

region_ageg <- welfare %>% 
  count(region,ageg) %>% 
  group_by(region) %>% 
  mutate(pct = round(n/sum(n)*100,2))
region_ageg
ggplot(data = region_ageg,aes(x = region, y= pct,fill = ageg)) + geom_col() + coord_flip()

list_order_old <- region_ageg %>% 
  filter(ageg =="old") %>% 
  arrange(pct)
order <- list_order_old$region
order
ggplot(data= region_ageg,aes(x = region,y = pct,fill = ageg)) + geom_col() + coord_flip() + 
  scale_x_discrete(limits = order)

class(region_ageg$ageg)

levels(region_ageg$ageg)

region_ageg$ageg <- factor(region_ageg$ageg,
                           level = c("old","middle","young"))
class(region_ageg$ageg)
levels(region_ageg$ageg)
ggplot(data= region_ageg,aes(x = region,y = pct,fill = ageg)) + geom_col() + coord_flip() + 
  scale_x_discrete(limits = order)
