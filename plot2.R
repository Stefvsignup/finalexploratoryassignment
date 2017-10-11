library(data.table)

#read data
setwd("~/R/FinalExploratoryAssignment/finalexploratoryassignment")
NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

#build aggregate
NEI_table <- data.table(NEI)
NEI_agg_balt_year<-NEI_table[fips=="24510",list(sum=sum(Emissions)),by=year]

#plot aggregate
png(file = "plot2.png", width=480, height=480)
plot(NEI_agg_balt_year,type="l")
dev.off()