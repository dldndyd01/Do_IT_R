# 05-1 데이터 파악하기
exam <- read.csv("Data/Data/csv_exam.csv")
head(exam)
tail(exam)
View(exam)
dim(exam)
str(exam)
summary(exam)

mpg<- as.data.frame(ggplot2::mpg)
head(mpg)
tail(mpg)
dim(mpg)
View(mpg)
?mpg
summary(mpg)

# 05-2 변수명 바꾸기
df_raw <- data.frame(var1 = c(1,2,1),
                     var2 = c(2,3,2))
df_raw

df_new <- rename(df_raw, v2 = var2)  # var2를 v2로 수정
df_new

# 05-3 파생변수 만들기
df <- data.frame(var1 = c(4,3,8),
                 var2 = c(2,6,1))
df
df$var_sum <- df$var1 + df$var2
df

mpg$total <- (mpg$cty + mpg$hwy)/2
head(mpg)

summary(mpg$total)
hist(mpg$total)
mean(mpg$total)
mpg$test <- ifelse(mpg$total >=30, "A",
                   ifelse(mpg$total >= 20,"B",
                          ifelse(mpg$total >=10,"C","D")))
head(mpg, 20)

table(mpg$test) # 빈도표 만들어줌
library(ggplot2)
qplot(mpg$test)
