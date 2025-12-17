## Public and statutory holidays in New Zealand

## filter the dates series obtained from Python 'import holidays' package

# read in data from Python Holiday package as saved in a local folder

holidays <- read.csv("new_zealand_holidays.csv" , skip=0, header=TRUE, sep=",", colClasses = c("Date","character"),na.strings='NA', dec=".", strip.white=TRUE)

# remove apostrophes in names of holidays
holidays[["Holiday.Name"]] <- gsub("'", "", holidays[["Holiday.Name"]])
# check holidays dataframe
str(holidays)
'data.frame':	1370 obs. of  2 variables:
 $ Date        : Date, format: "1894-01-01" "1894-01-02" ...
 $ Holiday.Name: chr  "New Years Day" "Day after New Years Day" "Good Friday" "Easter Monday" ...

# add day of week
#holidays$Day <- format(as.Date(holidays$Date), "%A")

# check 2025 holidays
holidays[1347:1357,]
           Date            Holiday.Name
1347 2025-01-01           New Years Day
1348 2025-01-02 Day after New Years Day
1349 2025-02-06            Waitangi Day
1350 2025-04-18             Good Friday
1351 2025-04-21           Easter Monday
1352 2025-04-25               Anzac Day
1353 2025-06-02          Kings Birthday
1354 2025-06-20                Matariki
1355 2025-10-27              Labour Day
1356 2025-12-25           Christmas Day
1357 2025-12-26              Boxing Day

# check 2026 holidays
tail(holidays,12)
           Date            Holiday.Name
1359 2026-01-02 Day after New Years Day
1360 2026-02-06            Waitangi Day
1361 2026-04-03             Good Friday
1362 2026-04-06           Easter Monday
1363 2026-04-25               Anzac Day
1364 2026-04-27    Anzac Day (observed)
1365 2026-06-01          Kings Birthday
1366 2026-07-10                Matariki
1367 2026-10-26              Labour Day
1368 2026-12-25           Christmas Day
1369 2026-12-26              Boxing Day
1370 2026-12-28   Boxing Day (observed)

# no regional anniversary holidays!

## How many days of dates should be included if there were all dates from first record in 1894 to 1 January 2027

alldates <- seq.Date(min(holidays$Date), max(holidays$Date), "day")
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

alldatesdataframe[["Holiday.Name"]][is.na(alldatesdataframe[["Holiday.Name"]])] <- "Non.Holiday"

head(alldatesdataframe[["Holiday.Name"]])
[1] "New Years Day"           "Day after New Years Day"
[3] "Non.Holiday"             "Non.Holiday"
[5] "Non.Holiday"             "Non.Holiday"

alldatesdataframe$Day <- format(as.Date(alldatesdataframe$Date), "%A")

head(alldatesdataframe)
        Date            Holiday.Name       Day
1 1894-01-01           New Years Day    Monday
2 1894-01-02 Day after New Years Day   Tuesday
3 1894-01-03             Non.Holiday Wednesday
4 1894-01-04             Non.Holiday  Thursday
5 1894-01-05             Non.Holiday    Friday
6 1894-01-06             Non.Holiday  Saturday

48554 - 365

# lest's check 24 Dec 2025 to 20 Jan 2026
alldatesdataframe[48205:48232,]
            Date            Holiday.Name       Day
48205 2025-12-24             Non.Holiday Wednesday
48206 2025-12-25           Christmas Day  Thursday
48207 2025-12-26              Boxing Day    Friday
48208 2025-12-27             Non.Holiday  Saturday
48209 2025-12-28             Non.Holiday    Sunday
48210 2025-12-29             Non.Holiday    Monday
48211 2025-12-30             Non.Holiday   Tuesday
48212 2025-12-31             Non.Holiday Wednesday
48213 2026-01-01           New Years Day  Thursday
48214 2026-01-02 Day after New Years Day    Friday
48215 2026-01-03             Non.Holiday  Saturday
48216 2026-01-04             Non.Holiday    Sunday
48217 2026-01-05             Non.Holiday    Monday
48218 2026-01-06             Non.Holiday   Tuesday
48219 2026-01-07             Non.Holiday Wednesday
48220 2026-01-08             Non.Holiday  Thursday
48221 2026-01-09             Non.Holiday    Friday
48222 2026-01-10             Non.Holiday  Saturday
48223 2026-01-11             Non.Holiday    Sunday
48224 2026-01-12             Non.Holiday    Monday
48225 2026-01-13             Non.Holiday   Tuesday
48226 2026-01-14             Non.Holiday Wednesday
48227 2026-01-15             Non.Holiday  Thursday
48228 2026-01-16             Non.Holiday    Friday
48229 2026-01-17             Non.Holiday  Saturday
48230 2026-01-18             Non.Holiday    Sunday
48231 2026-01-19             Non.Holiday    Monday
48232 2026-01-20             Non.Holiday   Tuesday
# 20 Jan is Wellington Anniversary day and it is not identified.

spotpricesinfilled <- read.csv("~/R/nzu/nzu-fork-master/apipy/spotpricesinfilled.csv", colClasses = c("Date","numeric"))
tail(spotpricesinfilled,1)
           date price
3892 2025-12-08  39.3

spot prices date starts from 2010-05-14

# subset 2024 and 2025 prices
holidays2010_2025 <- alldatesdataframe[alldatesdataframe$Date > as.Date("2010-05-13"),]

holidays2010_2025 <- holidays2010_2025[holidays2010_2025$Date < as.Date("2025-12-09"),]
dim(holidays2010_2025)
[1] 5688    3
str(holidays2010_2025)
'data.frame':	5688 obs. of  3 variables:
 $ Date        : Date, format: "2010-05-14" "2010-05-15" ...
 $ Holiday.Name: chr  "Non.Holiday" "Non.Holiday" "Non.Holiday" "Non.Holiday" ...
 $ Day         : chr  "Friday" "Saturday" "Sunday" "Monday" ...
head(holidays2010_2025)
            Date Holiday.Name       Day
42502 2010-05-14  Non.Holiday    Friday
42503 2010-05-15  Non.Holiday  Saturday
42504 2010-05-16  Non.Holiday    Sunday
42505 2010-05-17  Non.Holiday    Monday
42506 2010-05-18  Non.Holiday   Tuesday
42507 2010-05-19  Non.Holiday Wednesday
tail(holidays2010_2025)
            Date Holiday.Name       Day
48184 2025-12-03  Non.Holiday Wednesday
48185 2025-12-04  Non.Holiday  Thursday
48186 2025-12-05  Non.Holiday    Friday
48187 2025-12-06  Non.Holiday  Saturday
48188 2025-12-07  Non.Holiday    Sunday
48189 2025-12-08  Non.Holiday    Monday



#spot2024 <- spot[spot$date > as.Date("2024-01-01"),]

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
