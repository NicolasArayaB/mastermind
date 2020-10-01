# frozen_string_literal: true

class CodeMaker
  attr_accessor :turn, :x, :y
  
  include Setup

  def initialize
    @turn = 10
    code_maker
    @code = gets.chomp.chars
    @guessing_code = "1122".chars
    colors = "123456".chars
    @posible_answers = colors.product(*[colors] * 3).map(&:join)
  end

  def playing
    if @turn == 0
      win
      again
    else
      @turn -= 1
      self.guessing_turn
    end
  end

  def guessing_turn
    sleep 0.8
    puts "\nLet's see..."
    sleep 1
    puts "Mmmm..."
    sleep 1.5
    puts "Is it:\n #{@guessing_code}?"
    self.guess
  end

  def guess
    if @guessing_code.eql?(@code)
      lose
      again
    else
      self.correct(@guessing_code)
      self.incorrect_position(@guessing_code)
      self.result
      self.reduce_options
      self.next_guess
      playing
    end
  end

  def correct(guess)
    @a_count = 0
    i = 0
    @code
    while i < guess.size
      if @code[i].to_i == guess[i].to_i
        @a_count += 1
        i += 1
      else
        i += 1
      end
    end
  end

  def incorrect_position(guess)
    @matches = @code.select{ |digit| guess.include?(digit) }.size
    if @matches > @a_count
      @b_count = @matches - @a_count
    elsif @matches == @a_count
      @b_count = 0
    elsif @matches < @a_count
      @b_count = @a_count - @matches
    end
  end

  def result
    sleep 2
    puts "\n#{@a_count} in position"
    puts "#{@b_count} match but in wrong position"
  end
end

def reduce_options    
  new_posibles = []
  i = 0

  if @matches == 0
    reject_posibles = @guessing_code.to_a.uniq!
    while i < reject_posibles.size
      new_posibles[i] = @posible_answers.reject { |p_a| p_a.to_s.include?(reject_posibles[i]) }
      i += 1
    end
    @posible_answers = new_posibles.flatten
  elsif @matches < 4
    combinations = @guessing_code.combination(@matches).to_a.uniq!
    if combinations != nil
      while i < combinations.size
        combinations[i].join("")
        new_posibles[i] = @posible_answers.select { |p_a| p_a.to_s.include?(combinations[i].join("")) }
        i += 1
      end
    else
      @posible_answers.shift
    end

    @posible_answers = new_posibles.flatten
  end
end

def next_guess
  if @guessing_code != @posible_answers[0].to_s.scan(/\d/)
    @guessing_code = @posible_answers[0].to_s.scan /\d/
  else
    @posible_answers.shift
    @guessing_code = @posible_answers[0].to_s.scan /\d/
  end
end
