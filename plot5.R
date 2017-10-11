library(ggplot2)
library(data.table)

#For purposes of this study, I am assuming motor vehicles are the 'Mobile - On-Road' sectors
# - Mobile - On-road - Diesel Heavy Duty Vehicles
# - Mobile - On-road - Diesel Light Duty Vehicles
# - Mobile - On-road - Gasoline Heavy Duty Vehicles
# - Mobile - On-road - Gasoline Light Duty Vehicles

#read data
setwd("~/R/FinalExploratoryAssignment/finalexploratoryassignment")
NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

#build aggregate
NEI_table <- data.table(subset(NEI,fips=="24510"))
SCC_vehicle_sectors <- unique(grep("Mobile - On-Road", SCC$EI.Sector, ignore.case=TRUE, value=TRUE))
SCC_vehicle_subset_table<-data.table(subset(SCC, EI.Sector %in% SCC_vehicle_sectors))[,c('SCC','EI.Sector'),with=FALSE]

#do an inner join. This limits records to sectors listed above
setkey(NEI_table,SCC)
setkey(SCC_vehicle_subset_table,SCC)
NEI_table_joined <- NEI_table[SCC_vehicle_subset_table, nomatch=0]

#aggregate
NEI_vehicle_agg<-NEI_table_joined[,list(Emissions=sum(Emissions)),by=.(year,EI.Sector)]

#plot emissions from motor vehicles split by Vehicle Type
g<-ggplot(data=NEI_vehicle_agg, aes(year,Emissions,color=EI.Sector))+geom_line()
ggsave("plot5.png",plot=g)