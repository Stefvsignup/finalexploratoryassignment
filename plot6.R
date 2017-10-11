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
SCC_vehicle_sectors <- unique(grep("Mobile - On-Road", SCC$EI.Sector, ignore.case=TRUE, value=TRUE))
SCC_vehicle_subset_table<-data.table(subset(SCC, EI.Sector %in% SCC_vehicle_sectors))[,c('SCC','EI.Sector'),with=FALSE]

#do an inner join. This limits records to sectors listed above
NEI_table_both<-data.table(subset(NEI, fips %in% c("06037","24510") & SCC %in% SCC_vehicle_subset_table$SCC))
NEI_table_both[fips=="06037",fips:="La"]
NEI_table_both[fips=="24510",fips:="Baltimore"]

#plot emissions from motor vehicles split by Vehicle Type
g<-ggplot(data=NEI_table_both, aes(year,Emissions))+geom_bar(stat="Identity")+facet_grid(.~fips)
ggsave("plot6.png",plot=g)