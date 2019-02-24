#Tidy data and transform data to a RDS file#
library(tidyverse)
#Read data from a csv file#
LApayroll = read_csv("/home/m280data/la_payroll/City_Employee_Payroll.csv")

#Q1#
LAtotpayroll <- LApayroll %>%
  group_by(`Year`) %>%
  summarise(Base = sum(`Base Pay`, na.rm = TRUE),
            Overtime = sum(`Overtime Pay`, na.rm = TRUE),
            Other = sum(`Other Pay (Payroll Explorer)`, na.rm = TRUE),
            Total = sum(Base, Overtime, Other)) %>%
  gather('Base', 'Overtime', 'Other', key = "Payment Type", value = "Amount")
write_rds(LAtotpayroll, "LAtotpayroll.rds")

#Q2#
LAEarnmost <- LApayroll %>%
  select(`Year`, `Department Title`, `Job Class Title`, `Total Payments`, `Base Pay`,
         `Overtime Pay`, `Other Pay (Payroll Explorer)`) %>%
  arrange(`Year`, desc(`Total Payments`))
write_rds(LAEarnmost, "LAEarnmost.rds")

#Q3#
LAEarnDepMean <- LApayroll %>%
  group_by(`Year`, `Department Title`) %>%
  summarise(meanBase = mean(`Base Pay`, na.rm = TRUE),
            meanOvertime = mean(`Overtime Pay`, na.rm = TRUE),
            meanOther = mean(`Other Pay (Payroll Explorer)`, na.rm = TRUE),
            meanTotal = mean(`Total Payments`)) %>%
            arrange(`Year`, desc(meanTotal))
write_rds(LAEarnDepMean, "LAEarnDepMean.rds")

LAEarnDepMed <- LApayroll %>%
  group_by(`Year`, `Department Title`) %>%
  summarise(medBase = median(`Base Pay`, na.rm = TRUE),
            medOvertime = median(`Overtime Pay`, na.rm = TRUE),
            medOther = median(`Other Pay (Payroll Explorer)`, na.rm = TRUE),
            medTotal = median(`Total Payments`)) %>%
  arrange(`Year`, desc(medTotal))
write_rds(LAEarnDepMed, "LAEarnDepMed.rds")

#Q4#
LAcostpayroll <- LApayroll %>%
  group_by(`Year`, `Department Title`) %>%
  summarise(Base = sum(`Base Pay`, na.rm = TRUE),
            Overtime = sum(`Overtime Pay`, na.rm = TRUE),
            Other = sum(`Other Pay (Payroll Explorer)`, na.rm = TRUE),
            TotalCost = sum(`Average Benefit Cost`)) %>%
  arrange(`Year`, desc(TotalCost))
write_rds(LAcostpayroll, "LAcostpayroll.rds")


            







