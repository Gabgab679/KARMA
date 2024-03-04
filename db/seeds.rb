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
puts "------------------    ---------------------- "
puts "               Delete Games"
puts "------------------    ---------------------- "
User.delete_all
puts "------------------    ---------------------- "
puts "               Delete Users"
puts "------------------    ---------------------- "
# Uno
# Poker
# Monopoly
# Yu-gi-yoh
# Pokemon
# Werewolves
# Blood on the tower clock
#

# seeds.rb
games = [
  { name: "Uno", description: "Uno is a classic card game where players aim to be the first to get rid of all their cards by matching colors or numbers.", min_players: 2 },
  { name: "Poker", description: "Poker is a popular card game that involves betting and strategy, with variations like Texas Hold'em and Omaha.", min_players: 2 },
  { name: "Monopoly", description: "Monopoly is a classic board game where players buy, sell, and trade properties to become the wealthiest player.", min_players: 2 },
  { name: "Yu-gi-oh", description: "Yu-Gi-Oh! is a trading card game where players use decks of cards featuring monsters, spells, and traps to duel each other.", min_players: 2 },
  { name: "Pokemon", description: "Pokemon is a franchise that includes video games, trading card games, and animated series where players catch and train creatures called Pokemon to battle each other.", min_players: 2 },
  { name: "Werewolves", description: "Werewolves is a party game where players are assigned secret roles as villagers or werewolves, with the villagers trying to identify and eliminate the werewolves.", min_players: 5 },
  { name: "Blood on the Clock Tower", description: "Blood on the Clock Tower is a mystery board game where players work together to solve a murder that has occurred in a clock tower.", min_players: 5 }
]

games.each do |game|
  Game.create!(name: game[:name], description: game[:description], min_players: game[:min_players])
end

users = [
  { email: "", password: ""},
  { email: "", password: ""},
  { email: "", password: ""},
  { email: "", password: ""}
]

users.each do |user|
  User.create!(email: user[:email], password: user[:password])
end
