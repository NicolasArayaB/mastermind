# frozen_string_literal: true

require_relative "./settings.rb"
require_relative "./code_breaker.rb"
require_relative "./code_maker.rb"
require_relative "./code.rb"

# A game with unknown number of plays.
class Game
  include Setup

  def initialize
    welcome
    instructions
    @lose = false
    @game_mode = game_modes
    @game_mode.playing
    Game.again
  end

  def game_modes
    ask_game_modes
    mode = gets.chomp.to_i
    valid_mode?(mode)
    if mode == 1
      CodeBreaker.new 
    elsif mode == 2
      CodeMaker.new
    else
      game_modes
    end
  end

  def self.lose?
    @lose = true
  end

  def self.again
    play_again = gets.chomp.downcase
    if play_again == "y"
      Game.new
    else
      puts "------------"
      puts " GAME OVER!"
      puts "------------"
    end
  end
end
