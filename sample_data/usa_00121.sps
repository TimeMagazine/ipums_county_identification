* NOTE: You need to edit the `cd` command to specify the path to the directory
* where the data file is located. For example: "C:\ipums_directory".
* .

cd ".".

data list file = "usa_00121.dat" /
  YEAR        1-4
  DATANUM     5-6
  SERIAL      7-14
  HHWT        15-24 (2)
  STATEFIP    25-26
  COUNTYFIPS  27-29
  GQ          30-30
.

variable labels
  YEAR          "Census year"
  DATANUM       "Data set number"
  SERIAL        "Household serial number"
  HHWT          "Household weight"
  STATEFIP      "State (FIPS code)"
  COUNTYFIPS    "County (FIPS code)"
  GQ            "Group quarters status"
.

value labels
  /YEAR
    1850   "1850"
    1860   "1860"
    1870   "1870"
    1880   "1880"
    1900   "1900"
    1910   "1910"
    1920   "1920"
    1930   "1930"
    1940   "1940"
    1950   "1950"
    1960   "1960"
    1970   "1970"
    1980   "1980"
    1990   "1990"
    2000   "2000"
    2001   "2001"
    2002   "2002"
    2003   "2003"
    2004   "2004"
    2005   "2005"
    2006   "2006"
    2007   "2007"
    2008   "2008"
    2009   "2009"
    2010   "2010"
    2011   "2011"
    2012   "2012"
    2013   "2013"
    2014   "2014"
    2015   "2015"
  /STATEFIP
    01   "Alabama"
    02   "Alaska"
    04   "Arizona"
    05   "Arkansas"
    06   "California"
    08   "Colorado"
    09   "Connecticut"
    10   "Delaware"
    11   "District of Columbia"
    12   "Florida"
    13   "Georgia"
    15   "Hawaii"
    16   "Idaho"
    17   "Illinois"
    18   "Indiana"
    19   "Iowa"
    20   "Kansas"
    21   "Kentucky"
    22   "Louisiana"
    23   "Maine"
    24   "Maryland"
    25   "Massachusetts"
    26   "Michigan"
    27   "Minnesota"
    28   "Mississippi"
    29   "Missouri"
    30   "Montana"
    31   "Nebraska"
    32   "Nevada"
    33   "New Hampshire"
    34   "New Jersey"
    35   "New Mexico"
    36   "New York"
    37   "North Carolina"
    38   "North Dakota"
    39   "Ohio"
    40   "Oklahoma"
    41   "Oregon"
    42   "Pennsylvania"
    44   "Rhode Island"
    45   "South Carolina"
    46   "South Dakota"
    47   "Tennessee"
    48   "Texas"
    49   "Utah"
    50   "Vermont"
    51   "Virginia"
    53   "Washington"
    54   "West Virginia"
    55   "Wisconsin"
    56   "Wyoming"
    61   "Maine-New Hampshire-Vermont"
    62   "Massachusetts-Rhode Island"
    63   "Minnesota-Iowa-Missouri-Kansas-Nebraska-S.Dakota-N.Dakota"
    64   "Maryland-Delaware"
    65   "Montana-Idaho-Wyoming"
    66   "Utah-Nevada"
    67   "Arizona-New Mexico"
    68   "Alaska-Hawaii"
    72   "Puerto Rico"
    97   "Military/Mil. Reservation"
    99   "State not identified"
  /GQ
    0   "Vacant unit"
    1   "Households under 1970 definition"
    2   "Additional households under 1990 definition"
    3   "Group quarters--Institutions"
    4   "Other group quarters"
    5   "Additional households under 2000 definition"
    6   "Fragment"
.

execute.

