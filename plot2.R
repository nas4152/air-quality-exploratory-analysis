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

##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
##(fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
##plot answering this question.

baltdata <- subset(aqdata, fips == "24510")
sums <- with(baltdata, tapply(Emissions, year, sum))
year <- as.numeric(names(sums))

##total observations over time: with(baltdata, tapply(Emissions, year, length))
##1999 2002 2005 2008 
##320  535  542  699 
png(file = "plot2.png")
par(mar = c(10, 4, 4, 2))
plot(year, sums, pch = 19, xlab = "Year", ylab = "Total PM2.5", 
     main = "Total Emissions over Time in Baltimore")
model <- lm(sums ~ year)
abline(model, col = "steelblue", lwd = 2)
mtext("Note: The total is skewed, as the number of observations increases over 
      time
      1999 | 2002 | 2005 | 2008 
      320  | 535  | 542  | 699 ", side = 1, line = 8, 
      cex = 0.8)
dev.off()


