library(animint2)
library(gapminder)

gap <- as.data.frame(gapminder)
gap$year <- as.integer(gap$year)
gap$country <- as.character(gap$country)
gap$continent <- as.character(gap$continent)

bubble <- ggplot() +
  geom_point(
    data = gap,
    aes(x = gdpPercap, y = lifeExp, size = pop, color = continent, key = country, tooltip = country),
    clickSelects = "country",
    showSelected = "year",
    alpha = 0.75
  ) +
  scale_x_log10("GDP per Capita (log scale)") +
  scale_y_continuous("Life Expectancy (years)") +
  scale_size_continuous(range = c(2, 20), guide = "none") +
  ggtitle("Click a country. Use year selector to animate.") +
  theme_animint(width = 600, height = 450)

timeseries <- ggplot() +
  geom_line(
    data = gap,
    aes(x = year, y = lifeExp, group = country, color = continent),
    showSelected = "country",
    size = 2
  ) +
  geom_point(
    data = gap,
    aes(x = year, y = lifeExp, key = year, color = continent),
    showSelected = "country",
    size = 4
  ) +
  scale_x_continuous("Year") +
  scale_y_continuous("Life Expectancy (years)") +
  ggtitle("Life Expectancy Over Time (selected country)") +
  theme_animint(width = 600, height = 350)

viz <- animint(
  bubble = bubble,
  timeseries = timeseries,
  time = list(variable = "year", ms = 1500),
  title = "Gapminder: GDP, Life Expectancy & Time",
  source = "https://github.com/hargun144/animint2-easy"
)

animint2pages(viz, "animint2-easy")
