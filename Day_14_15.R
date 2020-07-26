# 15-1
exam<-read.csv("Data/Data/csv_exam.csv")
exam[]
exam[1,]
exam[2,]
exam[exam$class ==1,]   #class가 1인 행 추출

exam[exam$math >= 80,]

exam[exam$class ==1 & exam$math >=50,]
exam[exam$english<90 | exam$science <50,]

exam[,1]
exam[,2]
exam[,3]

exam[,"class"]
exam[,"math"]
exam[,c("class","math","english")]

exam[1,3]
exam[5,"english"]
exam[exam$math >=50,"english"]
exam[exam$math >=50, c("english","science")]

# 수학점수 50이상, 영어점수 80이상인 학생들을 대상으로 각 반의 전 과목 총 평균 구하라.
# # 내장함수 코드
exam$tot <- (exam$math + exam$english + exam$science)/3
aggregate(data = exam[exam$math >=50 & exam$english >= 80,], tot~class, mean)

# dplyr코드
library(dplyr)
exam %>% 
  filter(math>=50&english>=80) %>% 
  mutate(tot = (math + english+science)/3) %>% 
  group_by(class) %>% 
  summarise(mean = mean(tot))

# 15-2
var1 <- c(1,2,3,1,2)
var2 <- factor(c(1,2,3,1,2))
var1
var2

var1 +2
var2 +2 #실행불가 팩터 변수는 연산이 안됨 .숫자가 아닌 범주를 의미하는 것임

class(var1)
class(var2)

levels(var1)
levels(var2)

var3<-c("a","b","b","c")
var4 <- factor(c("a","b","b","c"))
var3
var4

class(var3)
class(var4)

mean(var1)
mean(var2)

var2<- as.numeric(var2)
var2
mean(var2)

class(var2)
levels(var2)

# 15-3
a<-1
a
b<-"hello"
b
class(a)
class(b)

x1 <- data.frame(var1 = c(1,2,3),
                 var2 = c("a","b","c"))
x1
class(x1)

x2<- matrix(c(1:12), ncol=2)
x2
class(x2)

x3<- array(1:20,dim = c(2,5,2))
x3
class(x3)

x4 <- list(f1 = a,
           f2 = x1,
           f3 = x2,
           f4 = x3)
x4
class(x4)

mpg<-as.data.frame(ggplot2::mpg)
x<- boxplot(mpg$cty)
x
x$stats[,1][3]
