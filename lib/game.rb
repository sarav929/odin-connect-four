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
    row = @board.length - 1

    while row >= 0 do
      if @board[row][col] == ' '
        @board[row][col] = @current_player.symbol

        check_win(row, col)
        check_tie
        switch_player

        return
      end
      row -= 1
    end
  end

  def switch_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  def check_win(row, col)
    symbol = @board[row][col]

    return false if symbol == " "

    directions = [
      [0, 1],  # Horizontal
      [1, 0],  # Vertical
      [1, 1],  # Diagonal /
      [1, -1]  # Diagonal \
    ]

    if directions.any? { |dir| count_consecutive(row, col, dir[0], dir[1], symbol) >= 4 }
      @winner = @current_player
      puts "Congrats #{@winner.name} (#{@winner.symbol}) YOU WON!"
      true
    else
      false
    end

  end

  def count_consecutive(row, col, row_dir, col_dir, symbol)
    count = 1
    count += count_direction(row, col, row_dir, col_dir, symbol)
    count += count_direction(row, col, -row_dir, -col_dir, symbol)
    return count
  end

  def count_direction(row, col, row_dir, col_dir, symbol)
    count = 0
    current_row = row + row_dir
    current_col = col + col_dir
    while current_row.between?(0, @row - 1) && current_col.between?(0, @col - 1) && @board[current_row][current_col] == symbol
      count += 1
      current_row += row_dir
      current_col += col_dir
    end
    return count
  end

  def check_tie
    full_board = @board.all? { |row| row.all? { |cell| cell != " " } }
    if full_board && @winner.nil?
      puts "It's a tie!"
      return true
    end
  end
end