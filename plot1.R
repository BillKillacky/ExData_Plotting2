# plot1.R
# bill.killacky@gmail.com
#

filename1 <- "Source_Classification_Code.rds"
filename2 <- "summarySCC_PM25.rds"

SCC <- readRDS(filename1)  # Source Classification Code Table
NEI <- readRDS(filename2)  # National Emissions Inventory (NEI)
rm(filename1, filename2)

#---------------------------------------------------------------------------------------------------
# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#    Using the base plotting system, 
#    make a plot showing the total PM2.5 emission from all sources 
#      for each of the years 1999, 2002, 2005, and 2008.
#---------------------------------------------------------------------------------------------------

s1 <- tapply(NEI$Emissions/1000, NEI$year, sum)
s1

png(file = "plot1.png", width = 480, height = 480)  ## Open PNG device
barplot(s1, 
        main=expression("Total " * PM[2.5] *  " Emissions by Year"),
        ylab=expression(PM[2.5] * " Emissions Total (in thousands)"),
        xlab="Year",
        ylim=c(0,8000))
dev.off()

# Yes; the total emissions from PM2.5 decreased in the United States from 1999 to 2008. 
# 1999     2002     2005     2008 
# 7332.967 5635.780 5454.703 3464.206 

rm(NEI, SCC, s1)
