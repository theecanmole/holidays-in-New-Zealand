## Public and statutory holidays in New Zealand






## filter the dates series obtained from Python 'import holidays' package

# read in data from a local folder

holidays <- read.csv("new_zealand_holidays.csv" , skip=0, header=TRUE, sep=",", colClasses = c("Date","character"),na.strings='NA', dec=".", strip.white=TRUE)

str(holidays)

'data.frame':	202 obs. of  2 variables:
 $ Date        : Date, format: "2010-01-01" "2010-01-02" ...
 $ Holiday.Name: chr  "New Year's Day" "Day after New Year's Day" "Day after New Year's Day (observed)" "Waitangi Day" ...

 # How many days of dates should be included if there were all dates from May 2010 to most recent date?
#spotpricealldates <- seq.Date(from=spotprices$date[1], to=spotprices$date[nrow(spotprices)], by="day")
alldates <- seq.Date(min(holidays$Date), max(holidays$Date), "day")
length(alldates)
[1] 6206
str(alldates)
 Date[1:6206], format: "2010-01-01" "2010-01-02" "2010-01-03" "2010-01-04" "2010-01-05" ...

# create a dataframe of "all the dates" or 'x' including business days added as NA
alldatesdataframe <- merge(x= data.frame(Date = alldates),  y = holidays,  all.x=TRUE)
str(alldatesdataframe)
'data.frame':	6206 obs. of  2 variables:
 $ Date        : Date, format: "2010-01-01" "2010-01-02" ...
 $ Holiday.Name: chr  "New Year's Day" "Day after New Year's Day" NA "Day after New Year's Day (observed)" ...

head(alldatesdataframe)
        Date                        Holiday.Name
1 2010-01-01                      New Year's Day
2 2010-01-02            Day after New Year's Day
3 2010-01-03                                <NA>
4 2010-01-04 Day after New Year's Day (observed)
5 2010-01-05                                <NA>
6 2010-01-06                                <NA>

headalldatesdataframe <- head(alldatesdataframe)

headalldatesdataframe[["Holiday.Name"]]
[1] "New Year's Day"                      "Day after New Year's Day"
[3] NA                                    "Day after New Year's Day (observed)"
[5] NA                                    NA

# change NA to BusinessDay

# For a data frame column:
df$column_name[is.na(df$column_name)] <- "replacement_string"


headalldatesdataframe[["Holiday.Name"]][is.na(headalldatesdataframe[["Holiday.Name"]])] <- "BusinessDay"

headalldatesdataframe[["Holiday.Name"]]
[1] "New Year's Day"                      "Day after New Year's Day"
[3] "BusinessDay"                         "Day after New Year's Day (observed)"
[5] "BusinessDay"                         "BusinessDay"


holidays$day <- format(as.Date(holidays$Date), "%A")

holidays$day <- format(as.Date(holidays$Date), "%A")

head(holidays)
        Date                        Holiday.Name      day
1 2010-01-01                      New Year's Day   Friday
2 2010-01-02            Day after New Year's Day Saturday
3 2010-01-04 Day after New Year's Day (observed)   Monday
4 2010-02-06                        Waitangi Day Saturday
5 2010-04-02                         Good Friday   Friday
6 2010-04-05                       Easter Monday   Monday

headalldatesdataframe$Day <- format(as.Date(headalldatesdataframe[["Date"]], "%A"))

headalldatesdataframe

# Get the days of week and add to dateframe
holidays$day <- format(as.Date(holidays$Date), "%A")

library(poorman)


# For a data frame column:
headalldatesdataframe <- headalldatesdataframe %>% mutate(Holiday.Name = replace_na(Holiday.Name, "business day"))
        Date                        Holiday.Name
1 2010-01-01                      New Year's Day
2 2010-01-02            Day after New Year's Day
3 2010-01-03                        business day
4 2010-01-04 Day after New Year's Day (observed)
5 2010-01-05                        business day
6 2010-01-06                        business day

headalldatesdataframe$Day <- format(as.Date(headalldatesdataframe[["Date"]], "%A"))

headalldatesdataframe
