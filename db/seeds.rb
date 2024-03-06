# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Event.delete_all
puts "------------------    ---------------------- "
puts "               Delete Events                 "
puts "------------------    ---------------------- "
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
url = "https://api.geekdo.com/xmlapi/collection/mkgray"
xml_file = URI.open(url).read
html_doc = Nokogiri::XML.parse(xml_file)

html_doc.root.xpath("item").first(2).each do |element|
  Game.create!(
    name: element.xpath('name').text,
    description: element.xpath('comment').text,
    image_url: element.xpath('image').text,
    min_players: element.xpath('stats').attr('minplayers').value
  )
end

# seeds.rb
games = [
  { name: "Uno", description: "Uno is a classic card game where players aim to be the first to get rid of all their cards by matching colors or numbers.", image_url: "https://www.godisageek.com/wp-content/uploads/Uno-review1.jpg", min_players: 2 },
  { name: "Poker", description: "Poker is a popular card game that involves betting and strategy, with variations like Texas Hold'em and Omaha.", image_url: "https://monmouthjetcenter.com/wp-content/uploads/2015/04/cose-poker.jpg", min_players: 2 },
  { name: "Monopoly", description: "Monopoly is a classic board game where players buy, sell, and trade properties to become the wealthiest player.", image_url: "https://vignette.wikia.nocookie.net/board-games-galore/images/6/66/Monopoly_cover.jpg/revision/latest/scale-to-width-down/2000?cb=20160719170933", min_players: 2 },
  { name: "Yu-gi-oh", description: "Yu-Gi-Oh! is a trading card game where players use decks of cards featuring monsters, spells, and traps to duel each other.", image_url: "https://assets.dicebreaker.com/yu-gi-oh-tcg-yugi-art.png/BROK/resize/1688%3E/format/jpg/quality/80/yu-gi-oh-tcg-yugi-art.png" , min_players: 2 },
  { name: "Pokemon", description: "Pokemon is a franchise that includes video games, trading card games, and animated series where players catch and train creatures called Pokemon to battle each other.", image_url: "https://getwallpapers.com/wallpaper/full/b/5/7/1458092-beautiful-pokemon-movie-wallpaper-3840x2160-for-android-50.jpg", min_players: 2 },
  { name: "Werewolves", description: "Werewolves is a party game where players are assigned secret roles as villagers or werewolves, with the villagers trying to identify and eliminate the werewolves.", image_url: "https://th.bing.com/th/id/OIP.hHe4_xY_OZjXGvzJ4vGE0QHaHa?rs=1&pid=ImgDetMain", min_players: 5 },
  { name: "Blood on the Clock Tower", description: "Blood on the Clock Tower is a mystery board game where players work together to solve a murder that has occurred in a clock tower.", image_url: "https://images.saymedia-content.com/.image/t_share/MTc0NDYxMTIwMzI0MjQ4OTM2/blood-on-the-clock-tower-review.png", min_players: 5 }
]

games.each do |game|
  Game.create!(name: game[:name], description: game[:description], min_players: game[:min_players])
end

users = [
  { username: "alexrz", email: "alexandre.rodriguez.arz@gmail.com", password: "123456"},
  { username: "toufik2flex", email: "theophiledesaintbon@gmail.com", password: "123456"},
  { username: "ladyGabGab", email: "gabrielle.simha@gmail.com", password: "123456"},
  { username: "anton1", email: "antonindanto@gmail.com", password: "123456"}
]

favorites = [
  { game_id: '6', user_id: '3'},
  { game_id: '3', user_id: '2'},
  { game_id: '2', user_id: '4'},
  { game_id: '1', user_id: '1'},
  { game_id: '2', user_id: '1'},
  { game_id: '3', user_id: '1'},
  { game_id: '4', user_id: '1'}
]

# seed events a ne surtout pas faire manuellement
# time

# dates = []

# 2.times do
#   dates << (Date.today + rand(0..60)).to_datetime
# end

def generate_int_for_events(index) # generates int for events
  int_attr_array = []

  int_attr_array << (Date.today + rand(0..60)).to_datetime
  int_attr_array << rand(1..4)
  int_attr_array << rand(0..20)
  int_attr_array << rand(6..12)

  int_attr_array[index]
end

# utiliser faker pour créer le name, l'adresse et la description

users.each do |user|
  User.create!(username: user[:username], email: user[:email], password: user[:password])
end

Game.first(4).each do |game|
  Favorite.create!(game: game, user: User.first)
end

2.times do
  Event.create!(
    event_type: %w[Casual Tournament].sample,
    name: "Partie de #{Game.find(rand(0..20))} proposée par #{User.find(rand(0..4))}",
    user_id: generate_int_for_events(1),
    date: generate_int_for_events(0),
    address: "26 boulevard les marquises", # addresse a générer par faker autour de paris
    description: "oeoeoeoe", # description à générer par faker
    status: %w[Open Cancelled Fully booked].sample,
    game_id: generate_int_for_events(2),
    max_players: generate_int_for_events(3)
  )
  # creation d'event avec faker et "generate"
end
