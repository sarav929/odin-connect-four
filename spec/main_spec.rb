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
      expect(new_game.instance_variable_get(:@board)).to eq(Array.new(6) {Array.new(7)})
      expect(new_game.instance_variable_get(:@player1)).not_to be(nil)
      expect(new_game.instance_variable_get(:@player2)).not_to be(nil)
    end
  end
end


      


