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

##Compare emissions from motor vehicle sources in Baltimore City with emissions 
##from motor vehicle sources in Los Angeles County, California 
##(fips == "06037"). Which city has seen greater changes over time in motor 
##vehicle emissions?

cardata <- subset(aqdata, type == "ON-ROAD")

subcar <- subset(cardata, fips == "24510" | fips == "06037")

subcar$fips <- gsub("24510", "Baltimore City, MD", x = subcar$fips)
subcar$fips <- gsub("06037", "Los Angeles County, CA", x = subcar$fips)

library(ggplot2)

png(file = "plot6.png")
ggplot(subcar, aes(x=year, y=Emissions)) +
        facet_wrap(~fips) +
        geom_point(alpha = 1/4) +
        coord_cartesian(ylim = c(0,50)) +
        geom_smooth(method = "lm") +
        labs(y = "PM 2.5 Emissions", x = "Year") +
        labs(title = "Motor Vehicle Emissions over Time")
dev.off()

