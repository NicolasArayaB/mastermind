# frozen_string_literal: true

# Make diferent codes for each game.
class Code
  attr_accessor :code
  def initialize
    @new_code = Random.new
  end

  def code
    @new_code.rand.to_s[2..5].split("")
  end
end
