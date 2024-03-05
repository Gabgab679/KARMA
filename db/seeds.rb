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
url = "https://api.geekdo.com/xmlapi/collection/mkgray"
xml_file = URI.open(url).read
html_doc = Nokogiri::XML.parse(xml_file)

result = []
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
  { email: "alexandre.rodriguez.arz@gmail.com", password: "123456"},
  { email: "theophiledesaintbon@gmail.com", password: "123456"},
  { email: "gabrielle.simha@gmail.com", password: "123456"},
  { email: "antonindanto@gmail.com", password: "123456"}
]

users.each do |user|
  User.create!(email: user[:email], password: user[:password])
end
