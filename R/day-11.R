# Chi Zhang
### 07/12/2021
# Daily-exercise-11

library(sf)
library(tidyverse)
library(units)


cities = readr::read_csv("data/uscities.csv") %>%
  filter(city %in% c("Santa Barbara", "Costa Mesa")) %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326)

eqds = '+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs'

l1 = st_distance(cities)

l2 =st_distance(st_transform(cities, 5070))

l3 = st_distance(st_transform(cities, eqds))

set_units(l1, "km") %>%
  drop_units()

set_units(l2, "km") %>%
  drop_units()

set_units(l3, "km") %>%
  drop_units()
