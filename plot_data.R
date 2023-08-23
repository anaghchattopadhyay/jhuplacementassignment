#merge data
merged_df <- all_disasters_df1 %>%
  select(Year, Type, DeathToll)

#convert to data frame
merged_df1=as.data.frame(merged_df)

# Plotting
plot <- ggplot(merged_df1, aes(x = Year, y = DeathToll, fill = Type)) +
  geom_bar(stat = "identity", position = "stack") +
  theme_minimal() +
  labs(
    title = "Natural Disasters by Death Toll (20th and 21st Century)",
    x = "Year",
    y = "Death Toll",
    fill = "Kind of Disaster"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Plotting- log
plot <- ggplot(merged_df1, aes(x = Year, y = log(DeathToll, base=10), fill = Type)) +
  geom_bar(stat = "identity", position = "stack") +
  theme_minimal() +
  labs(
    title = "Natural Disasters by Death Toll (20th and 21st Century)",
    x = "Year",
    y = "Death Toll",
    fill = "Kind of Disaster"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Save the plot as an image
ggsave("natural_disasters_death_toll.png", plot, width = 12, height = 6)