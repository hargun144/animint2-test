library(animint2)

set.seed(42)

# Create a grid of population points
n_clusters <- 9
cluster_size <- 10
n_select <- 3  # clusters selected per frame
n_frames <- 15

# Generate population grid
pop <- data.frame()
for (cl in 1:n_clusters) {
  cx <- ((cl - 1) %% 3) * 4 + 2
  cy <- ((cl - 1) %/% 3) * 4 + 2
  pts <- data.frame(
    x = cx + runif(cluster_size, -1, 1),
    y = cy + runif(cluster_size, -1, 1),
    cluster = cl
  )
  pop <- rbind(pop, pts)
}

# Generate cluster box outlines
boxes <- data.frame()
for (cl in 1:n_clusters) {
  cx <- ((cl - 1) %% 3) * 4 + 2
  cy <- ((cl - 1) %/% 3) * 4 + 2
  boxes <- rbind(boxes, data.frame(
    cluster = cl,
    xmin = cx - 1.5,
    xmax = cx + 1.5,
    ymin = cy - 1.5,
    ymax = cy + 1.5
  ))
}

# Generate frames: each frame randomly selects n_select clusters
frames_pts <- data.frame()
frames_boxes <- data.frame()

for (i in 1:n_frames) {
  selected <- sample(1:n_clusters, n_select)
  
  pts_i <- pop
  pts_i$iter <- i
  pts_i$selected <- pts_i$cluster %in% selected
  frames_pts <- rbind(frames_pts, pts_i)
  
  boxes_i <- boxes
  boxes_i$iter <- i
  boxes_i$selected <- boxes_i$cluster %in% selected
  frames_boxes <- rbind(frames_boxes, boxes_i)
}

frames_pts$selected <- as.character(frames_pts$selected)
frames_boxes$selected <- as.character(frames_boxes$selected)

viz <- animint(
  plot1 = ggplot() +
    geom_rect(
      data = frames_boxes,
      aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = selected),
      showSelected = "iter",
      alpha = 0.2,
      color = "black"
    ) +
    geom_point(
      data = frames_pts,
      aes(x = x, y = y, color = selected),
      showSelected = "iter",
      size = 3
    ) +
    scale_color_manual(
      values = c("FALSE" = "gray60", "TRUE" = "red"),
      labels = c("FALSE" = "Not selected", "TRUE" = "Selected")
    ) +
    scale_fill_manual(
      values = c("FALSE" = "gray90", "TRUE" = "#ffcccc"),
      labels = c("FALSE" = "Not selected", "TRUE" = "Selected")
    ) +
    labs(
      title = "Cluster Sampling: randomly selected clusters",
      x = "", y = "", color = "Status", fill = "Status"
    ) +
    theme_animint(width = 550, height = 500),

  time = list(variable = "iter", ms = 1000),
  title = "Cluster Sampling Animation"
)

animint2dir(viz, out.dir = "animint2-cluster")
