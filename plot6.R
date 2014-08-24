# plot6.R
# bill.killacky@gmail.com
#

filename1 <- "Source_Classification_Code.rds"
filename2 <- "summarySCC_PM25.rds"

SCC <- readRDS(filename1)  # Source Classification Code Table
NEI <- readRDS(filename2)  # National Emissions Inventory (NEI)
rm(filename1, filename2)

#---------------------------------------------------------------------------------------------------
# 6. Compare emissions from motor vehicle sources in Baltimore City 
#     with emissions from motor vehicle sources 
#     in Los Angeles County, California (fips == "06037").
#    Which city has seen greater changes over time in motor vehicle emissions?
#---------------------------------------------------------------------------------------------------
library(ggplot2)
library(plyr)

motveh1 <- SCC[grep("(.*)[Vv]ehicle(.*)", SCC$EI.Sector,perl=TRUE),1]
N1 <- subset(NEI, (fips == "24510" | fips == "06037") & SCC %in% motveh1)

s6 <- ddply(N1, .(fips, year), numcolwise(sum))
s6

s6$fips = factor(s6$fips)
levels(s6$fips)
levels(s6$fips)[levels(s6$fips)=="06037"] <- "Los Angeles County"
levels(s6$fips)[levels(s6$fips)=="24510"] <- "Baltimore City"
levels(s6$fips)

png(file = "plot6.png", width = 480, height = 480)  ## Open PNG device
p <- ggplot(s6, aes(x=factor(year), y=Emissions)) + geom_point()
p <- p + facet_grid(. ~ fips) 
p <- p + geom_smooth(method=lm, aes(group=1))
p <- p + labs(x="Year") 
p <- p + labs(y=expression(PM[2.5] * " Emissions Total")) 
p <- p + labs(title=expression("Emissions Totals for the Baltimore and Los Angeles\nfrom Motor Vehicle Sources"))
p <- p + theme(plot.title=element_text(hjust=0.5))
p
dev.off()
s6

# motor vehicle emissions in Los Angeles County are much higher (on average 24 times) than Baltimore.
# Los Angeles emission are trending higher, while Baltimore is trending lower.
#
# ------------------------------------
#                 fips year  Emissions
# 1 Los Angeles County 1999 3931.12000
# 2 Los Angeles County 2002 4274.03020
# 3 Los Angeles County 2005 4601.41493
# 4 Los Angeles County 2008 4101.32100
# 5     Baltimore City 1999  346.82000
# 6     Baltimore City 2002  134.30882
# 7     Baltimore City 2005  130.43038
# 8     Baltimore City 2008   88.27546
# ------------------------------------

rm(NEI, SCC, N1, s6, motveh1, p)
