merged_df <- all_disasters_df1 %>%
  mutate(Year = ifelse(Year >= 1900 & Year <= 1999, paste(Year), paste(Year))) %>%
  select(Year, Type, DeathToll)

# Plotting
plot <- ggplot(merged_df, aes(x = Year, y = DeathToll, fill = Type)) +
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