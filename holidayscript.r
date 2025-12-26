## Public and statutory holidays in New Zealand

### filter the dates series obtained from Python 'import holidays' package

# NB the holidays date series from Python does not include New Zealand regional anniversary days

# load 'poorman' library if needed to select columns from a dataframe
# library(poorman)

# read in data 1894 to 2026 from the Python Holiday package as saved in a local folder

holidays <- read.csv("new_zealand_holidays.csv" , skip=0, header=TRUE, sep=",", colClasses = c("Date","character"),na.strings='NA', dec=".", strip.white=TRUE)

# remove apostrophes in names of holidays
holidays[["Holiday.Name"]] <- gsub("'", "", holidays[["Holiday.Name"]])

# check the structure of the holidays dataframe
str(holidays)
'data.frame':	1370 obs. of  2 variables:
 $ Date        : Date, format: "1894-01-01" "1894-01-02" ...
 $ Holiday.Name: chr  "New Years Day" "Day after New Years Day" "Good Friday" "Easter Monday" ...

# create a copy
holidaysanddaysofweek <- holidays

# add day of week
holidaysanddaysofweek$Day <- format(as.Date(holidaysanddaysofweek$Date), "%A")

# check 2025 holidays
holidaysanddaysofweek[1347:1357,]
           Date            Holiday.Name       Day
1347 2025-01-01           New Years Day Wednesday
1348 2025-01-02 Day after New Years Day  Thursday
1349 2025-02-06            Waitangi Day  Thursday
1350 2025-04-18             Good Friday    Friday
1351 2025-04-21           Easter Monday    Monday
1352 2025-04-25               Anzac Day    Friday
1353 2025-06-02          Kings Birthday    Monday
1354 2025-06-20                Matariki    Friday
1355 2025-10-27              Labour Day    Monday
1356 2025-12-25           Christmas Day  Thursday
1357 2025-12-26              Boxing Day    Friday

# check 2026 holidays
tail(holidaysanddaysofweek,12)

# write the dates that are holidays to a .csv file
write.table(holidaysanddaysofweek, file = "holidaysanddaysofweek.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

# there are no regional anniversary holidays in the Python package!

## How many days of dates should be included if there were all dates from first record in 1894 to 1 January 2027

alldates <- seq.Date(min(holidays$Date), max(holidays$Date), "day")

# how many dates is that?
length(alldates)
[1] 48574
str(alldates)
Date[1:48574], format: "1894-01-01" "1894-01-02" "1894-01-03" "1894-01-04" "1894-01-05" ...

# create a dataframe of "all the dates" or 'x' including business days added as NA
alldatesdataframe <- merge(x= data.frame(Date = alldates),  y = holidays,  all.x=TRUE)

str(alldatesdataframe)
'data.frame':	48574 obs. of  2 variables:
 $ Date        : Date, format: "1894-01-01" "1894-01-02" ...
 $ Holiday.Name: chr  "New Years Day" "Day after New Years Day" NA NA ...

head(alldatesdataframe)


## change NA to non holiday

# For a data frame column that includes NA

#df$column_name[is.na(df$column_name)] <- "replacement_string"

alldatesdataframe[["Holiday.Name"]][is.na(alldatesdataframe[["Holiday.Name"]])] <- "Non-Holiday"

head(alldatesdataframe[["Holiday.Name"]])
[1] "New Years Day"           "Day after New Years Day"
[3] "Non.Holiday"             "Non.Holiday"
[5] "Non.Holiday"             "Non.Holiday"

# add the day of the week
alldatesdataframe$Day <- format(as.Date(alldatesdataframe$Date), "%A")

# move the day of week column to second column and holiday name to third column
alldatesdataframe <-  alldatesdataframe[,c(1,3,2)]

# check structure
str(alldatesdataframe)
'data.frame':	48574 obs. of  3 variables:
 $ Date        : Date, format: "1894-01-01" "1894-01-02" ...
 $ Day         : chr  "Monday" "Tuesday" "Wednesday" "Thursday" ...
 $ Holiday.Name: chr  "New Years Day" "Day after New Years Day" "Non-Holiday" "Non-Holiday" ...

# look at first six rows
head(alldatesdataframe)
        Date       Day            Holiday.Name
1 1894-01-01    Monday           New Years Day
2 1894-01-02   Tuesday Day after New Years Day
3 1894-01-03 Wednesday             Non-Holiday
4 1894-01-04  Thursday             Non-Holiday
5 1894-01-05    Friday             Non-Holiday
6 1894-01-06  Saturday             Non-Holiday

# create a better named copy
NZholidaysandotherdays1894_2026 <- alldatesdataframe

# write the dates of business days and holidays to a .csv file
write.table(NZholidaysandotherdays1894_2026, file = "NZholidaysandotherdays1894_2026.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)

headalldatesdataframe <- head(alldatesdataframe)

# Add the 'weekend' column using ifelse
headalldatesdataframe$Weekend <- ifelse(headalldatesdataframe$Day == "Saturday" | headalldatesdataframe$Day == "Sunday", "weekend", "weekday")

headalldatesdataframe
        Date       Day            Holiday.Name Weekend
1 1894-01-01    Monday           New Years Day weekday
2 1894-01-02   Tuesday Day after New Years Day weekday
3 1894-01-03 Wednesday            Business Day weekday
4 1894-01-04  Thursday            Business Day weekday
5 1894-01-05    Friday            Business Day weekday
6 1894-01-06  Saturday            Business Day weekend

weekdays(headalldatesdataframe[["Date"]])
[1] "Monday"    "Tuesday"   "Wednesday" "Thursday"  "Friday"    "Saturday"

# Example data frame
df_base <- data.frame(
  dates = seq(as.Date("2025-01-01"), as.Date("2025-01-10"), by = "days"),
  day_of_week_col = weekdays(seq(as.Date("2025-01-01"), as.Date("2025-01-10"), by = "days"))
)
str(df_base)
'data.frame':	10 obs. of  2 variables:
 $ dates          : Date, format: "2025-01-01" "2025-01-02" ...
 $ day_of_week_col: chr  "Wednesday" "Thursday" "Friday" "Saturday" ...

# Add the 'weekend' column using ifelse
df_base$weekend <- ifelse(df_base$day_of_week_col == "Saturday" | df_base$day_of_week_col == "Sunday", "weekend", "weekday")

df_base
        dates day_of_week_col weekend
1  2025-01-01       Wednesday weekday
2  2025-01-02        Thursday weekday
3  2025-01-03          Friday weekday
4  2025-01-04        Saturday weekend
5  2025-01-05          Sunday weekend
6  2025-01-06          Monday weekday
7  2025-01-07         Tuesday weekday
8  2025-01-08       Wednesday weekday
9  2025-01-09        Thursday weekday
10 2025-01-10          Friday weekday

# To identify only Saturday:
# df_base$weekend <- ifelse(df_base$day_of_week_col == "Saturday", "Saturday", "not Saturday")


# View the updated data frame
print(df_base)



48554 - 365

# lest's check 24 Dec 2025 to 20 Jan 2026
alldatesdataframe[48205:48232,]

# 20 Jan is Wellington Anniversary day and it is not identified.

spotpricesinfilled <- read.csv("~/R/nzu/nzu-fork-master/apipy/spotpricesinfilled.csv", colClasses = c("Date","numeric"))
tail(spotpricesinfilled,1)
           date price
3892 2025-12-08  39.3

spot prices date starts from 2010-05-14

# subset 2020 to 2025 holiday dates
holidays2010_2025 <- alldatesdataframe[alldatesdataframe$Date > as.Date("2010-05-13"),]
# subset 2020 to 2025 holiday dates
holidays2010_2025 <- holidays2010_2025[holidays2010_2025$Date < as.Date("2025-12-09"),]

# check dimensions
dim(holidays2010_2025)
[1] 5688    3

# check structure
str(holidays2010_2025)
'data.frame':	5688 obs. of  3 variables:
 $ Date        : Date, format: "2010-05-14" "2010-05-15" ...
 $ Day         : chr  "Friday" "Saturday" "Sunday" "Monday" ...
 $ Holiday.Name: chr  "Business Day" "Business Day" "Business Day" "Business Day" ...

# look at first 6 rows
head(holidays2010_2025)
            Date       Day Holiday.Name
42502 2010-05-14    Friday Business Day
42503 2010-05-15  Saturday Business Day
42504 2010-05-16    Sunday Business Day
42505 2010-05-17    Monday Business Day
42506 2010-05-18   Tuesday Business Day
42507 2010-05-19 Wednesday Business Day


tail(holidays2010_2025)
            Date       Day Holiday.Name
48184 2025-12-03 Wednesday Business Day
48185 2025-12-04  Thursday Business Day
48186 2025-12-05    Friday Business Day
48187 2025-12-06  Saturday Business Day
48188 2025-12-07    Sunday Business Day
48189 2025-12-08    Monday Business Day

# Where are the Saturdays ? use Logical indexing
idSat <- holidays2010_2025$Day == "Saturday"
idSat
[1] FALSE FALSE  TRUE FALSE ....
# 5000 + records

# leave out the Saturdays
holidays2010_2025 <- holidays2010_2025[!idSat, ]

# Where are the Sundays ? logical indexing
idSun <- holidays2010_2025$Day == "Sunday"
idSun

# leave out the Sundays
holidays2010_2025 <- holidays2010_2025[!idSun, ]

str(holidays2010_2025)
'data.frame':	4062 obs. of  3 variables:
 $ Date        : Date, format: "2010-05-14" "2010-05-17" ...
 $ Holiday.Name: chr  "Non.Holiday" "Non.Holiday" "Non.Holiday" "Non.Holiday" ...
 $ Day         : chr  "Friday" "Monday" "Tuesday" "Wednesday" ...

table(holidays2010_2025$Day)

   Friday    Monday  Thursday   Tuesday Wednesday
      813       813       812       812       812

table(holidays2010_2025[["Holiday.Name"]])

                         Anzac Day               Anzac Day (observed)
                                11                                  3
          Anzac Day; Easter Monday                         Boxing Day
                                 1                                 11
             Boxing Day (observed)                      Christmas Day
                                 4                                 10
          Christmas Day (observed)            Day after New Years Day
                                 5                                 11
Day after New Years Day (observed)                      Easter Monday
                                 4                                 14
                       Good Friday                     Kings Birthday
                                15                                  3
                        Labour Day                           Matariki
                                16                                  4
                     New Years Day           New Years Day (observed)
                                10                                  5
                       Non.Holiday    Queen Elizabeth II Memorial Day
                              3907                                  1
                   Queens Birthday                       Waitangi Day
                                13                                 11
           Waitangi Day (observed)
                                 3
# Where are the Sundays ? logical indexing
idBusiness <- holidays2010_2025[["Holiday.Name"]] == "Non.Holiday"


# leave out the holidays and select business days
holidays2010_2025 <- holidays2010_2025[idBusiness, ]

str(holidays2010_2025)
'data.frame':	3907 obs. of  3 variables:
 $ Date        : Date, format: "2010-05-14" "2010-05-17" ...
 $ Holiday.Name: chr  "Non.Holiday" "Non.Holiday" "Non.Holiday" "Non.Holiday" ...
 $ Day         : chr  "Friday" "Monday" "Tuesday" "Wednesday" ...

table(holidays2010_2025[["Holiday.Name"]])

Non.Holiday
       3907
 table(holidays2010_2025[["Holiday.Name"]])

Non.Holiday
       3907
table(holidays2010_2025[["Holiday.Name"]])

Non.Holiday
       3907
table(holidays2010_2025[["Day"]])

   Friday    Monday  Thursday   Tuesday Wednesday
      785       736       798       790       798

# write the dates that are business days to a .csv file
write.table(holidays2010_2025, file = "businessdays_2010_2025.csv", sep = ",", col.names = TRUE, qmethod = "double",row.names = FALSE)


https://www.employment.govt.nz/leave-and-holidays/public-holidays/previous-years-public-holidays-and-anniversary-dates
