##download files

if (!file.exists("airdata.zip")){
        url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url1, "airdata.zip", method = "curl")  
}

##unzip files
if (!file.exists("Source_Classification_Code.rds")) {
        unzip("airdata.zip")
}

#read files into R
aqdata <- readRDS("summarySCC_PM25.rds")
sourceids <- readRDS("Source_Classification_Code.rds")

## checked for NAs in emissions data with sum(is.na(aqdata$Emissions))
## returned 0

## Have total emissions from PM2.5 decreased in the United States from 1999 to 
## 2008? Using the base plotting system, make a plot showing the total PM2.5 
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

##Note: total is skewed, number of observations increases over time
##with(aqdata, tapply(Emissions, year, length))
##1999    2002    2005    2008 
##1108469 1698677 1713850 1976655 

sums <- with(aqdata, tapply(Emissions, year, sum))
year <- as.numeric(names(sums))

png(file = "plot1.png")
par(mar = c(10, 4, 4, 2))
plot(year, sums, pch = 19, xlab = "Year", ylab = "Total PM2.5", 
     main = "Total Emissions over Time")
model <- lm(sums ~ year)
abline(model, col = "steelblue", lwd = 2)
mtext("Note: The total is skewed, as the number of observations increases over 
        time
        1999          2002          2005          2008 
        1,108,469  |1,698,677  |1,713,850  |1,976,655", side = 1, line = 8, 
      cex = 0.8)
dev.off()



