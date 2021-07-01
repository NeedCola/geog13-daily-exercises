# Chi Zhang
### 7/1/2021
# Daily-exercise-07

library(tidyverse)

states = USAboundaries::us_states(resolution = "low")  %>%
  select('state_abbr', 'state_name')

region = data.frame(state_abbr = state.abb, region = state.region)

covid = read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv')

area = inner_join(region, states, by = "state_abbr") %>%
  select(state_abbr, region, state = state_name)



Regioncases = inner_join(covid, area, by = "state")%>%
  select(date, region,cases, deaths)

REGION = Regioncases %>%
  group_by(date, region) %>%
  summarise(cases = sum(cases), deaths = sum(deaths)) %>%
  pivot_longer(cols = c('cases', 'deaths')) %>%
  ungroup()

REGION %>%
  ggplot(aes(x = date, y = value)) +
  geom_line(aes(color = region)) +
  labs(title = "Cumulative Cases and Deaths: Region",
       x = "Date",
       y = "Daily Cumulative count",
       caption = "based on https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv",
       subtitle = 'Data Source: NY-Times',
       color = "") +
  facet_grid(name~region, scales = "free_y") +
  theme_gray() +
  theme(axis.text.x = element_text(angle = 90))

ggsave(file = "img/day-07.png")
