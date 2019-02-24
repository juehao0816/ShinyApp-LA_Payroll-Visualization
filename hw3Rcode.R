#Tidy data and transform data to a RDS file#
library(tidyverse)
#Read data from a csv file#
LApayroll = read_csv("/home/hujuehao/biostat-m280-2019-winter/HW3/City_Employee_Payroll.csv")

#Q1#
LAtotpayroll <- LApayroll %>%
  group_by(Year) %>%
  summarise(Base = sum(`Base Pay`, na.rm = TRUE),
            Overtime = sum(`Overtime Pay`, na.rm = TRUE),
            Other = sum(`Other Pay (Payroll Explorer)`, na.rm = TRUE),
            Total = sum(Base, Overtime, Other)) %>%
  gather('Base', 'Overtime', 'Other', key = "Payment Type", value = "Amount")
write_rds(LAtotpayroll, "LAtotpayroll.rds")

#Q2#
LAtotpayroll <- LApayroll %>%
  group_by(Year) %>%
  summarise(Base = sum(`Base Pay`, na.rm = TRUE),
            Overtime = sum(`Overtime Pay`, na.rm = TRUE),
            Other = sum(`Other Pay (Payroll Explorer)`, na.rm = TRUE),
            Total = sum(Base, Overtime, Other)) %>%
  gather('Base', 'Overtime', 'Other', key = "Payment Type", value = "Amount")
write_rds(LAtotpayroll, "LAtotpayroll.rds")





