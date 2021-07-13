# Chi Zhang
### 07/13/2021
# Daily-exercise-12

library(tidyverse)
library(sf)
library(USAboundaries)

state = USAboundaries::us_states() %>%
  filter(!name %in% c("Alaska", "Hawaii", "Puerto Rico"))


Idaho = USAboundaries::us_states() %>%
  filter(state_name == "Idaho")


Colorado = USAboundaries::us_states() %>%
  filter(state_name == "Colorado")

IdahoBoundary = st_filter(state, Idaho, .predicate = st_touches)

ColoradoBoundary = st_filter(state, Colorado, .predicate = st_touches)

ggplot() +
  geom_sf(data = state, fill = NA, size = 1) +
  geom_sf(data = ColoradoBoundary, fill = 'red', alpha = .5) +
  labs(title = "States Around Colorado",
       x = "Longitude",
       y = "Latitude") +
  theme_gray()


ggsave(file = "img/States Around Colorado.png")
