require_relative 'player.rb'

class ConnectFour
  attr_accessor :row, :col, :board, :player1, :player2, :turn
  def initialize
    @row = 6
    @col = 7
    @board = Array.new(@row) {Array.new(@col, " ")}

    @player1 = Player.new("Player One", "◯")
    @player2 = Player.new("Player Two", "★")
    @turn = 1
    @current_player = @player1
    @winner = nil
  end

  def display_board
    @board.each do |row|
      puts "|" + row.join("|") + "|"
      puts "-" * (@col * 2 + 1)
    end
  end

  def move(col)
    symbol = @current_player.symbol
    @board.reverse_each do |row|
      if row[col] == " "
        row[col] = symbol
        break
      end      
    end
    @turn += 1
    switch_player
  end

  def switch_player
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def check_win(row, col)
    

  end

  def check_tie
    full_board = @board.all? { |row| row.all? { |cell| cell != " " } } 

    if full_board && @winner.nil?
      puts "It's a tie!" 
      return true
    end

  end
end