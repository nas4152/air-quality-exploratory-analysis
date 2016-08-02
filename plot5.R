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

##How have emissions from motor vehicle sources changed from 1999–2008 in 
##Baltimore City?

cardata <- subset(aqdata, type == "ON-ROAD")

baltcar <- subset(cardata, fips == "24510")

library(ggplot2)

png(file = "plot5.png")
ggplot(baltcar) +
        geom_point(aes(x=year, y=Emissions), alpha = 1/4) +
        geom_smooth(aes(x=year, y=Emissions), method = "lm") +
        labs(y = "PM 2.5 Emissions", x = "Year") +
        labs(title = "Motor Vehicle Emissions over Time in Baltimore")
dev.off()


