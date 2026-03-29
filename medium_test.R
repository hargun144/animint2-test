library(animint2)

set.seed(42)
nrow_val <- 10
ncol_val <- 10
size <- 15
nmax <- 20

# Generate population grid
population <- data.frame(
  x = rep(1:ncol_val, nrow_val),
  y = as.integer(gl(nrow_val, ncol_val)),
  id = 1:(nrow_val * ncol_val)
)

# Generate samples for each iteration
frames <- list()
for (i in 1:nmax) {
  sampled_ids <- sample(nrow_val * ncol_val, size)
  df <- population
  df$sampled <- ifelse(df$id %in% sampled_ids, "Sampled", "Population")
  df$iteration <- i
  frames[[i]] <- df
}
all_frames <- do.call(rbind, frames)
all_frames$iteration <- as.integer(all_frames$iteration)
all_frames$sampled <- as.character(all_frames$sampled)

# Summary data: sample mean x and y per iteration
summary_df <- data.frame(
  iteration = 1:nmax,
  mean_x = sapply(1:nmax, function(i) {
    d <- all_frames[all_frames$iteration == i & all_frames$sampled == "Sampled", ]
    mean(d$x)
  }),
  mean_y = sapply(1:nmax, function(i) {
    d <- all_frames[all_frames$iteration == i & all_frames$sampled == "Sampled", ]
    mean(d$y)
  })
)

# Plot 1: Population grid with sampled points highlighted
grid_plot <- ggplot() +
  geom_point(
    data = all_frames,
    aes(x = x, y = y, color = sampled, size = sampled, key = id),
    showSelected = "iteration"
  ) +
  scale_color_manual(values = c("Population" = "steelblue", "Sampled" = "red")) +
  scale_size_manual(values = c("Population" = 3, "Sampled" = 6)) +
  ggtitle("Simple Random Sampling — Population Grid") +
  xlab("Column") + ylab("Row") +
  theme_animint(width = 500, height = 500)

# Plot 2: Sample mean x over iterations
mean_plot <- ggplot() +
  geom_line(
    data = summary_df,
    aes(x = iteration, y = mean_x),
    color = "red"
  ) +
  geom_point(
    data = summary_df,
    aes(x = iteration, y = mean_x, key = iteration),
    showSelected = "iteration",
    color = "red",
    size = 5
  ) +
  geom_hline(
    data = data.frame(y = mean(population$x)),
    aes(yintercept = y),
    linetype = "dashed",
    color = "steelblue"
  ) +
  ggtitle("Sample Mean (x) vs True Mean (dashed)") +
  xlab("Iteration") + ylab("Mean X") +
  theme_animint(width = 500, height = 300)

viz <- animint(
  grid = grid_plot,
  means = mean_plot,
  time = list(variable = "iteration", ms = 800),
  title = "Simple Random Sampling Animation",
  source = "https://github.com/hargun144/animint2-medium"
)

animint2pages(viz, "animint2-medium")
