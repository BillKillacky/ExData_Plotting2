# plot4.R
# bill.killacky@gmail.com
#

filename1 <- "Source_Classification_Code.rds"
filename2 <- "summarySCC_PM25.rds"

SCC <- readRDS(filename1)  # Source Classification Code Table
NEI <- readRDS(filename2)  # National Emissions Inventory (NEI)
rm(filename1, filename2)

#---------------------------------------------------------------------------------------------------
# 4. Across the United States, how have emissions from coal combustion-related sources 
#    changed from 1999-2008?
#---------------------------------------------------------------------------------------------------
library(ggplot2)
library(plyr)

coal <- SCC[grep("(.*) - Coal(.*)", SCC$EI.Sector,perl=TRUE),1]
N1 <- subset(NEI, SCC %in% coal)

s4 <- ddply(N1, .(year), numcolwise(sum))
s4$Emissions <- s4$Emissions/1000

png(file = "plot4.png", width = 480, height = 480)  ## Open PNG device
p <- ggplot(s4, aes(x=factor(year), y=Emissions)) + geom_point()
p <- p + geom_smooth(method=lm, aes(group=1))
p <- p + labs(x="Year") 
p <- p + labs(y=expression(PM[2.5] * " Emissions Total (in thousands)")) 
p <- p + labs(title=expression("Emissions Totals for the United States\nfrom Coal Combustion-related Sources"))
p <- p + theme(plot.title=element_text(hjust=0.5))
p
dev.off()
s4

# US coal combustion-related sources emissions have tended to decrease from 1999 to 2008.
# 
# ----------------
#   year Emissions
# 1 1999  572.1265
# 2 2002  546.7892
# 3 2005  552.8815
# 4 2008  343.4322
# ----------------

rm(NEI, SCC, p, coal, s4, N1)
