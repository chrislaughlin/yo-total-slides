# Data summary

### Stop Location

[DimStopLocation]
(
	[StopLocationID] [int] NOT NULL,
	[StopNameShort] [varchar](100) NULL,
	[StopNameLong] [varchar](200) NULL,
	[StopType] [varchar](100) NULL,
	[SuburbName] [varchar](50) NULL,
	[PostCode] [smallint] NULL,
	[RegionName] [varchar](100) NULL,
	[LocalGovernmentArea] [varchar](100) NULL,
	[StatDivision] [varchar](30) NULL,
	[GPSLat] [decimal](18, 6) NULL,
	[GPSLong] [decimal](18, 6) NULL
)
### Stop locations sample
867|Weemala Court|Weemala Ct/Plenty River Dr (Greensborough)|Kerbside|Greensborough|3088|Melbourne|Banyule|Greater Metro|-37.689596|145.105088

### Scan on and Scan off transactions

#### Sample of scanontransaction:
2|2017-01-05|2017-01-05 23:52:21|7998580|2|0||1|64404
2|2017-01-06|2017-01-06 17:41:02|8785520|0|0||1|64404
2|2017-01-05|2017-01-05 11:31:51|7505670|9|0||1|64404
3|2017-01-06|2017-01-06 13:40:01|18585800|1|1946|Headless Mode|9062|24001
3|2017-01-02|2017-01-02 12:54:58|18702790|1|522|Headless Mode|9062|24097
3|2017-01-03|2017-01-03 12:12:20|16072050|1|670|Headless Mode|9062|24099

### Card_Subtype

[dim_Card_Subtype]
(
	[Card_SubType_ID] [smallint] NULL,
	[Card_SubType_Desc] [varchar](60) NULL,
	[Payment_Type] [varchar](4) NOT NULL,
	[Fare_Type] [varchar](10) NOT NULL,
	[Concession_Type] [varchar](21) NOT NULL,
	[MI_Card_Group] [varchar](255) NULL
)
### card_types example
62|Pensioner Concession Card holder PC|Paid|Concession|Other Concession|Other Concession

### Tram Date
[TramDateDimension]
(
       [Date]
      ,[CalendarYear]
      ,[FinancialYear]
      ,[FinancialMonth]
      ,[CalendarMonth]
      ,[CalendarMonthSeq]
      ,[CalendarQuarter]
      ,[FinancialQuarter]
      ,[CalendarWeek]
      ,[FinancialWeek]
      ,[DayType]
      ,[DayTypeCategory]
      ,[WeekdaySeq]
      ,[WeekDay]
      ,[FinancialMonthSeq]
      ,[FinancialMonthName]
      ,[MonthNumber]
      ,[ABSWeek]
      ,[WeekEnding]
      ,[QuarterName]
)

#### sample of calendar.txt
20170930|2017-09-30|2017|FY2017 - 2018|9|September|201709|2017Q3|FY17-18Q1|39|13|Saturday|Weekend|Saturday|6|Saturday|201709|Sep 17/|9|1239|w/e 2017-09-30|September Qtr. 2017
