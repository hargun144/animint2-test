library(animint2)

set.seed(42)
nmax <- 20
pop <- ceiling(10 * runif(10, 0.5, 1))
size <- ceiling(pop * runif(length(pop), 0, 0.5))
nrow_val <- length(pop)

# Generate all frames
frames <- list()
for (i in 1:nmax) {
  stratum_list <- list()
  for (j in 1:nrow_val) {
    sampled_cols <- sample(pop[j], size[j])
    df <- data.frame(
      x = 1:pop[j],
      y = j,
      stratum = j,
      sampled = ifelse(1:pop[j] %in% sampled_cols, "Sampled", "Population"),
      iteration = i
    )
    stratum_list[[j]] <- df
  }
  frames[[i]] <- do.call(rbind, stratum_list)
}
all_frames <- do.call(rbind, frames)
all_frames$iteration <- as.integer(all_frames$iteration)
all_frames$stratum <- as.integer(all_frames$stratum)
all_frames$sampled <- as.character(all_frames$sampled)
all_frames$key <- paste(all_frames$stratum, all_frames$x, sep="_")

# Summary: sampled count per stratum per iteration
summary_df <- do.call(rbind, lapply(1:nmax, function(i) {
  do.call(rbind, lapply(1:nrow_val, function(j) {
    d <- all_frames[all_frames$iteration == i & all_frames$stratum == j, ]
    data.frame(
      iteration = i,
      stratum = j,
      n_sampled = sum(d$sampled == "Sampled"),
      n_pop = pop[j]
    )
  }))
}))
summary_df$iteration <- as.integer(summary_df$iteration)
summary_df$stratum <- as.integer(summary_df$stratum)

# Plot 1: Stratified population grid
strat_plot <- ggplot() +
  geom_point(
    data = all_frames,
    aes(x = x, y = y, color = sampled, size = sampled, key = key),
    showSelected = "iteration"
  ) +
  scale_color_manual(values = c("Population" = "steelblue", "Sampled" = "red")) +
  scale_size_manual(values = c("Population" = 3, "Sampled" = 6)) +
  ggtitle("Stratified Random Sampling") +
  xlab("Unit") + ylab("Stratum") +
  theme_animint(width = 550, height = 450)

# Plot 2: Bar chart of sampled vs population per stratum
bar_plot <- ggplot() +
  geom_bar(
    data = summary_df,
    aes(x = stratum, y = n_pop),
    showSelected = "iteration",
    stat = "identity",
    position = "identity",
    fill = "steelblue",
    alpha = 0.4
  ) +
  geom_bar(
    data = summary_df,
    aes(x = stratum, y = n_sampled),
    showSelected = "iteration",
    stat = "identity",
    position = "identity",
    fill = "red",
    alpha = 0.8
  ) +
  ggtitle("Sampled (red) vs Population (blue) per Stratum") +
  xlab("Stratum") + ylab("Count") +
  theme_animint(width = 550, height = 300)

viz <- animint(
  strat = strat_plot,
  bars = bar_plot,
  time = list(variable = "iteration", ms = 800),
  title = "Stratified Random Sampling Animation",
  source = "https://github.com/hargun144/animint2-medium2"
)

animint2pages(viz, "animint2-medium2")
