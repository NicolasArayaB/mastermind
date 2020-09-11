# frozen_string_literal: true

class CodeMaker
  attr_accessor :turn

  include Setup

  def initialize
    @turn = 10
    code_maker
    @code = gets.chomp.split("")
  end

  def playing
    if turn == 0
      win
    else
      @turn -= 1
      self.guessing_turn
    end
  end

  def guessing_turn
    
  end
end

