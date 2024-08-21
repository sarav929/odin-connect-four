require_relative 'lib/game'
require_relative 'lib/player'

def play(game)
  puts "Let's play Connect Four!"
  puts "\n"
  game.display_board

  while game.winner.nil? 
    puts "\nIt's #{game.current_player.name}'s turn - type a number between 1 and 7 to drop your piece:\n"
    while true 
      col = gets.chomp.to_i - 1
      if col.between?(0, 6)
        break
      end
      puts "\nInvalid input - enter a valid number between 1 and 7:"
    end
    game.move(col)  
  end
end

game = ConnectFour.new
play(game)




