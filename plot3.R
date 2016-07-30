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

##Of the four types of sources indicated by the type (point, nonpoint, onroad,
##nonroad) variable, which of these four sources have seen decreases in 
##emissions from 1999–2008 for Baltimore City? Which have seen increases in 
##emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
##answer this question.
baltdata <- subset(aqdata, fips == "24510")

library(ggplot2)

## sum(baltdata$Emissions > 400) returned 1
png(file = "plot3.png")
ggplot(baltdata, aes(x = year, y = Emissions)) + 
        facet_wrap(~type) +
        coord_cartesian(ylim = c(0,100)) + 
        geom_point(alpha = 1/2) +
        geom_smooth(method = "lm") +
        labs(y = "PM2.5 Emissions") +
        labs(x = "Year") + 
        labs(title = "Emissions by Source Type over Time in Baltimore")
dev.off()



        
