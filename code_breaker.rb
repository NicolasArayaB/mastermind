# frozen_string_literal: true

class CodeBreaker
  include Setup
  
  attr_accessor :turn

  def initialize
    @turn = 10
    @code = Code.new.code
    code_breaker
  end

  def playing
    if @turn == 10
      start
      @turn -= 1 
      self.guessing_turn
    elsif @turn == 0
      Game.lose?
      lose
      again
      Game.again
    else
      @turn -= 1
      self.guessing_turn
    end
  end

  def guessing_turn
    puts "Try to guess, give me four digits"
    guess_code = gets.chomp
    valid_guess(guess_code)
  end

  def valid_guess(guess_code)
    if guess_code.length == 4
      guess = guess_code.to_s.split("")
      code_eval(guess)
    else
      puts "The code have four digits, you should now that already"
      guessing_turn
    end
  end

  def code_eval(guess)
    if guess.eql?(@code)
      win
      again     
    else
      self.correct(guess)
      self.incorrect_position(guess)
      self.result
      playing
    end
  end

  def correct(guess)
    @a_count = 0
    i = 0

    while i < guess.length
      if @code[i] == guess[i]
        @a_count += 1
        i += 1
      else
        i += 1
      end
    end
  end

  def incorrect_position(guess)
     matches = @code.select{ |digit| guess.include?(digit) }.size
     @b_count = matches - @a_count
  end

  def result
    puts "#{@a_count} in position"
    puts "#{@b_count} match but in wrong position"
  end
end
