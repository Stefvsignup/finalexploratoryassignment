library(ggplot2)
library(data.table)

#read data
setwd("~/R/FinalExploratoryAssignment/finalexploratoryassignment")
NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

#build aggregate
NEI_table <- data.table(NEI)
SCC_coal_sectors <- unique(grep("coal", SCC$EI.Sector, ignore.case=TRUE, value=TRUE))
SCC_coal_subset <-subset(SCC, EI.Sector %in% SCC_coal_sectors) 
NEI_coal_agg<-NEI_table[SCC %in% SCC_coal_subset$SCC ,list(Emissions=sum(Emissions)),by=year]

#plot aggregate
g<-ggplot(data=NEI_coal_agg, aes(year,Emissions))+geom_line()
ggsave("plot4.png",plot=g)