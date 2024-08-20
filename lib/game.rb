require_relative 'player.rb'

class ConnectFour
  
  def initialize
    @row = 6
    @col = 7
    @board = Array.new(@row) {Array.new(@col)}

    @player1 = Player.new("Player One", "◯")
    @player2 = Player.new("Player Two", "★")
    @@turn = 1
  end
end