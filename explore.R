library(tidyverse)



# 1章 ggplot2によるデータ可視化 -----------------------------------------------------
mpg

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

ggplot(data = mpg)
mpg
?mpg

ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cyl))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))
# ggplot2 will only use six shapes at a time.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")
?mpg
mpg

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = cyl))
# A continous variable can not be mapped to shape

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = displ))

?geom_point
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class, stroke = 5))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = displ))

ggplot(data = mpg) 
+ geom_point(mapping = aes(x = displ, y = hwy))


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = cyl))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

?facet_wrap

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
    )

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg, aes(x = displ, y = hwy))+
  geom_point()+
  geom_smooth()

ggplot(data = mpg, aes(x = displ, y = hwy))+
  geom_point(mapping = aes(color = class))+
  geom_smooth()

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(
    data = filter(mpg, class == "subcompact"),
    se = FALSE
  )

ggplot(mpg, aes(x = displ, y = hwy))+
  #geom_boxplot(aes(group = drv))
  geom_area()

ggplot(mpg, aes(x = displ))+
  geom_histogram()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv))+
  geom_point()+
  geom_smooth(se = FALSE)

ggplot(mpg, aes(x = displ, y = hwy))+
  geom_point()+
  geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy))+
  geom_point()+
  geom_smooth(aes(group = drv))

ggplot(mpg, aes(x = displ, y = hwy, color = drv))+
  geom_point()+
  geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy))+
  geom_point(aes(color = drv))+
  geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy, linetype = drv))+
  geom_point(aes(color = drv))+
  geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy, color = drv))+
  geom_point(shape = 21, fill = "white")
##??

diamonds
ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds)+
  stat_count(mapping = aes(x = cut))

demo <- tribble(
  ~a, ~b,
  "bar_1", 20,
  "bar_2", 30,
  "bar_3", 40
)
ggplot(data = demo)+
  geom_bar(
    mapping = aes(x = a, y = b), stat = "identity"
  )

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

ggplot(data = diamonds)+
  geom_bar(
    mapping = aes(x = cut, y = ..prop.., group = 1)
  )

ggplot(data = diamonds)+
  geom_bar(
    mapping = aes(x = cut, y = stat(prop), group = 1)
  )


ggplot(data = diamonds)+
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

ggplot(data = diamonds)+
  geom_linerange(mapping = aes(x = cut, y = depth, ymin = depth, ymax = depth))

?geom_col
?stat_smooth

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop.., group = 1))

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut, color = cut))

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(
  data = diamonds,
  mapping = aes(x = cut, fill = clarity)
  )+
  geom_bar(alpha = 1/5, position = "identity")

ggplot(
  data = diamonds,
  mapping = aes(x = cut, color = clarity)
)+
  geom_bar(fill = NA, position = "identity")

ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = clarity),
    position = "fill"
  )

ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = clarity),
    position = "dodge"
  )

ggplot(data = mpg)+
  geom_point(
    mapping = aes(x = displ, y = hwy),
    position = "jitter"
  )

ggplot(data = mpg, mapping = aes(x = cty, y = hwy, color = drv))+
  geom_point(position = "jitter")+
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy))+
  geom_jitter()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy))+
  geom_count()

ggplot(data = mpg, aes(x = cty, group = drv))+
  geom_boxplot(position = "dodge2")

ggplot(data = mpg, mapping = aes(x = class, y = hwy))+
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy))+
  geom_boxplot()+
  coord_flip()

install.packages("maps")
library(maps)
nz <- map_data("nz")
head(nz)
ggplot(nz, aes(long, lat, group = group))+
  geom_polygon(fill = "white", color = "black")
ggplot(nz, aes(long, lat, group = group))+
  geom_polygon(fill = "white", color = "black")+
  coord_quickmap()

bar <- ggplot(data = diamonds)+
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  )+
  theme(aspect.ratio = 1)+
  labs(x = NULL, y = NULL)
bar + coord_flip()
bar + coord_polar()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy))+
  geom_point()+
  geom_abline()+
  coord_fixed()

# ggplot(data = <DATA>)+
#   <GEOM_FUNCTION>(
#     mapping = aes(<MAPPINGS>),
#     stat = <STAT>,
#     position = <POSITION>
#   )+
#   <COORDINATE_FUNCTION>+
#   <FACET_FUNCTION>


# 2章 ワークフロー：基本 ------------------------------------------------------------

1 / 2 * 30
(59 + 73 + 2) / 3
sin(pi / 2)

x <- 3 * 4

# object_name <- value

x
this_is_a_really_long_name <- 2.5

r_rocks <- 2 ^ 3
# r_rock
# R_rocks

seq(1, 10)

x <- "hello world"

y <- seq(1, 10, length.out = 5)
y
(y <- seq(1, 10, length.out = 5))

library(tidyverse)
ggplot(mpg)+
  geom_point(aes(x = displ, y = hwy))

filter(mpg, cyl == 8)
filter(diamond, carat > 3)


# 3章 dplyrによるデータ変換 --------------------------------------------------------
library(nycflights13)
flights
# View(flights)
 
# 値から観測値を選び出すfilter()
# 行を並び替えるarrange()
# 名前で変数を選ぶselect()
# 既存の変数の関数で新たな変数を作るmutate()
# 多数の値から単一の要約量を作るsummarize()
# group_by()と一緒に使える

filter(flights, month == 1, day == 1)

jan1 <- filter(flights, month == 1, day == 1)
(dec25 <- filter(flights, month == 12, day == 25))

# filter(flights, month = 1)

sqrt(2) ^ 2 == 2
near(sqrt(2) ^ 2, 2)
near(1 / 49 * 49, 1)

filter(flights, month == 11 | month == 12)

nov_dec <- filter(flights, month %in% c(11, 12))

filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120 & dep_delay <= 120)

NA > 5
10 == NA
NA + 10
NA / 2
NA == NA

#xをMaryの年齢とする。彼女が何歳かわからない
x <- NA
#yをJohnの年齢とする。彼が何歳かわからない
y <- NA
#JohnとMaryは同じ歳か？
x == y

is.na(x)

df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)

filter(flights, arr_delay >= 120)
filter(flights, dest == "IAH" | dest == "HOU")
filter(flights, carrier == "UA" | carrier == "AA" | carrier == "DL")
filter(flights, month >= 7 & month <= 9)
filter(flights, arr_delay > 120 & dep_delay == 0)
filter(flights, dep_delay > 60 & arr_delay < 30)
filter(flights, dep_time >= 0 & dep_time <= 600)
?between
filter(flights, between(month, 7, 9))
filter(flights, is.na(dep_time))
NA ^ 0
NA | TRUE
FALSE & NA
NA * 0

arrange(flights, year, month, day)

# view(arrange(flights, desc(arr_delay)))

df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))

arrange(df, desc(is.na(x)))
# view(arrange(flights, dep_time, desc(arr_time)))
arrange(flights, distance, hour, minute)
arrange(flights, distance / (hour*60 + minute))
arrange(flights, distance)
arrange(flights, desc(distance))

select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))

# starts_with("abc") abcで始まる名前にマッチする
# ends_with("xyz") xyzで終わる名前にマッチする
# contains("ijk") ijkを含む名前にマッチする
# matches("(.)\\1") 正規表現にマッチする変数を選ぶ
# num_range("x", 1:3) x1, x2, x3にマッチする

rename(flights, tail_num = tailnum)

select(flights, time_hour, air_time, everything())

select(flights, starts_with("dep") | starts_with("arr"))
select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, dep_time, dep_time)
?any_of
vars <- c(
  "year", "month", "day", "dep_delay", "arr_delay"
)
select(flights, any_of(vars))
select(flights, contains("TIME"))


flights_sml <- select(flights, 
                      year:day,
                      ends_with("delay"),
                      distance, 
                      air_time)
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)

transmute(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)

transmute(flights, 
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100)

(x <- 1:10)
lag(x)
lead(x)

x
cumsum(x)
cummean(x)

y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)
min_rank(desc(y))

row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)

select(flights, dep_time, sched_dep_time)
mutate(flights, min = dep_time %/% 100 * 60 + dep_time %% 100,
       sched_min = sched_dep_time %/% 100 * 60 + sched_dep_time %% 100)

transmute(flights, 
          air_time,
          diff_time = air_time - dep_time)

transmute(flights, 
          dep_delay, 
          dd = dep_time - sched_dep_time)

flights %>%
  select(dep_time, sched_dep_time, dep_delay) %>%
  mutate(
    dep_time = dep_time * -1, 
    sched_dep_time = sched_dep_time * -1,
    dep_delay_cal = dep_time -sched_dep_time, 
    flg = (dep_delay == dep_delay_cal)
  )


flights %>%
  select(carrier, flight, dep_delay) %>% 
  arrange(desc(dep_delay)) %>% 
  mutate(
    min_rank = min_rank(desc(dep_delay)),
    row_number = row_number(desc(dep_delay)),
    dense_rank = dense_rank(desc(dep_delay))
  )

1:3 + 1:10

summarize(flights, delay = mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, month, day)
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))

by_dest <- group_by(flights, dest)
delay <- summarize(by_dest,
                   count = n(), 
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE))
delay <- filter(delay, count > 20, dest != "HNL")
delay

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) + 
  geom_smooth(se = FALSE)

delays <- flights %>%
  group_by(dest) %>%
  summarize(
    count = n(),
    dist = mean(distance, na.rm = TRUE), 
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")
delays

flights %>% 
  group_by(year, month, day) %>% 
  summarize(mean = mean(dep_delay))

flights %>% 
  group_by(year, month, day) %>% 
  summarize(mean = mean(dep_delay, na.rm = TRUE))

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(mean = mean(dep_delay))

delays <- not_cancelled %>% 
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay)
  )
ggplot(data = delays, mapping = aes(x = delay)) +
  geom_freqpoly(binwidth = 10)

delays <- not_cancelled %>% 
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )
ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

delays %>% 
  filter(n > 25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) + 
  geom_point(alpha = 1/10)

batting <- as_tibble(Lahman::Batting)

batters <- batting %>% 
  group_by(playerID) %>%
  summarize(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )
batters %>% 
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba))+
  geom_point()+
  geom_smooth(se = FALSE)

batters %>% 
  arrange(desc(ba))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(
    # average delay:
    avg_delay = mean(arr_delay),
    # average positive delay:
    avg_delay2 = mean(arr_delay[arr_delay > 0])
  )

# なぜ目的地によって距離の変動が大きくなるのか
not_cancelled %>% 
  group_by(dest) %>% 
  summarize(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

# 各日の始発便と最終便の時刻はいつか
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time), 
    last = max(dep_time)
  )

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first_dep = first(dep_time),
    last_dep = last(dep_time), 
    ddd = nth(dep_time, 2)
  )

not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r)) # range()で与えられたベクトルの最大値と最小値を返す

# 航空会社が最も多いのはどの目的地だろうか？
not_cancelled %>% 
  group_by(dest) %>% 
  summarize(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))
# n_distinct(x) で異なる一意な値の個数を数える
# n()はグループごとの数全部を数える

not_cancelled %>% 
  count(dest)

not_cancelled %>% 
  count(tailnum, wt = distance)

# 午前5時より前に何便が出発するか？
# （これは普通は前日遅延した便を示す）
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(n_early = sum(dep_time < 500))

# 1時間以上遅延した便の割合は？
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_perc = mean(arr_delay > 60))

daily <- group_by(flights, year, month, day)
(per_day <- summarize(daily, flights = n()))
(per_month <- summarize(per_day, flights = sum(flights)))
(per_year <- summarize(per_month, flights = sum(flights)))

daily %>%
  ungroup() %>% 
  summarize(flights = n())

not_cancelled %>% 
  count(dest)

flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay)) %>%
  group_by(dest) %>%
  summarise(n = n())

not_cancelled %>% 
  count(tailnum, wt = distance)

flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay)) %>%
  group_by(tailnum) %>% 
  summarise(n = sum(distance))

flights %>%
  mutate(cancelled = (is.na(dep_delay) | is.na(arr_delay))) %>% 
  group_by(year, month, day) %>% 
  summarise(
    cancelled_num = sum(cancelled), 
    flights_num = n()
  ) %>% 
  ggplot(aes(x = flights_num, y = cancelled_num))+
  geom_point() +
  geom_smooth(se = FALSE)

tmp <- flights %>% 
  mutate(cancelled = (is.na(arr_delay) | is.na(dep_delay))) %>% 
  group_by(year, month, day) %>% 
  summarise(
    cancelled_ratio = mean(cancelled, na.rm = TRUE),
    avg_dep_delay = mean(dep_delay, na.rm = TRUE),
    avg_arr_delay = mean(arr_delay, na.rm = TRUE)
  )

pic1 <- tmp %>% 
  ggplot(aes(x = avg_dep_delay, y = cancelled_ratio))+
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE)

pic2 <- tmp %>% 
  ggplot(aes(x = avg_arr_delay, y = cancelled_ratio))+
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE)

flights %>%
  group_by(carrier) %>% 
  summarize(arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(desc(arr_delay))

flights %>% 
  mutate(dep_delay_flg = dep_delay > 60) %>%
  group_by(carrier) %>%
  summarise(over60 = sum(dep_delay_flg, na.rm = TRUE),
            carrier_num = n(),
            over60_delay_ratio = over60/carrier_num * 100) %>%
  arrange(desc(over60_delay_ratio))

flights %>%
  count(tailnum, sort = TRUE)

flights_sml %>% 
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)

popular_dests <- flights %>% 
  group_by(dest) %>%
  filter(n() > 365)

popular_dests %>%
  filter(arr_delay > 0) %>%
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>%
  select(year:day, dest, arr_delay, prop_delay)

flights %>% 
  group_by(tailnum) %>% 
  summarise(arr_delay = mean(arr_delay, na.rm = TRUE),
            n = n()) %>%
  filter(n >= 100) %>%
  mutate(rank = min_rank(desc(arr_delay))) %>%
  arrange(desc(arr_delay))

flights %>%
  group_by(hour) %>%
  summarise(arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(arr_delay)

flights %>%
  select(arr_delay, dest, origin) %>%
  filter(arr_delay > 0) %>%
  group_by(origin, dest) %>%
  summarise(arr_delay_total = sum(arr_delay), 
            n = n()) %>%
  arrange(desc(arr_delay_total))

flights %>% 
  select(arr_delay, dest, origin) %>%
  filter(arr_delay > 0) %>% 
  group_by(origin, dest) %>%
  summarise(arr_delay_total = sum(arr_delay), 
            n = n()) %>%
  arrange(desc(arr_delay_total))


# 4章 ワークフロー：スクリプト ---------------------------------------------------------

library(dplyr)
library(nycflights13)

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(mean = mean(dep_delay))


# 5章 探索的データ分析 -------------------------------------------------------------
# EDA: exploratory data analysis

library(tidyverse)

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut))

diamonds %>%
  count(cut)

ggplot(data = diamonds)+ 
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

diamonds %>% 
  count(cut_width(carat, 0.5))

smaller <- diamonds %>% 
  filter(carat < 3)

ggplot(data = smaller, mapping = aes(x = carat))+ 
  geom_histogram(bindwidth = 0.1)

ggplot(data = smaller, mapping = aes(x = carat, color = cut)) +
  geom_freqpoly(bindwidth = 0.1)

ggplot(data = smaller, mapping = aes(x = carat)) + 
  geom_histogram(binwidth = 0.01)

faithful %>%
  ggplot(aes(x = eruptions))+
  geom_histogram(binwidth = 0.25)

diamonds %>%
  ggplot()+
  geom_histogram(aes(x = y), binwidth = 0.5)

diamonds %>%
  ggplot()+
  geom_histogram(aes(x = y), binwidth = 0.5)+
  coord_cartesian(ylim = c(0, 50))

unusual <- diamonds %>%
  filter(y < 3 | y > 20) %>%
  select(price, x, y, z) %>%
  arrange(y)
unusual

diamonds %>%
  filter(x == 0) %>%
  arrange(x)
  ggplot(aes(x = x))+
  geom_histogram()+
  coord_cartesian(ylim = c(0, 50))

diamonds %>%
  filter(z == 0 | z > 8) %>%
  arrange(z) %>%
  ggplot(aes(x = z))+
  geom_histogram()+
  coord_cartesian(c(0, 50))

diamonds %>%
  filter(price < 1600 & price > 1400) %>%
  ggplot(aes(x = price))+
  geom_histogram(binwidth = 10)

diamonds %>%
  filter(carat <= 3) %>%
  ggplot(aes(carat)) + 
  geom_histogram(binwidth = 0.01)

diamonds %>%
  ggplot(aes(price))+
  geom_histogram(binwidth = 100)+
  coord_cartesian(xlim = c(1000, 5000), ylim = c(0, 3000))

diamonds %>%
  ggplot(aes(price))+
  geom_histogram(binwidth = 100)+
  xlim(1000, 5000)+
  ylim(0, 3000)

diamonds2 <- diamonds %>%
  filter(between(y, 3, 20))

diamonds2 <- diamonds %>%
  mutate(y = ifelse(y < 3 | y > 20, NA, y))

diamonds2 %>%
  ggplot(aes(x = x, y = y))+
  geom_point()

diamonds2 %>%
  ggplot(aes(x = x, y = y))+
  geom_point(na.rm = TRUE)

flights %>%
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(aes(sched_dep_time)) + 
  geom_freqpoly(
    aes(color = cancelled),
    binwidth = 1/4
  )


diamonds %>%
  select(carat) %>%
  mutate(carat = if_else(carat > 1, NA_real_, carat)) %>%
  ggplot(aes(x = carat)) +
  geom_histogram()
# numericの欠損値をNA_real_で表す

diamonds %>%
  mutate(color = if_else(runif(n()) < 0.3, NA_character_, as.character(color))) %>%
  ggplot()+
  geom_bar(aes(x = color))
# runif()で一様分布の乱数発生

diamonds %>%
  select(price) %>%
  mutate(price = if_else(runif(n()) < 0.3, NA_integer_, price)) %>%
  summarise(
    avg = mean(price),
    sum = sum(price)
  )

diamonds %>%
  select(price) %>%
  mutate(price = if_else(runif(n()) < 0.3, NA_integer_, price)) %>%
  summarise(
    avg = mean(price, na.rm = TRUE),
    sum = sum(price, na.rm = TRUE)
  )

diamonds %>%
  ggplot(aes(x = price)) + 
  geom_freqpoly(aes(color = cut), binwidth = 500)

diamonds %>%
  ggplot()+
  geom_bar(aes(x = cut))

diamonds %>%
  ggplot(aes(x = price, y = stat(density)))+
  geom_freqpoly(aes(color = cut), binwidth = 500)

diamonds %>%
  ggplot(aes(x = cut, y = price))+
  geom_boxplot()

mpg %>%
  ggplot(aes(x = class, y = hwy))+
  geom_boxplot()

mpg %>%
  ggplot()+
  geom_boxplot(
    aes(
      x = reorder(class, hwy, FUN = median),
      y = hwy)
  )

mpg %>%
  ggplot()+
  geom_boxplot(
    aes(
      x = reorder(class, hwy, FUN = median),
      y = hwy)
  ) +
  coord_flip()

flights %>%
  select(dep_time, sched_dep_time) %>%
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100, 
    sched_dep_time = sched_hour + (sched_min / 60)
  ) %>%
  ggplot(aes(x = cancelled, y = sched_dep_time))+
  geom_violin()+
  geom_boxplot(width = .1, alpha = 1/2, fill = "green")

colnames(diamonds)

p1 <- diamonds %>%
  ggplot(aes(x = carat, y= price))+
  geom_point()

p2 <- diamonds %>%
  ggplot(aes(x = depth, y= price))+
  geom_point()

p3 <- diamonds %>%
  ggplot(aes(x = table, y = price))+
  geom_point()
  
p4 <- diamonds %>%
  ggplot(aes(x = x, y = price))+
  geom_point()

p5 <- diamonds %>%
  ggplot(aes(x = y, y = price))+
  geom_point()

p6 <- diamonds %>%
  ggplot(aes(x = z, y = price))+
  geom_point()

library(gridExtra)
grid.arrange(p1, p2, p3, p4, p5, p6, ncol = 3, nrow = 2)

p7 <- diamonds %>%
  ggplot(aes(x = cut, y = price))+
  geom_boxplot()

p8 <- diamonds %>%
  ggplot(aes(x = color, y = price))+
  geom_boxplot()

p9 <- diamonds %>%
  ggplot(aes(x = reorder(clarity, price, FUN = median), y = price))+
  geom_boxplot()+
  xlab("clarity")

grid.arrange(p7, p8, p9,
           ncol = 3)

diamonds %>%
  ggplot(aes(x = cut, y = carat, color = price))+
  geom_jitter(alpha = 0.2)

library(ggstance)
mpg %>%
  ggplot(aes(x = reorder(class, hwy, FUN = median), y = hwy))+
  geom_boxplot()+
  coord_flip()

#ggstanceのgeom_boxplothだとy軸にclassを設定できる
#coord_flip()で向きを変えなくていい
ggplot(data = mpg) +
  geom_boxploth(mapping = aes(y = reorder(class, hwy, FUN = median), x = hwy))


library(lvplot)
diamonds %>%
  ggplot(aes(x = cut, y = price))+
  geom_boxplot()

diamonds %>%
  ggplot(aes(x = cut, y = price))+
  geom_lv()

diamonds %>%
  ggplot(aes(x = price))+
  geom_histogram(aes(fill = cut), position = "dodge")

diamonds %>%
  ggplot(aes(x = price, y = ..density..))+
  geom_freqpoly(aes(color = cut))

diamonds %>%
  ggplot(aes(x = cut, y = price))+
  geom_violin(aes(fill = cut))

library(ggbeeswarm)

mpg %>%
  ggplot()+
  geom_quasirandom(
    aes(x = reorder(class, hwy, FUN = median),
        y = hwy),
    method = "tukey"
  )

mpg %>%
  ggplot()+
  geom_beeswarm(
    aes(x = reorder(class, hwy, FUN = median), 
        y = hwy)
  )

diamonds %>%
  ggplot()+
  geom_count(aes(x = cut, y = color))

diamonds %>%
  count(color, cut)

diamonds %>%
  count(color, cut) %>%
  ggplot(aes(x = color, y = cut))+
  geom_tile(aes(fill = n))
  
#nは数

diamonds %>%
  count(color, cut) %>%
  mutate(prop = n / sum(n)) %>%
  ggplot(aes(x = color, y = cut))+
  geom_tile(aes(fill = prop))+
  scale_fill_gradient(low = "#FFFFFF", high = "#006E4F")

flights %>%
  group_by(month, dest) %>%
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = factor(month), y = dest, fill = dep_delay)) +
  geom_tile()+
  scale_fill_gradient(low = "#FFFFFF", high = "#006E4F")+
  labs(x = "Month", y = "Destination", fill = "Avg Dep Delay")

diamonds %>%
  ggplot()+
  geom_point(aes(x = carat, y = price))

diamonds %>%
  ggplot()+
  geom_point(aes(x = carat, y = price), 
             alpha = 1/100)

smaller %>%
  ggplot()+
  geom_bin2d(aes(x = carat, y = price))

# install.packages("hexbin")
smaller %>%
  ggplot()+
  geom_hex(aes(x = carat, y = price))

smaller %>%
  ggplot(aes(x = carat, y = price))+
  geom_boxplot(aes(group = cut_width(carat, 0.1)), varwidth = TRUE)
# cut_width(x, width)でxをwidthの幅で区間分けする
# varwidth = TRUEで個数によって幅を変える

smaller %>%
  ggplot(aes( x = carat, y = price))+
  geom_boxplot(aes(group = cut_number(carat, 20)))
# cut_number(x, n)でxを20ずつ個数によって幅を変える

smaller %>%
  ggplot(aes(x = carat, y = price))+
  geom_boxplot(aes(group = cut_width(carat, 0.1)))

diamonds %>%
  ggplot(aes(x = cut_width(price, 2000), y = carat))+
  geom_boxplot()+
  coord_flip()+
  labs(x = "Price", y = "Carat")

diamonds %>%
  ggplot(aes(x = cut_width(carat, 1), y = price))+
  geom_boxplot()+
  xlab("carat")

diamonds %>%
  select(carat, price) %>%
  mutate(carat = cut_width(carat, 0.5),
         price = cut_width(price, 1000)) %>%
  group_by(carat, price) %>%
  summarise(n = n()) %>%
  ggplot(aes(x = carat, y = price, fill = n))+
  geom_tile() +
  scale_fill_gradient(low = "#FFFFFF", high = "#006E4F")

diamonds %>%
  ggplot(aes(x = carat, y = price, color = cut))+
  geom_point(alpha = 0.1)

diamonds %>%
  ggplot(aes(x = cut_number(carat, 5), y = price, color = cut))+
  geom_boxplot()

diamonds %>%
  ggplot(aes(x = x, y = y))+
  geom_point()+
  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11))

diamonds %>%
  ggplot(aes(x = x, y = y))+
  geom_point(alpha = 0.2)
  
faithful %>%
  ggplot()+
  geom_point(aes(x = eruptions, y = waiting))

library(modelr)

mod <- lm(log(price) ~ log(carat), data = diamonds)
diamonds2 <- diamonds %>%
  add_residuals(mod) %>%
  mutate(resid = exp(resid))

diamonds2 %>%
  ggplot()+
  geom_point(aes(x = carat, y = resid))

diamonds2 %>%
  ggplot()+
  geom_boxplot(aes(x = cut, y = resid))

ggplot(data = faithful, mapping = aes(x = eruptions))+
  geom_freqpoly(binwidth = 0.25)

ggplot(faithful, aes(eruptions))+
  geom_freqpoly(binwidth = 0.25)

diamonds %>%
  count(cut, clarity) %>%
  ggplot(aes(clarity, cut, fill = n))+
  geom_tile()

getwd()
