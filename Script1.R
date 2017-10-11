library(data.table)

#read data
setwd("~/R/FinalExploratoryAssignment/finalexploratoryassignment")
NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

#build aggregate
NEI_table <- data.table(NEI)
NEI_aggregate_year<-NEI_table[,list(sum=sum(Emissions)),by=year]

#plot aggregate
plot(NEI_aggregate_year,type="l")