#frozen_string_literal: true

class Display
  def rules
  end
  def board_state
  end
end

class AI
  def generate_code
    return arr = [ rand(6)+1, rand(6)+1, rand(6)+1, rand(6)+1 ]
  end
end

class State
  def initialize(maker)
    @maker = maker
    @secret = []
  end
  def new_code
    unless @maker == "1"
      @secret = AI.new.generate_code
    end
  end
  def make_guess
    puts "Guess 4 numbers ranging from 1-6:"
    begin
      input = gets
      input = input.strip
      unless input.length == 4; raise; end
      guess = []
      j = 0
      input.each_char do |i|
        i = i.to_i
        unless (1..6) === i; raise; end
        guess[j] = i
        j += 1
      end
      guess_check(guess)
    rescue
      puts "Unknown response. Please enter 4 numbers ranging from 1-6:"
      retry
    end
  end
  def guess_check(guess)
    unless guess == @secret
      j = 0
      position[4] = []
      guess.each do |i|
        if i == @secret[j]
          position[j] = 1
        end
        j += 1
      end
      j = 0
      position.each do |i|
        if i == 0
          
        end
      end
    end
  end
end

def game_start
  display_object = Display.new
  begin
    choice = gets
    unless ("1".."2") === choice; raise; end
    current_game = State.new(choice)
  rescue
    puts "Unknown response. Please select 1 for Maker or 2 for Breaker."
    retry
  end
  current_game.new_code
  current_game.make_guess
end

game_start


