# plot3.R
# bill.killacky@gmail.com
#

filename1 <- "Source_Classification_Code.rds"
filename2 <- "summarySCC_PM25.rds"

SCC <- readRDS(filename1)  # Source Classification Code Table
NEI <- readRDS(filename2)  # National Emissions Inventory (NEI)
rm(filename1, filename2)

#---------------------------------------------------------------------------------------------------
# 3. Of the four types of sources indicated by the type 
#     (point, nonpoint, onroad, nonroad) variable,
#    which of these four sources have seen decreases in emissions 
#     from 1999-2008 for Baltimore City?
#    Which have seen increases in emissions from 1999-2008? 
#    Use the ggplot2 plotting system to make a plot answer this question.
#---------------------------------------------------------------------------------------------------
library(ggplot2)
library(plyr)

N1 <- subset(NEI, fips == "24510")
s3 <- ddply(N1, .(type, year), numcolwise(sum))

png(file = "plot3.png", width = 480, height = 480)  ## Open PNG device
p <- ggplot(s3, aes(x=factor(year), y=Emissions)) + geom_point()
p <- p + facet_grid(. ~ type) 
p <- p + geom_smooth(method=lm, aes(group=1))
p <- p + labs(x="Year") 
p <- p + labs(y=expression(PM[2.5] * " Emissions Total")) 
p <- p + labs(title=expression(PM[2.5] * " Emissions Total for Baltimore City"))
p <- p + theme(axis.text.x = element_text(angle = 90, hjust = 1))
p
dev.off()
s3

# Baltimore City changes in emissions from 1999 to 2008
#  type:(Point) has seen an increase.
#  type:(Non-Road, NonPoint, On-Road) have seen decreases.
#
#----------------------------
#        type year  Emissions
# 1  NON-ROAD 1999  522.94000
# 2  NON-ROAD 2002  240.84692
# 3  NON-ROAD 2005  248.93369
# 4  NON-ROAD 2008   55.82356
# 5  NONPOINT 1999 2107.62500
# 6  NONPOINT 2002 1509.50000
# 7  NONPOINT 2005 1509.50000
# 8  NONPOINT 2008 1373.20731
# 9   ON-ROAD 1999  346.82000
# 10  ON-ROAD 2002  134.30882
# 11  ON-ROAD 2005  130.43038
# 12  ON-ROAD 2008   88.27546
# 13    POINT 1999  296.79500
# 14    POINT 2002  569.26000
# 15    POINT 2005 1202.49000
# 16    POINT 2008  344.97518
#----------------------------

rm(SCC, NEI, N1, s3, p)
