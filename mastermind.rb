#frozen_string_literal: true

class Display
  def rules
  end
  def board_state(guess, pos = nil, num = nil)
    guess.each do |i|
      case i
      when 1
        print "\e[41m #{i} \e[0m"
      when 2
        print "\e[42m #{i} \e[0m"
      when 3
        print "\e[43m #{i} \e[0m"
      when 4
        print "\e[44m #{i} \e[0m"
      when 5
        print "\e[45m #{i} \e[0m"
      when 6
        print "\e[47m #{i} \e[0m"
      end
    end
    print " "
    pos.each do |i|
      if i == 1
        print "\u2022"
      end
    end
    num.each do |i|
      if i == 1
        print "\u25E6"
      end
    end
    print "\n"
  end
end

class AI
  def generate_code
    return arr = [ rand(6)+1, rand(6)+1, rand(6)+1, rand(6)+1 ]
  end
  def guess
  end
end

class State
  def initialize(maker)
    @secret = []
    @maker = maker
  end
  def new_code
    unless @maker == "1"
      @secret = AI.new.generate_code
    else
      print @maker
      puts "Enter a secret code of 4 numbers ranging from 1-6"
      @secret = code_input
    end
  end
  def code_input
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
      return guess
    rescue
      puts "Unknown response. Please enter 4 numbers ranging from 1-6:"
      retry
    end
  end
  def guess_check(guess)
      j = 0
      cor_pos = []
      cor_num = []
      guess.each do |i|
        if i == @secret[j]
          cor_pos[j] = 1
        else
          for k in (0..3)
            if @secret[k] == i && cor_pos[k] == nil && k != j
              cor_num[j] = 1
            end
          end
        end
        j += 1
      end
      Display.new.board_state(guess, cor_pos, cor_num)
  end
  def driver
    unless @maker == "1"
      12.times do
        puts "Guess 4 numbers ranging from 1-6:"
        guess = code_input
        unless guess == @secret
          guess_check(guess)
        else
          puts "You Win!\nWould you like to play again? y/n"
          response = gets.chomp
          unless response == "y"
            exit
          else
            game_start
          end
        end
      end
      Display.new.board_state(@secret)
    else
      AI.new.guess
    end
  end
end

def game_start
  puts "Enter 1 to be the Code Maker and have the computer guess, or 2 to be
the Code Breaker and have the computer make the code."
  begin
    choice = gets.chomp
    unless ("1".."2") === choice; raise; end
    current_game = State.new(choice)
  rescue
    puts "Unknown response. Please select 1 for Maker or 2 for Breaker."
    retry
  end
  current_game.new_code
  current_game.driver
end

Display.new.rules
game_start

