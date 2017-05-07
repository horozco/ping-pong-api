# frozen_string_literal: true

# Players
player_attributes = [
  {name: "Synthia Hilpert", email: "saul.stark@swift.us", password: "password1234", password_confirmation: "password1234"},
  {name: "Susanna Stamm", email: "leslie@ullrich.info", password: "password1234", password_confirmation: "password1234"},
  {name: "Reita Kihn", email: "nu@bergstromkerluke.name", password: "password1234", password_confirmation: "password1234"},
  {name: "Francene Hirthe", email: "timika@brakuswiza.com", password: "password1234", password_confirmation: "password1234"},
  {name: "Clarine Streich", email: "sammy@zboncakwintheiser.co.uk", password: "password1234", password_confirmation: "password1234"},
  {name: "Eusebia Goldner", email: "nellie@hettinger.ca", password: "password1234", password_confirmation: "password1234"},
  {name: "Vida Wolf", email: "yoshiko@torpdooley.us", password: "password1234", password_confirmation: "password1234"},
  {name: "Virgil Swift", email: "elayne@abernathymuller.co.uk", password: "password1234", password_confirmation: "password1234"},
  {name: "Jewell White", email: "nelly@pfannerstill.us", password: "password1234", password_confirmation: "password1234"},
  {name: "Theresa Lakin", email: "ronald@goodwin.co.uk", password: "password1234", password_confirmation: "password1234"},
  {name: "Danette Kunde", email: "tyrell.tremblay@pacocha.info", password: "password1234", password_confirmation: "password1234"},
  {name: "Eliana Green", email: "shanell_gibson@botsford.info", password: "password1234", password_confirmation: "password1234"},
  {name: "Domonique Littel", email: "jacinta_beer@witting.us", password: "password1234", password_confirmation: "password1234"},
  {name: "Daine McCullough", email: "esperanza@eichmann.us", password: "password1234", password_confirmation: "password1234"},
  {name: "Andrew Von", email: "priscila@greenholtterry.ca", password: "password1234", password_confirmation: "password1234"}
]
# by default the raiting, wins and loses attrs are 1000, 0 and 0 respectively
player_attributes.each { |player| Player.create(player) }

# Matches
players = Player.all
matches_attributes = [
  {winner: players[1], loser: players[2], :winner_score=>23, :loser_score=>21},
  {winner: players[3], loser: players[4], :winner_score=>24, :loser_score=>22},
  {winner: players[6], loser: players[5], :winner_score=>21, :loser_score=>19},
  {winner: players[1], loser: players[7], :winner_score=>22, :loser_score=>20},
  {winner: players[2], loser: players[10], :winner_score=>23, :loser_score=>21},
  {winner: players[5], loser: players[6], :winner_score=>24, :loser_score=>22},
  {winner: players[11], loser: players[8], :winner_score=>21, :loser_score=>19},
  {winner: players[2], loser: players[2], :winner_score=>22, :loser_score=>20},
  {winner: players[1], loser: players[14], :winner_score=>23, :loser_score=>21},
  {winner: players[9], loser: players[7], :winner_score=>24, :loser_score=>22},
  {winner: players[7], loser: players[8], :winner_score=>21, :loser_score=>19},
  {winner: players[8], loser: players[5], :winner_score=>22, :loser_score=>20},
  {winner: players[6], loser: players[9], :winner_score=>23, :loser_score=>21},
  {winner: players[3], loser: players[11], :winner_score=>24, :loser_score=>22},
  {winner: players[12], loser: players[1], :winner_score=>21, :loser_score=>19},
  {winner: players[11], loser: players[3], :winner_score=>22, :loser_score=>20},
  {winner: players[4], loser: players[12], :winner_score=>23, :loser_score=>21},
  {winner: players[4], loser: players[0], :winner_score=>24, :loser_score=>22},
  {winner: players[10], loser: players[4], :winner_score=>21, :loser_score=>19},
  {winner: players[4], loser: players[1], :winner_score=>22, :loser_score=>20},

]

matches_attributes.each { |match| Match.create(match) }
