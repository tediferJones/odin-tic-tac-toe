# frozen_string_literal: true

# This is the game class
class Game
  attr_reader :game_won, :current_turn

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_turn = [@player1, @player2].sample
    puts "\n#{@current_turn.name} gets to go first!"
    @board = (1..9).to_a
    @game_won = false
  end

  def win_test(spots_taken)
    win_sets = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    win_sets.each do |win_set|
      test_set = []
      win_set.each do |win_location|
        test_set << spots_taken.any?(win_location)
      end
      @game_won = true if test_set.all?
    end
  end

  def display
    puts "\n"
    @board.each_index do |index|
      if [2, 5].include?(index)
        print " #{@board[index]} \n-----------\n"
      elsif index == 8
        print " #{@board[index]} \n"
      else
        print " #{@board[index]} |"
      end
    end
  end

  def switch_turns
    # changes the value of @current_turn to the other Player
    if @current_turn == @player1
      @current_turn = @player2
    elsif @current_turn == @player2
      @current_turn = @player1
    end
  end

  def make_move(location_index)
    if @board[location_index].is_a? Integer
      @current_turn.spots_taken << @board[location_index]
      @board[location_index] = @current_turn.marker
    else
      puts "\nSorry #{@current_turn.name} that spot is already taken, try again\n"
      take_turn # calls take_turn recursively to prevent turn_counter in Class Play from incrementing based on an incorrect move
    end
  end

  def take_turn
    # asks the user where they want their mark to go, then takes the value of that location_index and adds it to the
    # player's spots_taken attribute, then places the player's @marker at the given location_index and changes
    # current_turn with switch_turns
    puts "\nIt is #{@current_turn.name}'s turn, where would you like your #{@current_turn.marker} to go? (Integer 1 - 9)"
    location_index = gets.chomp.to_i - 1
    if location_index > -1 && location_index < 9
      make_move(location_index)
    else
      useable_locations = []
      puts "You chose poorly so we'll choose for you\n"
      @board.each { |location_value| useable_locations << location_value if location_value.is_a? Integer }
      make_move(useable_locations.sample - 1)
    end
    win_test(@current_turn.spots_taken)
  end
end

# Creates a player with attribute name, marker, and spots_taken
class Player
  attr_reader :name, :marker
  attr_accessor :spots_taken

  @@taken = nil

  def initialize
    @spots_taken = []
    puts 'Please Enter Your Name'
    @name = gets.chomp.capitalize

    if @@taken.nil?
      puts 'Please Enter X or O for your marker'
      temp = gets.chomp.upcase
      if %w[X O].include?(temp)
        @marker = temp
      else
        puts 'You chose poorly so now you are O'
        @marker = 'O'
      end
    else
      puts 'Since one of the markers is already taken we will chose for you'
      case @@taken
      when 'X'
        @marker = 'O'
      when 'O'
        @marker = 'X'
      end
    end
    @@taken = @marker
    puts "Hi #{@name}, you mark is #{@marker}"
  end
end

def play(player1, player2)
  turn_counter = 0
  new_game = Game.new(player1, player2)

  while turn_counter < 9 && new_game.game_won == false
    new_game.display
    new_game.take_turn
    new_game.switch_turns
    turn_counter += 1
  end

  if new_game.game_won == true
    new_game.switch_turns
    new_game.display
    puts "\nTHE WINNER IS #{new_game.current_turn.name.upcase}\n"
  elsif turn_counter == 9
    puts "\nIT WAS A TIE, YOU'RE BOTH SUCKERS\n"
  end

  puts "\nWould you like a rematch? Press ENTER to continue, or type EXIT and press Enter to quit the program"
  return unless gets == "\n"

  player1.spots_taken = []
  player2.spots_taken = []
  play(player1, player2)
end

first_player = Player.new
second_player = Player.new
play(first_player, second_player)
