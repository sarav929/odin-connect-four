# frozen_string_literal: true

require 'rspec'
require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../main'

describe Player do
  describe "#initialize" do
    let(:player) { Player.new("Sara", "★") }
    it "initializes correctly with player's name and symbol" do
      expect(player.instance_variable_get(:@name)).to eq("Sara")
      expect(player.instance_variable_get(:@symbol)).to eq("★")
    end
  end
end

describe ConnectFour do

  describe "#initialize" do
    let(:new_game) { ConnectFour.new }

    it "initializes with 2 players and an empty 6x7 board" do
      expect(new_game.instance_variable_get(:@board)).to eq(Array.new(6) { Array.new(7, " ") })
      expect(new_game.instance_variable_get(:@player1)).not_to be(nil)
      expect(new_game.instance_variable_get(:@player2)).not_to be(nil)
    end
  end

  describe "#display_board" do
    subject(:game) { ConnectFour.new }

    it "displays the empty board correctly" do

      board_output = <<~BOARD
        | | | | | | | |
        ---------------
        | | | | | | | |
        ---------------
        | | | | | | | |
        ---------------
        | | | | | | | |
        ---------------
        | | | | | | | |
        ---------------
        | | | | | | | |
        ---------------
      BOARD

      expect { game.display_board }.to output(board_output).to_stdout
    end
  end

  describe "#move" do

    subject(:game) { ConnectFour.new }
    let(:board) { game.instance_variable_get(:@board) }

    context "when placing the first piece" do

      before do 
        game.move(3)
      end

      it "drops the piece in the lowest empty spot in column 3" do
        expect(board[5][3]).to eq("◯")
      end
    end

    context "when placing another piece on top of the previous one" do
      
      before do
        game.move(3)
        game.move(3)
      end

      it "drops the next piece on top of the previous one in column 3" do
        expect(board[4][3]).to eq("★")
      end
    end

    context "when switching players" do

      before do
        game.move(3) 
      end

      it "updates the current player for the next round" do
        expect(game.instance_variable_get(:@current_player)).to eq(game.instance_variable_get(:@player2))
      end
    end
  end

  describe "#check_win" do
    subject(:game) { ConnectFour.new }
    let(:board) { game.instance_variable_get(:@board) }
    

    context "when 4 horizontal slots have the same symbol" do

      before do
        game.instance_variable_set(:@current_player, game.player1)
        board[5][0..3] = ["◯", "◯", "◯", "◯"]
      end 

      it "announces the winner with 4 horizontal slots" do
        expect { game.check_win(5, 0) }.to output("Congrats Player One (◯) YOU WON!\n").to_stdout
      end
    end

    context "when 4 vertical slots have the same symbol" do

      before do
        game.instance_variable_set(:@current_player, game.player1)
        board[5][0] = "◯"
        board[4][0] = "◯"
        board[3][0] = "◯"
        board[2][0] = "◯"
      end

      it "announces the winner with 4 vertical slots" do
        expect { game.check_win(5, 0) }.to output("Congrats Player One (◯) YOU WON!\n").to_stdout
      end
    end

    context "when 4 diagonal slots have the same symbol" do
      before do
        game.instance_variable_set(:@current_player, game.player2)
        board[5][0] = "★"
        board[4][1] = "★"
        board[3][2] = "★"
        board[2][3] = "★"
      end
      it "announces the winner with 4 diagonal slots" do
        expect { game.check_win(2, 3) }.to output("Congrats Player Two (★) YOU WON!\n").to_stdout
      end
    end

    context "when no win conditions are met" do
      before do
        game.instance_variable_set(:@current_player, game.player2)
        board[5][0] = "★"
        board[4][1] = "★"
        board[3][2] = "★"
      end
      it "does not recognize a win and returns false" do
        expect(game.check_win(5, 0)).to be(false)
      end
    end
  end

  describe "#check_tie" do
    subject(:game) { ConnectFour.new }
    let(:board) { game.instance_variable_get(:@board) }
    context "when the board is full and there is no winner" do
      before do
        board.each do |row|
          row.map! { |cell| "★" }
        end
        game.instance_variable_set(:@winner, nil)
      end
      it "announces a tie when all slots are taken with no winner" do
        expect { game.check_tie }.to output("It's a tie!\n").to_stdout
      end
    end
  end
end