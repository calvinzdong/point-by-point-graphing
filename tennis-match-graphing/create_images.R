## import csv data
raw_df <- read.csv("data_raw/sv_data_raw.csv")
df_list <- split(raw_df, f = raw_df$Point)

## create images

for (i in 1:length)