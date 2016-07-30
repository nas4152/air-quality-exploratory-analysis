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

##Across the United States, how have emissions from coal combustion-related 
##sources changed from 1999–2008?

##Select sources classified as coal combustion and subset data
index <- grep("coal$", sourceids$EI.Sector, ignore.case = TRUE)
sccsub <- as.character(sourceids$SCC[index])

coaldata <- subset(aqdata, SCC %in% sccsub)

library(ggplot2)

##store boxplot stats to set y limits to ignore outliers (zoom in on box but 
##keep outliers in calculations)
ylim1 <- boxplot.stats(coaldata$Emissions[coaldata$year == 2008])$stats[c(1, 5)]

##create and save plot
png(file = "plot4.png")
ggplot(coaldata, aes(x = as.factor(year), y = Emissions)) +
        geom_boxplot(aes(group = year), outlier.shape = NA) +
        stat_boxplot(geom ='errorbar', aes(group = year)) +
        coord_cartesian(ylim = ylim1*1.05) +
        labs(x = "Year") +
        labs(y = "PM 2.5 Emissions") +
        labs(title = "Coal Emissions in the US over Time")
dev.off()



