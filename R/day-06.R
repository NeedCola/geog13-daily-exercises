# Chi Zhang
### 6/30/2021
# Daily-exercise-06

library(tidyverse)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties-recent.csv'
covid = read_csv(url)


covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  summarise(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup() %>%
  slice_max(cases, n = 6) %>%
  pull(state) ->
  top_states

filter(covid, state %in% top_states) %>%
  group_by(state, date) %>%
  summarise(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup() %>%
  ggplot(aes(x = date, y = cases)) +
  geom_line(aes(color = state)) +
  labs(title = "6 States with Most Cases: COVID-19 Pandemic",
       x = "Date",
       y = "Everyday Cases",
       caption = "based on https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties-recent.csv",
       subtitle = 'Data Source: Covid',
       color = "") +
  facet_wrap(~state) +
  theme_gray()

ggsave(file = "img/day-06-q1.png")


covid %>%
  group_by(date) %>%
  summarise(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup() %>%
  ggplot(aes(x = date, y = cases)) +
  geom_col(color = "red") +
  labs(title = "National Cummulative Case Counts: COVID-19 Pandemic",
       x = "Date",
       y = "Everyday Cases",
       caption = "based on https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties-recent.csv",
       subtitle = 'Data Source: Covid',
       color = "") +
  theme_gray()

ggsave(file = "img/day-06-q2.png")
