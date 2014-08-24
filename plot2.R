# plot2.R
# bill.killacky@gmail.com
#

filename1 <- "Source_Classification_Code.rds"
filename2 <- "summarySCC_PM25.rds"

SCC <- readRDS(filename1)  # Source Classification Code Table
NEI <- readRDS(filename2)  # National Emissions Inventory (NEI)
rm(filename1, filename2)

#---------------------------------------------------------------------------------------------------
# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#    (fips == "24510") from 1999 to 2008? 
#    Use the base plotting system to make a plot answering this question.
#---------------------------------------------------------------------------------------------------
N1 <- subset(NEI, fips == "24510")

s2 <- tapply(N1$Emissions, N1$year, sum)
s2

png(file = "plot2.png", width = 480, height = 480)  ## Open PNG device
barplot(s2, 
        main=expression("Baltimore City Total " * PM[2.5] *  " Emissions by Year"),
        ylab=expression(PM[2.5] * " Emissions Total"),
        xlab="Year",
        ylim=c(0,3500)
        )
dev.off()

# Total emissions from PM2.5 have decreased in Baltimore City from 1999 to 2008.
#     1999     2002     2005     2008 
# 3274.180 2453.916 3091.354 1862.282 

rm(NEI, SCC, N1, s2)
