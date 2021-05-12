library(tidyverse)


# 7章 tibbleのtibble --------------------------------------------------------



as_tibble(iris)

tibble(
  x = 1:5,
  y = 1,
  z = x ^ 2 + y
)

tb <- tibble(
  `:)` = "smile",
  ` ` = "space",
  `2000` = "number"
)
tb

tribble(
  ~x, ~y, ~z, 
  # -- | -- | -- 
  "a", 2, 3.6,
  "B", 1, 8.5
)

tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)
nycflights13::flights %>%
  print(n = 10, width = Inf)

# nycflights13::flights %>%
#   View()

df <- tibble(
  x = runif(5),
  y = rnorm(5)
)
df$x
df[["x"]]
df[[1]]
df %>% .$x
df %>% .[["x"]]

class(as.data.frame((tb)))

class(mtcars)
is_tibble(diamonds)

df <- data.frame(abc = 1, xyz = "a")
df
df$x
df[, "xyz"]
df[, c("abc", "xyz")]

dft <- tibble(
  abc = 1,
  xyz = "a"
)
dft$x
dft[, "xyz"]
dft[, c("abc", "xyz")]

mt_tbl <- as_tibble(mtcars)
var <- "mpg"
mtcars[[var]]
mt_tbl[[var]]

mtcars[, var]
mt_tbl[, var]

mtcars[["var"]]
mt_tbl[["var"]]
mtcars$var
mt_tbl$var

annoying <- tibble(
  `1` = 1:10, 
  `2` = `1` * 2 + rnorm(length(`1`))
)
annoying$`1`
annoying[[1]]

annoying %>%
  ggplot(aes(x = `1`, y = `2`))+
  geom_point()

annoying <- annoying %>%
  mutate(`3` = `2` / `1`) 

annoying[["3"]] <- annoying$`2` / annoying$`1`
annoying[["3"]] <- annoying[["2"]] / annoying[["1"]]
annoying %>%
  rename(one = `1`, two = `2`, three = `3`)

?tibble::enframe

tibble::enframe(c(x1 = 1,
          x2 = 2,
          x3 = 3))

print(nycflights13::flights)
print(nycflights13::flights, n_extra = 5)


# 8章 readrによるデータインポート -----------------------------------------------------

library(tidyverse)

heights <- read_csv("data/heights.csv")
heights

read_csv("a, b, c
         1, 2, 3
         4, 5, 6")

read_csv("The first line of metadata
         The second line of metadata
         x, y, z
         1, 2, 3", skip = 2)

read_csv("# A comment I want to skip
         x, y, z
         1, 2, 3", comment = "#")

read_csv("1, 2, 3 \n 4, 5, 6", col_names = FALSE)

read_csv("1, 2, 3 \n 4, 5, 6", col_names = c("x", "y", "z"))

read_csv("a, b, c \n 1, 2, .", na = ".")

?read_delim()

intersect(names(formals(read_csv)),
          names(formals(read_tsv)))

x <- "x,y\n1,'a,b'"
read_csv(x)
read_csv(x, quote = "'")

str(parse_logical(c("TRUE", "FALSE", "NA")))
str(parse_integer(c("1", "2", "3")))
str(parse_date(c("2010-01-01", "1979-10-14")))

parse_integer(c("1", "231", ".", "456"), na = ".")

x <- parse_integer(c("123", "345", "abc", "123.45"))
x
problems(x)

parse_double("1.23")
parse_double("1,23", locale = locale(decimal_mark = ","))

parse_number("$100")
parse_number("20%")
parse_number("It cost $123.45")

#米国
parse_number("$123,456,789")

#ヨーロッパ
parse_number(
  "123.456.789",
  locale = locale(grouping_mark = ".")
)

#スイス
parse_number(
  "123'456'789",
  locale = locale(grouping_mark = "'")
)

charToRaw("Hadley")

x1 <- "El Ni\xf1o was particularly bad this year"
x2 <- "\x82\xb1\x82\xf1\x82\xc9\x82\xbf\x82\xcd"
parse_character(x1, locale = locale(encoding = "Latin1"))
parse_character(x2, locale = locale(encoding = "Shift-JIS"))

guess_encoding(charToRaw(x1))
guess_encoding(charToRaw(x2))

fruit <- c("apple", "banana")
parse_factor(c("apple", "banana", "bananana"), levels = fruit)

parse_datetime("2010-10-01T2010")
# ISO-8601
# 時刻が省略されていると深夜に設定
parse_datetime("20101010")

parse_date("2010-10-01")

library(hms)
parse_time("01:10 am")
parse_time("20:10:01")

parse_date("01/02/15", "%m/%d/%y")
parse_date("01/02/15", "%d/%m/%y")
parse_date("01/02/15", "%y/%m/%d")

parse_date("1 janvier 2015", "%d %B %Y", locale = locale("fr"))

locale(decimal_mark = ".", grouping_mark = ".")

locale("ja")
parse_date("2019年6月18日", "%Y年 %m月 %d日", locale = locale("ja"))
parse_date("18日6月2019年", "%d日 %m月 %Y年", locale = locale("ja"))

jp_locale <- locale(date_format = "%Y年 %m月 %d日")
parse_date("2021年3月17日", locale = jp_locale)

d1 <- "January 1, 2010"
parse_date(d1, "%B %d, %Y")
d2 <- "2015-Mar-07"
parse_date(d2, "%Y-%b-%d")
d3 <- "06-Jun-2017"
parse_date(d3, "%d-%b-%Y")
d4 <- c("August 19 (2015)", "July 1 (2015)")
parse_date(d4, "%B %d (%Y)")
d5 <- "12/30/14" # Dec 30, 2014
parse_date(d5, "%m/%d/%y")
t1 <- "1705"
parse_time(t1, "%H%M")
t2 <- "11:15:10.12 PM"
parse_time(t2, "%H:%M:%OS %p")

guess_parser("2010-10-01")
guess_parser("15:01")
guess_parser(c("TRUE", "FALSE"))
guess_parser(c("1", "5", "9"))
guess_parser(c("12,352,561"))
str(parse_guess("2010-10-01"))

challenge <- read_csv(readr_example("challenge.csv"))
problems(challenge)
tail(challenge)

challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)
tail(challenge)

challenge2 <- read_csv(
  readr_example("challenge.csv"),
  guess_max = 1001
)

challenge2 <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(.defalut = col_character())
)

df <- tribble(
  ~x, ~y,
  "1", "1.21",
  "2", "2.32",
  "3", "4.56"
)
df
type_convert(df)

write_csv(challenge, "challenge.csv")
challenge
write_csv(challenge, "challenge-2.csv")
read_csv("challenge-2.csv")

# いじったデータの中間結果を保存するにはRDSを使う
write_rds(challenge, "challenge.rds")
read_rds("challenge.rds")

# featherで複数のプログラミング言語間で共有できる高速バイナリを実装
# install.packages("feather")
library(feather)
write_feather(challenge, "challenge.feather")
read_feather("challenge.feather")

# havenがSPSS，Stata，SASファイルを読み込む
# readxlががexcelファイル（.xlsと.xlsx）を読み込む
library(haven)
library(readxl)


# 9章 tidyrによるデータ整理 --------------------------------------------------------

library(tidyverse)
table1
table2
table3
table4a
table4b

# Each variable must have its own column.
# Each observation must have its own row.
# Each value must have its own cell.

# データセットはtibbleに置く
# 各変数は列に置く

#人口10000人あたりの率を計算
table1 %>%
  mutate(rate = cases / population * 10000)

#年ごとのケースを計算
table1 %>%
  count(year, wt = cases)

#経年変化を可視化
table1 %>%
  ggplot(aes(year, cases))+
  geom_line(aes(group = country), color = "grey50")+
  geom_point(aes(color = country))

t2_cases <- table2 %>%
  filter(type == "cases") %>%
  rename(cases = count) %>%
  arrange(country, year)

t2_pop <- table2 %>%
  filter(type == "population") %>%
  rename(population = count) %>%
  arrange(country, year)

t2_cases$population <- t2_pop[["population"]]
t2_cases %>%
  mutate(rate = cases / population * 10000)

table4a %>%
  inner_join(table4b, by = "country") %>%
  mutate(rate99 = `1999.x` / `1999.y` * 10000) %>%
  mutate(rate00 = `2000.x` / `2000.y` * 10000)
  
table2 %>%
  filter(type == "cases") %>%
  ggplot(aes(x = year, y = count))+
  geom_line(aes(group = country), color = "grey50")+
  geom_point(aes(color = country))

table4a

table4a %>%
  gather(`1999`, `2000`, key = "year", value = "cases")
  
table4a %>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")

table4b %>%
  gather(`1999`, `2000`, key = "year", value = "population")

table4b %>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "population")

tidy4a <- table4a %>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")

tidy4b <- table4b %>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "population")

left_join(tidy4a, tidy4b)

table2

spread(table2, key = type, value = count)

table2 %>%
  pivot_wider(names_from = type, values_from = count)

stocks <- tibble(
  year = c(2015, 2015, 2016, 2016),
  half = c( 1, 2, 1, 2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>%
  spread(year, return) %>%
  gather("year", "return", `2015`:`2016`)
stocks %>%
  pivot_wider(names_from = year, values_from = return) %>%
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

table4a %>%
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")

people <- tribble(
  ~name, ~key, ~value,
  #-----------------|--------|------
  "Phillip Woods", "age", 45,
  "Phillip Woods", "height", 186,
  "Phillip Woods", "age", 50,
  "Jessica Cordero", "age", 37,
  "Jessica Cordero", "height", 156
)
people %>%
  spread(key = key, value = value)

people %>%
  pivot_wider(names_from = name, values_from = value)

people %>%
  group_by(name, key) %>%
  mutate(id = row_number()) %>%
  spread(key = key, value = value, fill = NA)
  #pivot_wider(names_from = key, values_from = value)

preg <- tribble(
  ~name, ~male, ~female,
  "yes", NA, 10,
  "no", 20, 12
)
preg %>%
  #gather(male, female, key = "sex", value = "count")
  pivot_longer(c(male, female), names_to = "sex", values_to = "count")

table3
table5

table3 %>%
  separate(rate, into = c("cases", "population"))

table3 %>%
  separate(rate, into = c("cases", "population"), sep = "/")

#convert = TRUEで列の型を自動で変更
table3 %>%
  separate(
    rate, 
    into = c("cases", "population"),
    convert = TRUE
  )

table3 %>%
  separate(
    year,
    into = c("century", "year"),
    sep = 2
  )

table5 %>%
  unite(new, century, year)

table5 %>%
  unite(new, century, year, sep = "")

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"), fill = "left")

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>%
  separate(x, c("one", "two", "three"), remove = FALSE)

?extract

stocks <- tibble(
  year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016), 
  qtr = c(1, 2, 3, 4, 2, 3, 4),
  return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
)
stocks

# 暗黙値を明示的にする

stocks %>%
  spread(year, return)
stocks %>%
  pivot_wider(names_from = year, values_from = return)

stocks %>%
  spread(year, return) %>%
  gather(year, return, `2015`:`2016`, na.rm = TRUE)

stocks %>%
  pivot_wider(names_from = year, values_from = return) %>%
  pivot_longer(
    cols = c(`2015`:`2016`),
    names_to = "year",
    values_to = "return", 
    values_drop_na = TRUE
  )

stocks %>%
  complete(year, qtr)

treatment <- tribble(
  ~person, ~treatment, ~response,
  "Derrick Whitmore", 1, 7,
  NA, 2, 10,
  NA, 3, 9, 
  "Katherine Burke", 1, 4
)
treatment %>%
  fill(person)

?spread
?pivot_wider

tibble(group = c(1:2, 1),
       id = c(1:2, 2),
       val1 = 1:3,
       val2 = 1:3) %>%
  complete(group, id, 
           fill = list(val1 = 100, val2 = 1000))

?fill

tibble(Month = c(rep(1:3, 2), 1),
       Year = c(2000, rep(NA, 2), 2001, rep(NA, 2), 2002)) %>%
  fill(Year, .direction = "up")

tibble(Month = c(rep(1:3, 2), 1),
       Year = c(2000, rep(NA, 2), 2001, rep(NA, 2), 2002)) %>%
  fill(Year, .direction = "down")

who
# country, iso2, iso3の3変数を使った国指定は冗長
# yearは明らかに変数
# 変数名の構造から(new_sp_014とか) から実は変数ではなく値

# 変数でない列を集める
who1 <- who %>%
  pivot_longer(
    cols = new_sp_m014:newrel_f65, 
    names_to = "key", 
    values_to = "cases", 
    values_drop_na = TRUE)

who1 %>% 
  count(key)

who2 <- who1 %>%
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2

who3 <- who2 %>%
  separate(key, c("new", "type", "sexage"), sep = "_")
who3

who3 %>%
  count(new)

who4 <- who3 %>%
  select(-new, -iso2, -iso3)

who5 <- who4 %>%
  separate(sexage, c("sex", "age"), sep = 1)
who5

who %>%
  pivot_longer(
    cols = new_sp_m014:newrel_f65, 
    names_to = "key", 
    values_to = "cases", 
    values_drop_na = TRUE) %>%
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) %>%
  separate(key, c("new", "type", "sexage"), sep = "_") %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep = 1)


nrow(who)
who %>%
  complete(country, year) %>%
  nrow()

who %>%
  select(country, year) %>%
  complete(country, year) %>%
  anti_join(who, by = c("country", "year")) %>%
  select(country, year) %>%
  group_by(country) %>%
  summarise(min_year = min(year),
            max_year = max(year), 
            cut = n())

# who2
# who1 %>%
#   separate(key, c("new", "type", "sexage"), sep = "_")

who3 %>%
  select(iso2, iso3) %>%
  distinct() %>%
  dim()

who3 %>%
  select(country, iso2, iso3) %>%
  distinct() %>%
  dim()

who_tidy <- who %>%
  pivot_longer(
    cols = new_sp_m014:newrel_f65, 
    names_to = "key", 
    values_to = "cases", 
    values_drop_na = TRUE) %>%
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) %>%
  separate(key, c("new", "type", "sexage"), sep = "_") %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep = 1)

who_tidy
who_tidy %>%
  filter(year > 1995) %>%
  group_by(country, year, sex) %>%
  summarise(n = n(), cases = sum(cases)) %>%
  unite(country_sex, country, sex, remove = FALSE) %>%
  ggplot(aes(x = year, y = cases, group = country_sex, color = sex))+
  geom_line()

top10 <- who_tidy %>%
  filter(year > 1995) %>%
  group_by(country, year, sex) %>%
  summarise(ttl = sum(cases)) %>%
  top_n(10, ttl) %>%
  pull(country)

who5 %>%
  select(country, year, cases) %>%
  filter(year > 1995) %>%
  filter(country %in% top10) %>%
  group_by(country, year) %>%
  summarise(cases = sum(cases)) %>%
  mutate(year = lubridate::ymd(paste(year, "/01/01"))) %>%
  ggplot(aes(x = year, y = cases, color = country, group = country))+
  geom_line()+
  theme(legend.position = "none")


# 10章 dplyrによる関係データ -------------------------------------------------------
library(tidyverse)
library(nycflights13)

airlines
airports
planes
weather
flights

flights %>%
  select(origin, dest) %>% 
  inner_join(airports %>% 
               select(origin = faa, origin_lat = lat, origin_lon = lon),
             by = "origin") %>%
  inner_join(airports %>% select(dest = faa, dest_lat = lat, dest_lon = lon),
             by = "dest") %>%
  slice(1:100) %>%
  ggplot(.) +
  borders("state") +
  geom_segment(aes(
    x = origin_lon, xend = dest_lon,
    y = origin_lat, yend = dest_lat),
    arrow = arrow(length = unit(0.3, "cm"))) +
  coord_quickmap() +
  labs(y = "Latitude", x = "Longitude")

planes %>%
  count(tailnum) %>%
  filter(n > 1)

weather %>%
  count(year, month, day, hour, origin) %>%
  filter(n > 1)

flights %>%
  count(year, month, day, flight) %>%
  filter(n > 1)

flights %>%
  count(year, month, day, tailnum) %>%
  filter(n > 1)


flights %>%
  arrange(year, month, day, sched_dep_time, carrier, flight) %>%
  mutate(id = row_number()) %>%
  select(id, everything()) %>%
  head()

Lahman::Batting %>%
  count(playerID, yearID, stint) %>%
  filter(n > 1)

# install.packages("babynames")
babynames::babynames %>%
  count(year, sex, name) %>%
  filter(n > 1)

# install.packages("nasaweather")
nasaweather::atmos %>%
  count(lat, long, year, month) %>%
  filter(n > 1)

# install.packages("fueleconomy")
fueleconomy::vehicles %>%
  count(id) %>%
  filter(n > 1)

Lahman::Master %>% 
  count(playerID) %>%
  filter(n > 1)

Lahman::Batting %>% 
  count(playerID, yearID, stint) %>%
  filter(n > 1)

Lahman::Salaries %>% 
  count(playerID, yearID, teamID) %>%
  filter(n > 1)

flights2 <- flights %>%
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2

flights2 %>%
  select(-origin, -dest) %>%
  left_join(airlines, by = "carrier")

flights2 %>%
  select(-origin, -dest) %>%
  mutate(name = airlines$name[match(carrier, airlines$carrier)])

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)
x
y <- tribble(
  ~key, ~val_x,
  1, "y1",
  2, "y2",
  4, "y3"
)
y

x %>%
  inner_join(y, by = "key")

# left_joinがデフォルト

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  1, "x4",
)
x

y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2"
)
y

left_join(x, y, by = "key")

x <- tribble(
  ~key, ~val_x,
  1, "x1", 
  2, "x2", 
  2, "x3", 
  3, "x4", 
)
x

y <- tribble(
  ~key, ~val_y, 
  1, "y1", 
  2, "y2", 
  2, "y3", 
  3, "y4", 
  
)
y

left_join(x, y, by = "key")

# デフォルトの by = NULL は両方の表に現れる全ての変数を使ってjoin
# 自然joinと呼ばれる

flights2 %>%
  left_join(weather)

flights2 %>%
  left_join(planes, by = "tailnum")

flights2 %>%
  left_join(airports, by = c("dest" = "faa"))

flights2 %>%
  left_join(airports, by = c("origin" = "faa"))

airports %>%
  semi_join(flights, c("faa" = "dest")) %>%
  ggplot(aes(lon, lat))+
  borders("state")+
  geom_point()+
  coord_quickmap()

flights %>%
  group_by(dest) %>%
  summarise(delay = mean(arr_delay, na.rm = TRUE)) %>%
  inner_join(airports, by = c(dest = "faa")) %>%
  ggplot(aes(lon, lat, color = delay))+
  borders("state")+
  geom_point()+
  coord_quickmap()

flights %>%
  select(origin, dest) %>%
  left_join(airports %>%
              select(faa, lat, lon),
            by = c("origin" = "faa")
            ) %>%
  left_join(airports %>%
              select(faa, lat, lon),
            by = c("dest" = "faa"))

flights %>%
  select(origin, dest) %>%
  left_join(airports %>%
              select(faa, lat, lon),
            by = c("origin" = "faa")
  ) %>%
  left_join(airports %>%
              select(faa, lat, lon),
            by = c("dest" = "faa"),
            suffix = c("_origin", "_dest"))

flights %>%
  select(year, tailnum, arr_delay, dep_delay) %>%
  inner_join(planes %>%
               select(tailnum, plane_year = year),
             by = "tailnum") %>%
  mutate(age = year - plane_year) %>%
  filter(!is.na(age)) %>%
  mutate(age = pmin(25, age)) %>%
  group_by(age) %>%
  summarise(
    dep_delay_mean = mean(dep_delay, na.rm = TRUE)
  ) %>% 
  ggplot(aes(age, dep_delay_mean))+
  geom_point()+
  geom_smooth(method = "loess")+
  scale_x_continuous("Age of plane(years)",
                    breaks = seq(0, 50, by = 10))+
  scale_y_continuous("Mean Departure Delay(min)")

flights %>%
  select(origin, year, month, day, hour, dep_delay) %>%
  inner_join(weather, by = c(
    "origin" = "origin",
    "year" = "year",
    "month" ="month",
    "day" = "day",
    "hour" = "hour"
  )) %>%
  group_by(wind_speed) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_speed, y = delay))+
  geom_line()+
  geom_point()+
  geom_smooth(method = "loess")

flights %>%
  select(year, month, day, dest, arr_delay) %>%
  filter(year == 2013, month == 6, day == 13) %>%
  group_by(dest) %>%
  summarise(delay = mean(arr_delay, na.rm = TRUE)) %>%
  inner_join(airports, by = c("dest" = "faa")) %>% 
  ggplot(aes(y = lat, x = lon, size = delay, color = delay))+
  borders("state")+
  geom_point()+
  coord_quickmap()

top_dest <- flights %>%
  count(dest, sort = TRUE) %>%
  head(10)
top_dest

flights %>%
  filter(dest %in% top_dest$dest)

flights %>%
  semi_join(top_dest)

flights %>%
  anti_join(planes, by = "tailnum") %>%
  count(tailnum, sort = TRUE)

flights %>%
  anti_join(planes, by = "tailnum") %>%
  count(carrier, sort = TRUE)


flights %>%
  semi_join(
    flights %>%
      filter() %>%
      group_by(tailnum) %>%
      count() %>%
      filter(n >= 100),
    by = "tailnum"
  )

fueleconomy::vehicles %>%
  semi_join(fueleconomy::common, by = c("make", "model"))

weather %>%
  semi_join(
    flights %>%
      mutate(hour = sched_dep_time %/% 100) %>%
      group_by(origin, year, month, day, hour) %>%
      summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
      ungroup() %>%
      arrange(desc(dep_delay)) %>%
      slice(1:48),
    by = c("origin", "year",
           "month", "day", "hour")
  ) %>%
  ggplot(aes(x = precip, y = wind_speed, color = temp))+
  geom_point()

anti_join(flights, airports, by = c("dest" = "faa"))
anti_join(airports, flights, by = c("faa" = "dest"))

flights %>%
  filter(!is.na(tailnum)) %>%
  distinct(tailnum, carrier) %>%
  count(tailnum) %>%
  filter(n > 1)

flights %>%
  filter(!is.na(tailnum)) %>%
  distinct(tailnum, carrier) %>%
  group_by(tailnum) %>%
  filter(n() > 1) %>%
  left_join(airlines, by = "carrier") %>%
  arrange(tailnum, carrier)


airports %>%
  count(alt, lon) %>%
  filter(n > 1)

df1 <- tribble(
  ~x, ~y,
  1, 1,
  2, 1
)

df2 <- tribble(
  ~x, ~y,
  1, 1,
  1, 2
)
intersect(df1, df2)

union(df1, df2)

setdiff(df1, df2)

setdiff(df2, df1)

# 11章 stringrによる文字列 -------------------------------------------------------
library(tidyverse)
# library(stringr)

string1 <- "This is a string"
string2 <- 'To put a "quote" inside a string, use single quotes'

double_quote <- "\"" #または '"'
single_quote <- '\'' #または "'"

x <- c("\"", "\\")
x
writeLines(x)

x <- "\u00b5"
x

c("one", "two", "three")

str_length(c("a", "R for data science", NA))

str_c("x", "y")
str_c("x", "y", "z")

str_c("x", "y", sep = ", ")

x <- c("abc", NA)
str_c("|-", x , "-|")
str_c("|-", str_replace_na(x), "-|")

str_c("prefix-", c("a", "b", "c"), "-suffix")

name <- "Hadley"
time_of_date <- "morning"
birth_day <- FALSE
str_c(
  "Good ", time_of_date, " ", name, 
  if (birth_day) " and HAPPY BIRTHDAY", 
  ". "
)

str_c(c("x", "y", "z"), collapse = ", ")

x <- c("Apple", "Banana", "Pear")
str_sub(x, start = 1, end = 3)
str_sub(x, -3, -1)

str_sub("a", 1 , 5)

str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
x

str_to_upper(c("i", "ı"))
str_to_upper(c("i", "ı"), locale = "tr")

x <- c("apple", "eggplant", "banana")
str_sort(x, locale = "en")
str_sort(x, locale = "haw")

paste("hoge", "fuga", "piyo")
paste0("hoge", "fuga", "piyo")
str_c("hoge", "fuga", "piyo")

x <- c("hoge", "fuga", "piyo")
len <- str_length(x)
m <- ceiling(len / 2)
str_sub(x, m, m)

?str_wrap()
x <- str_c(
  "The Economist is an English-language weekly magazine-format newspaper owned by the Economist Group and edited at offices in London.",
  "Continuous publication began under its founder James Wilson in September 1843.",
  "In 2015, its average weekly circulation was a little over 1.5 million, about half of which were sold in the United States."
  
)
cat(str_wrap(x, width = 80))
x <- " hoge fuga piyo "
str_trim(x)
str_trim(x, side = "left")
str_trim(x , side = "right")

str_pad(x, 25, side = "both")
str_pad(x, 25, side = "right")
str_pad(x, 25, side = "left")

x <- c("a", "b", "c")
str_commasep <- function(x, delim = ",") {
  n <- length(x)
  if (n == 0) {
    ""
  } else if (n == 1) {
    x
  } else if (n == 2) {
    str_c(x[[1]], "and", x[[2]], sep = " ")
  } else {
    not_last <- str_c(x[seq_len(n - 1)], delim)
    last <- str_c("and", x[[n]], sep = " ")
    tmp <- str_c(c(not_last, last), collapse = " ")
    str_replace(tmp, ", and", " and")
  }
}
str_commasep(x)
str_commasep("")

x <- c("apple", "banana", "pear")
str_view(x, "an")
str_view(x, ".a.")

# 正規表現を作るには\\が必要
dot <- "\\."
# しかし，正規表現自体には1つしか含まれない
writeLines(dot)
# 明示的な.を探すようRに伝える
str_view(c("abc", "a.c", "bef"), "a\\.c")

x <- "a\\b"
writeLines(x)
str_view(x, "\\\\")

# "\": Rは次の文字をエスケープします
# "\\": 正規表現の\に解決され，正規表現の次の文字をエスケープします
# "\\\": 最初の2つのバックスラッシュは正規表現のリテラルバックスラッシュに
#   解決され，3番目のバックスラッシュは次の文字をエスケープします。正規表現では，
#   これはエスケープ文字をエスケープします

str_view("\"'\\", "\"'\\\\", match = TRUE)

str_view(c(".a.b.c", ".a.b", "......"), c("\\..\\..\\.."))

x <- c("apple", "banana", "pear")
str_view(x, "^a")
str_view(x, "a$")
# パワー(^)からはじめれば，ダラー($)で終わる。

x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")
str_view(x, "^apple$")


str_view("$^$", "^\\$\\^\\$$")

str_view(stringr::words, "^y", match = TRUE)
str_view(stringr::words, "x$", match = TRUE)
str_view(stringr::words, "^...$", match = TRUE)
str_view(stringr::words, ".......", match = TRUE)

# \dはどの数字ともマッチする
# \sはどの空白文字（空白，タブ，改行）ともマッチする
# [abc]はa, b, cのどれかとマッチする
# [^abc] はa, b, c以外ならどの文字ともマッチする
# 候補指定(|)

str_view(c("grey", "gray"), "gr(e|a)y")

str_view(stringr::words, "^[aiueo]", match = TRUE)
str_view(stringr::words, "^[^aiueo]+$", match = TRUE)
str_view(stringr::words, "^ed$|[^e]ed$", match = TRUE) #よくわからん？
str_view(stringr::words, "i(ng|ze)$", match = TRUE)

str_view(stringr::words, "(cei|[^c]ie)", match = TRUE)

str_view(stringr::words, "q[^u]", match = TRUE)

str_view("123-4567-8910", "\\d\\d\\d-\\d\\d\\d\\d-\\d\\d\\d\\d")

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")
str_view(x, "CC+")
str_view(x, "C[LX]+")

# {n}：きっちりn回
# {n,}：n回以上
# {,m}：高々m回
# {n,m}：nからm回

str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "C{2,3}")
str_view(x, "C{2,3}?")
str_view(x, "C[LX]+?")

str_view(stringr::words, "^.*$", match = TRUE)
str_view(stringr::words, "\\{.+\\}", match = TRUE)
str_view(stringr::words, "\\d{4}-\\d{2}-\\d{2}", match = TRUE)
str_view(stringr::words, "\\\\{4}", match = TRUE)

str_view(stringr::words, "^[^aiueo]{3}", match = TRUE)
str_view(stringr::words, "[aiueo]{3,}", match = TRUE)
str_view(stringr::words, "([aiueo][^aiueo]){2,}", match = TRUE)

str_view(fruit, "(..)\\1", match = TRUE)

str_view(stringr::words, "^(.)((.*\\1$)|\\1$)", match = TRUE)
str_view(stringr::words, "([A-Za-z][A-Za-z]).*\\1", match = TRUE)
str_view(stringr::words, "([a-z]).*\\1.*\\1", match = TRUE)

x <- c("apple", "banana", "pear")
str_detect(x, "e")

sum(str_detect(words, "^t"))
mean(str_detect(words, "[aiueo]$"))

# 母音を含まない単語
no_vowels_1 <- !str_detect(words, "[aiueo]")
no_vowels_2 <- str_detect(words, "^[^aiueo]+$")
identical(no_vowels_1, no_vowels_2)

words[str_detect(words, "x$")]
str_subset(words, "x$")

df <- tibble(
  word = words,
  i = seq_along(word)
)
df %>%
  filter(str_detect(words, "x$"))

x <- c("apple", "banana", "pear")
str_count(x, "a")
mean(str_count(words, "[aiueo]"))

df %>%
  mutate(
    vowels = str_count(word, "[aiueo]"), 
    consonants = str_count(word, "[^aiueo]")
  )

str_count("abababa", "aba")
str_view_all("abababa", "aba")

words[str_detect(stringr::words, "^x|x$")]
words[str_detect(stringr::words, "^x") | str_detect(stringr::words, "x$")]

words[str_detect(stringr::words, "^[aiueo].*[^aiueo]$")]
str_subset(stringr::words, "^[aiueo].*[^aiueo]$")
words[str_detect(stringr::words, "^[aiueo]") & str_detect(stringr::words, "[^aiueo]$")]

vowels <- str_count(words, "[aeiou]")
words[vowels == max(vowels)]

prop_vowels <- str_count(words, "[aeiou]") / str_length(words)
words[prop_vowels == max(prop_vowels)]

length(sentences)
head(sentences)
colors <- c(
  "red", "orange", "yellow", "green", "blue", "purple"
)
color_match <- str_c(colors, collapse = "|")
color_match

has_color <- str_subset(sentences, color_match)
has_color
matches <- str_extract(has_color, color_match)
head(matches)

more <- sentences[str_count(sentences, color_match) > 1]
str_view_all(more, color_match)
str_extract(more, color_match)

str_extract_all(more, color_match)
str_extract_all(more, color_match, simplify = TRUE)

x <- c("a", "a b", "a b c")
str_extract_all(x, "[a-z]", simplify = TRUE)

colors <- c(
  "red", "orange", "yellow", "green", "blue", "purple"
)
color_match <- str_c(colors, collapse = "|")
color_match
color_match2 <- str_c("\\b(", color_match, ")\\b")
color_match2
more2 <- sentences[str_count(sentences, color_match) > 1]
str_view_all(more2, color_match2, match = TRUE)

str_extract(sentences, "[a-zA-Z]+") %>% head()
str_extract(sentences, "\\b[A-Za-z]+ing\\b")

noun <- "(a|the) ([^ ]+)"

has_noun <- sentences %>%
  str_subset(noun) %>%
  head()

has_noun %>%
  str_extract(noun)

has_noun %>%
  str_match(noun)

tibble(sentence = sentences) %>%
  tidyr::extract(
    sentence, c("article", "noun"), "(a|the) ([^ ]+)", 
    remove = FALSE
  )

numword <- "(one|two|three|four|five|six|seven|eight|nine|ten) +(\\S+)"
sentences[str_detect(sentences, numword)] %>%
  str_extract(numword)

contraction <- "([A-Za-z]+)'([A-Za-z]+)"
sentences[str_detect(sentences, contraction)] %>%
  str_extract(contraction)

x <- c("apple", "pear", "banana")
str_replace(x, "[aiueo]", "-")
str_replace_all(x, "[aiueo]", "-")

x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))

sentences %>%
  str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") %>%
  head(5)

str_replace_all("past/present/future", "/", "\\\\")

str_replace_all(words, "^([A-Za-z])(.*)([a-z])$", "\\3\\2\\1")

sentences %>%
  head(5) %>%
  str_split(" ")

"a|b|c|d" %>%
  str_split("\\|") %>%
  .[[1]]

sentences %>%
  head(5) %>%
  str_split(" ", simplify = TRUE)

fields <- c("Name: Hadley", "Country: NZ", "Age: 35")
fields %>%
  str_split(": ", n = 2, simplify = TRUE)

x <- "This is a sentence. This is another sentence."
str_view_all(x, boundary("word"))
str_split(x, " ")

x <- c("apples, pears, and bananas")
str_split(x, ", +(and+)?")[[1]]

sentence <- "The quick ('brown') fox can't jump 32.3 feet, right?"
str_split(sentence, " ")
str_split(sentence, boundary("word"))

str_split(sentence, "")

str_view(fruit, "nana")
str_view(fruit, regex("nana"))

bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, "banana")
str_view(bananas, regex("banana", ignore_case = TRUE))

x <- "Line 1\nLine 2\nLine 3"
str_extract_all(x, "^Line")[[1]]
str_extract_all(x, regex("^Line", multiline = TRUE))[[1]]

phone <- regex("
  \\(?     # オプションの開き括弧
  (\\d{3}) # エリア番号
  [) -]?   # オプションの閉じ括弧，ダッシュ，空白
  (\\d{3}) # 3桁の番号
  [ -]?    # オプションの空白かダッシュ
  (\\d{3}) # 3桁の番号
  ", comments = TRUE)

str_match("514-791-8141", phone)

microbenchmark::microbenchmark(
  fixed = str_detect(sentences, fixed("the")),
  regex = str_detect(sentences, "the"),
  times = 20
)

a1 <- "\u00e1"
a2 <- "a\u0301"
c(a1, a2)
a1 == a2
str_detect(a1, fixed(a2))
str_detect(a1, coll(a2))

i <- c("I", "İ", "i", "ı")
i
str_subset(i, coll("i", ignore_case = TRUE))
str_subset(i,
           coll("i", ignore_case = TRUE, locale = "tr")
           )

stringi::stri_locale_info()

x <- "This is a sentence."
str_view_all(x, boundary("word"))
str_extract_all(x, boundary("word"))[[1]]

str_subset(c("a\\b", "ab"), "\\\\")
str_subset(c("a\\b", "ab"), fixed("\\"))

tibble(word = unlist(str_extract_all(sentences, boundary("word")))) %>%
  mutate(word = str_to_lower(word)) %>%
  count(word, sort = TRUE) %>%
  head(5)

apropos("replace")

head(dir(pattern = "\\.Rmd$"))

stringi::stri_count_words(head(sentences))
stringi::stri_duplicated(c(
  "the", "brown", "cow", "jumped", "over",
  "the", "lazy", "fox"
))
stringi::stri_rand_strings(4, 5)
