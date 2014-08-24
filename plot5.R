# plot5.R
# bill.killacky@gmail.com
#

filename1 <- "Source_Classification_Code.rds"
filename2 <- "summarySCC_PM25.rds"

SCC <- readRDS(filename1)  # Source Classification Code Table
NEI <- readRDS(filename2)  # National Emissions Inventory (NEI)
rm(filename1, filename2)

#---------------------------------------------------------------------------------------------------
# 5. How have emissions from motor vehicle sources changed 
#    from 1999-2008 in Baltimore City?
#---------------------------------------------------------------------------------------------------
motveh1 <- SCC[grep("(.*)[Vv]ehicle(.*)", SCC$EI.Sector,perl=TRUE),1]
N1 <- subset(NEI, fips == "24510" & SCC %in% motveh1)

s5 <- ddply(N1, .(year), numcolwise(sum))
s5

png(file = "plot5.png", width = 480, height = 480)  ## Open PNG device
p <- ggplot(s5, aes(x=factor(year), y=Emissions)) + geom_point()
p <- p + geom_smooth(method=lm, aes(group=1))
p <- p + labs(x="Year") 
p <- p + labs(y=expression(PM[2.5] * " Emissions Total")) 
p <- p + labs(title=expression("Emissions Totals for Baltimore City\nfrom Motor Vehicle Sources"))
p <- p + theme(plot.title=element_text(hjust=0.5))
p
dev.off()
s5

# Baltimore City emissions from motor vehicle sources have decreased from 1999 to 2008
#
# ----------------
#   year Emissions
# 1 1999 346.82000
# 2 2002 134.30882
# 3 2005 130.43038
# 4 2008  88.27546
# ----------------

rm(NEI, SCC, s5, motveh1, N1, p)
