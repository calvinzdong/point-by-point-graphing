library(ggplot2)
## import csv data
raw_df <- read.csv("data_raw/sv_data_raw.csv")
df_list <- split(raw_df, f = raw_df$Point)

## create images

for (i in 1:length(df_list)) {
  #declaring empty list
  x1 = vector()
  y1 = vector()
  x2 = vector()
  y2 = vector()
  
  for (j in 1:nrow(df_list[[i]])){
    df_row <- df_list[[i]][j,]
    x1 = append(x1, df_row$Racket.Contact..x.)
    x2 = append(x2, df_row$Shot.Placement..x.)
    y1 = append(y1, df_row$Racket.Contact..y.)
    y2 = append(y2, df_row$Shot.Placement..y.)
  }
  d = data.frame(x1 = x1, x2 = x2, y1 = y1, y2 = y2)
  
  #plotting a tennis court
  point_plot <- ggplot(data = d)
  
  plt = point_plot + 
    geom_rect(aes(xmin = -4.115, xmax = 4.115, ymin = 0, ymax = 23.77), alpha = 0, color = 'black') + 
    geom_segment(aes(x = -4.115, xend = 4.115, y = 11.885, yend = 11.884)) +
    geom_rect(aes(xmin = -4.115, xmax = 4.115, ymin = 5.485, ymax = 18.285), alpha = 0, color = 'black')+
    geom_segment(aes(x = 0, xend = 0, y = 5.485, yend = 18.285)) +
    ggtitle(paste("Point", i, sep = " ")) +
    theme(axis.title.x=element_blank(), axis.text.x=element_blank(),axis.ticks.x=element_blank()) + 
    geom_segment(data = d, aes(x = x1, xend = x2, y = y1, yend = y2), color = "red")
  
  #save image
  save_fn = paste("point", i, ".jpg", sep = "")
  ggsave(filename = save_fn, plot = plt, path = "created_images")
}