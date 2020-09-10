# frozen_string_literal: true

# A game with unknown number of plays.
class Game
  attr_reader :num_of_plays 
  attr_accessor :comp_wins, :player_wins

  def initialize(num_of_plays)
    @num_of_plays = num_of_plays
    @@comp_wins = 0
    @@player_wins = 0
  end

  # Start a new game
  def self.setup
    puts "    ---------------\n\n  Welcome to Matermind!\n\n    ---------------\n"
    puts "How many games would you like? One? Three? More?: "
    num_of_plays = gets.chomp.to_i
    Game.odd_num(num_of_plays)
    for i in (1..num_of_plays)
      play = Plays.new(num_of_plays)
      play.playing
    end
  end

  # Determine how many games.
  def self.odd_num(num_of_plays)
    if num_of_plays.odd?
      puts "You will have 10 turns to beat me! It won't be easy!"
      new_game = Game.new(num_of_plays)
    else
      puts "You must enter an odd number. Are you scared of me? Let's start over"
      Game.setup
    end
  end
end

class Plays < Game
  attr_accessor :turn

  def initialize(num_of_plays)
    @plays = num_of_plays
    @turn = 10
    @status = "playing"
    @code = Code.new.code
    p @code
  end

  def playing
    until @status == "end"
      puts "Let's go!"
      if @turn == 0
        @@comp_wins += 1
        puts "You lose!"
      else
        self.guessing_turn
        @turn -= 1
      end
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
    a_count = 0
    b_count = 0
    if guess.eql?(@code)
      @@player_wins += 1
      @status = "end"
      puts "You got it! The score is: #{@@player_wins} - #{@@comp_wins}"      
    else
      i = 0
      while i < guess.length
        a_count += 1 if @code[i] == guess[i]
        i += 1
        b_count += 1 if @code.include?(guess[i])
      end
      puts "#{a_count} in position"
      puts "#{b_count} match but in wrong position"
    end      
  end
end

# Make diferent codes for each game.
class Code < Game
  attr_accessor :code
  def initialize
    @new_code = Random.new
  end

  def code
    @new_code.rand.to_s[2..5].split("")
  end
end

Game.setup
