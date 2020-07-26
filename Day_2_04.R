## 04-2  ##

english <- c(90,80,60,70)
english

math <- c(50,60,100,20)
math

class <- c(1,1,2,2)
class

df_midterm<- data.frame(english, math, class)
df_midterm

mean(df_midterm$english) # df_midterm에서 english로 평균 산출 
mean(df_midterm$math)    # df_midterm에서 math로 평균 산출

df_midterm <- data.frame(english = c(90,80,60,70),
                         math = c(50,60,100,20),
                         class =c(1,1,2,2))
df_midterm

write.csv(df_midterm, file = "Data/Data/df_midterm.csv")
saveRDS(df_midterm, file= "Data/Data/df_midterm.rds")
rm(df_midterm)
df_midterm <- readRDS("Data/Data/df_midterm.rds")
df_midterm
## 04-3  ##
df_exam <- read_excel("Data/Data/excel_exam.xlsx")
df_exam

mean(df_exam$english)
mean(df_exam$science)

df_exam_novar <- read_excel("Data/Data/excel_exam_novar.xlsx",col_names = F)
# cols_names가 F라는건 열을 가져올 것이냐? 아니 라는 뜻
df_exam_novar

df_exam_sheet <- read_excel("Data/Data/excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet

df_csv_exam <- read.csv("Data/Data/csv_exam.csv",stringsAsFactors = F)
df_csv_exam
