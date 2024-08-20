require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../main'
require 'rspec'

# frozen_string_literal: true

describe Player do
  describe "#initialize" do
    let(:player) { Player.new("Sara", "★")} 
    it "initialize correctly player's name and symbol" do
      expect(player.instance_variable_get(:@name)).to eq("Sara")
      expect(player.instance_variable_get(:@symbol)).to eq("★")
    end
  end
end

describe ConnectFour do

  describe "#initialize" do

    let(:new_game) { ConnectFour.new }

    it "initialize with 2 players and empty 6x7 board" do
      expect(new_game.instance_variable_get(:@board)).to eq(Array.new(6) {Array.new(7, " ")})
      expect(new_game.instance_variable_get(:@player1)).not_to be(nil)
      expect(new_game.instance_variable_get(:@player2)).not_to be(nil)
    end

  end
end

describe ConnectFour do

  subject(:game) { ConnectFour.new }

  describe "#display_board" do
    it "displays empty board correctly" do
      board = <<~BOARD
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
      expect {game.display_board}.to output(board).to_stdout
    end

    describe "#move" do

      context "when placing the first piece" do
        before do
          game.move(3)
        end
        it "piece is dropped in the lowest empty spot in column 3" do
          expect(board[5][3]).to eq("◯")
        end
      end

      context "when placing another piece on top of the previous" do
        before do
          game.move(3)  
          game.move(3)  
        end
        it "next piece is dropped on top of the previous in column 3" do
          expect(board[4][3]).to eq("★")
        end
      end

      context "when switching players" do
        before do
          game.move(3)  
        end
        it "updates current player in the next round" do
          expect(game.instance_variable_get(:@current_player)).to eq(game.instance_variable_get(:@player_two))
        end
      end
      
    end
  end


end


      


