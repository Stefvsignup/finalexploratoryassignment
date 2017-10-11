library(data.table)
library(ggplot2)

#read data
setwd("~/R/FinalExploratoryAssignment/finalexploratoryassignment")
NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

#build aggregate
NEI_table <- data.table(NEI)
NEI_balt_year_type<-NEI_table[fips=="24510",list(Emissions=sum(Emissions)),by=.(year,type)]

#plot aggregate
g<-ggplot(NEI_balt_year_type,aes(year, Emissions, color=type)) + geom_line()
ggsave("plot3.png",plot=g)