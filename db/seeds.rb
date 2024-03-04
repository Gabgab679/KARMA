# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Game.delete_all
User.delete_all
# Uno
# Poker
# Monopoly
# Yu-gi-yoh
# Pokemon
# Werewolves
# Blood on the tower clock
#

games = [
  { name: "Uno", description: "Uno is a classic card game where players aim to be the first to get rid of all their cards by matching colors or numbers." },
  { name: "Poker", description: "Poker is a popular card game that involves betting and strategy, with variations like Texas Hold'em and Omaha." },
  { name: "Monopoly", description: "Monopoly is a classic board game where players buy, sell, and trade properties to become the wealthiest player." },
  { name: "Yu-gi-oh", description: "Yu-Gi-Oh! is a trading card game where players use decks of cards featuring monsters, spells, and traps to duel each other." },
  { name: "Pokemon", description: "Pokemon is a franchise that includes video games, trading card games, and animated series where players catch and train creatures called Pokemon to battle each other." },
  { name: "Werewolves", description: "Werewolves is a party game where players are assigned secret roles as villagers or werewolves, with the villagers trying to identify and eliminate the werewolves." },
  { name: "Blood on the clock tower", description: "Blood on the Clock Tower is a mystery board game where players work together to solve a murder that has occurred in a clock tower." }
]

games.each do |game|
  Game.create(name: game[:name], description: game[:description])
end
