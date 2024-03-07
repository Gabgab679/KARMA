# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require_relative "seeds/paris_address_generator"

Event.delete_all
puts "------------------    ---------------------- "
puts "               Delete Events                 "
puts "------------------    ---------------------- "
Favorite.delete_all
puts "------------------    ---------------------- "
puts "               Delete Favorites              "
puts "------------------    ---------------------- "
Game.delete_all
puts "------------------    ---------------------- "
puts "               Delete Games"
puts "------------------    ---------------------- "

User.delete_all
puts "------------------    ---------------------- "
puts "               Delete Users"
puts "------------------    ---------------------- "

# # Uno
# # Poker
# # Monopoly
# # Yu-gi-yoh
# # Pokemon
# # Werewolves
# # Blood on the tower clock
# #

url = "https://api.geekdo.com/xmlapi/collection/mkgray"
xml_file = URI.open(url).read
html_doc = Nokogiri::XML.parse(xml_file)

games = []

html_doc.root.xpath("item").first(10).each do |element|
  games << Game.create!(
    name: element.xpath('name').text,
    description: element.xpath('comment').text,
    image_url: element.xpath('image').text,
    min_players: rand(2..4)
  )
end

# seeds.rb
games_attributes = [
  { name: "Uno", description: "Uno is a classic card game where players aim to be the first to get rid of all their cards by matching colors or numbers.", image_url: "https://www.godisageek.com/wp-content/uploads/Uno-review1.jpg", min_players: 2 },
  { name: "Poker", description: "Poker is a popular card game that involves betting and strategy, with variations like Texas Hold'em and Omaha.", image_url: "https://monmouthjetcenter.com/wp-content/uploads/2015/04/cose-poker.jpg", min_players: 2 },
  { name: "Monopoly", description: "Monopoly is a classic board game where players buy, sell, and trade properties to become the wealthiest player.", image_url: "https://vignette.wikia.nocookie.net/board-games-galore/images/6/66/Monopoly_cover.jpg/revision/latest/scale-to-width-down/2000?cb=20160719170933", min_players: 2 },
  { name: "Yu-gi-oh", description: "Yu-Gi-Oh! is a trading card game where players use decks of cards featuring monsters, spells, and traps to duel each other.", image_url: "https://assets.dicebreaker.com/yu-gi-oh-tcg-yugi-art.png/BROK/resize/1688%3E/format/jpg/quality/80/yu-gi-oh-tcg-yugi-art.png" , min_players: 2 },
  { name: "Pokemon", description: "Pokemon is a franchise that includes video games, trading card games, and animated series where players catch and train creatures called Pokemon to battle each other.", image_url: "https://getwallpapers.com/wallpaper/full/b/5/7/1458092-beautiful-pokemon-movie-wallpaper-3840x2160-for-android-50.jpg", min_players: 2 },
  { name: "Werewolves", description: "Werewolves is a party game where players are assigned secret roles as villagers or werewolves, with the villagers trying to identify and eliminate the werewolves.", image_url: "https://th.bing.com/th/id/OIP.hHe4_xY_OZjXGvzJ4vGE0QHaHa?rs=1&pid=ImgDetMain", min_players: 5 },
  { name: "Blood on the Clock Tower", description: "Blood on the Clock Tower is a mystery board game where players work together to solve a murder that has occurred in a clock tower.", image_url: "https://images.saymedia-content.com/.image/t_share/MTc0NDYxMTIwMzI0MjQ4OTM2/blood-on-the-clock-tower-review.png", min_players: 5 }
]

games_attributes.each do |game_attribute|
  games << Game.create!(name: game_attribute[:name], image_url: game_attribute[:image_url], description: game_attribute[:description], min_players: game_attribute[:min_players])
end

users = []

users_attributes = [
  { username: "alexrz", email: "alexandre.rodriguez.arz@gmail.com", password: "123456"},
  { username: "toufik2flex", email: "theophiledesaintbon@gmail.com", password: "123456"},
  { username: "ladyGabGab", email: "gabrielle.simha@gmail.com", password: "123456"},
  { username: "anton1", email: "antonindanto@gmail.com", password: "123456"}
]

users_attributes.each do |user_attribute|
  users << User.create!(username: user_attribute[:username], email: user_attribute[:email], password: user_attribute[:password])
end

favorites = [
  { game: games[6], user: users[2] },
  { game: games[3], user: users[1] },
  { game: games[2], user: users[3] },
  { game: games[1], user: users[0] },
  { game: games[2], user: users[0] },
  { game: games[3], user: users[0] },
  { game: games[4], user: users[0] }
]

Game.first(10).each do |game|
  Favorite.create!(game: game, user: User.first)
end

# event_addresses = ParisAddressGenerator.generate(number: 40)
# # p event_addresses
ADDRESSES = ["3 rue de rivoli 75001","3 rue des boulets 75011", "3 rue pouchet 75017", "3 rue de rivoli 75001", "3 rue de la paix 75002", "3 rue servan 75011", "3 boulevard voltaire 75011", "3 boulevard diderot 75012", "3 boulevard de Ménilmontant 75011", "3 boulevard beaumarchais 75004" ]
EVENT_NAME = ["Let's play !", "Discovery", "Tournament", "Intermediate game", "Event"]

30.times do
  game = games.sample
  user = users.sample

  Event.create!(
    event_type: Event::EVENT_TYPE.sample,
    name: EVENT_NAME.sample,
    user: user,
    date: (Date.today + rand(0..60)).to_datetime,
    address: event_addresses.sample, # addresse a générer par faker autour de paris
    description: Faker::Movies::StarWars.quote, # description à générer par faker
    status: Event::STATUS.sample,
    game: game,
    max_players: rand(6..12)
  )
  # creation d'event avec faker et "generate"
end
