# frozen_string_literal: true

module Setup
    def welcome
      block
      puts "    ---------------\n"
      puts "Welcome to Matermind!\n"
      puts "    ---------------\n"
      block
    end

    def block
      puts ""
    end

    def instructions
      puts "You can choose to be the CodeBreaker or the CodeMaker."
      puts "If you want to breake the code, you will have 10 turns too get it done"
    end

    def ask_game_modes
      puts "Do you want to be the CodeBreaker(1) or the CodeMaker(2)?"
    end

    def valid_mode?(mode)
      mode = 1 ||  mode = 2 ? true : false
    end

    def code_breaker
      block
      puts "You are the CodeBraker!"
      puts "Let's see if you can beat me!"
    end

    def code_maker
      puts "You are the CodeMaker!"
      puts "Write your code, it must have four digits"
    end

    def start
      puts "The code is made of four digits, between 0 and 9. Let's go!"
      block
    end

    def win
      block
      puts "You're the winner!"
    end

    def lose
      block
      puts "You lose!"
    end

    def again
      block
      puts "Do you want to play again? Yes?(y), No?(n)"
    end
end
