# frozen_string_literal: true

class CodeMaker
  attr_accessor :turn, :x, :y
  

  include Setup

  def initialize
    @turn = 10
    code_maker
    @code = gets.chomp.scan /\d/
    @guessing_code = "1122".scan /\d/
    @posible_answers = (1111...6666).to_a
  end

  def playing
    if @turn == 0
      win
    else
      @turn -= 1
      self.guessing_turn
    end
  end

  def guessing_turn
    puts "Let's see..."
    puts "Mmmm..."
    puts "Is it:\n #{@guessing_code}?"
    self.guess
  end

  def guess
    if @guessing_code.eql?(@code)
      win
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
    p @code
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
      puts "#{@matches} - #{@a_count} m > a"
    elsif @matches == @a_count
      @b_count = 0
      puts "#{@matches} = #{@a_count}"
    elsif @matches < @a_count
      @b_count = @a_count - @matches
      puts "#{@a_count} - #{@matches} a > m"
    end
  end

  def result
    puts "#{@a_count} in position"
    puts "#{@b_count} match but in wrong position"
  end
end

def reduce_options    
  new_posibles = []
  i = 0

  if @matches == 0
    reject_posibles = @guessing_code.to_a.uniq!
    p "#{reject_posibles} r_p matches = 0"
    while i < reject_posibles.size
      new_posibles[i] = @posible_answers.reject { |p_a| p_a.to_s.include?(reject_posibles[i]) }
      i += 1
    end
    p @posible_answers = new_posibles.flatten
  else
    combinations = @guessing_code.combination(@matches).to_a.uniq!
    p "#{combinations} combinations"
    while i < combinations.size
      p combinations[i].join("")
      new_posibles[i] = @posible_answers.select { |p_a| p_a.to_s.include?(combinations[i].join("")) }
      i += 1
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
