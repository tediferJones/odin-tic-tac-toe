# This is the game class
class Game
  attr_reader :player1

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_turn = @player1
    @board = (1..9).to_a
  end

  def display
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
      puts 'that spot is already taken, try again'
      switch_turns
    end
  end

  def take_turn
    # asks the user where they want their mark to go, then takes the value of that location_index and adds it to the player's
    # spots_taken attribute, then places the players @marker at the given location_index and calls changes current_turn with switch_turns
    puts "It is #{@current_turn.name}'s turn, where would you like your #{@current_turn.marker} to go? (Integer 1 - 9)"
    location_index = gets.chomp.to_i - 1
    if location_index > -1 && location_index < 9
      make_move(location_index)
    else
      puts "You chose poorly so we'll choose for you\n\n"
      random_location_index = rand(9)
      make_move(random_location_index)
    end
  end
end

# Creates a player with attribute name, marker, and spots_taken
class Player
  attr_reader :name, :marker, :spots_taken

  @@taken = nil

  def initialize
    @spots_taken = []
    puts 'Please Enter Your Name'
    @name = gets.chomp
    if @@taken.nil?
      puts 'Please Enter X or O for your marker'
      temp = gets.chomp.downcase
      if temp == 'x' || temp == 'o'
        @marker = temp
      else
        puts 'You chose poorly so now you are O'
        @marker = 'o'
      end
    else
      puts 'Since one of the markers is already taken we will chose for you'
      if @@taken == 'x'
        @marker = 'o'
      elsif @@taken == 'o'
        @marker = 'x'
      end
    end
    @@taken = @marker
  end
end

# Single command should get the game started by creating two instances of player, and creating an instance of game with those players
# it should call take_turn 9 times, checking for a winner after each turn.  If a winner is not determined after 9 turns, the game is a tie
class Play
  def initialize
    @@turn_counter = 0
    p1 = Player.new
    p2 = Player.new
    new_game = Game.new(p1, p2)

    while @@turn_counter < 9
      new_game.display
      new_game.take_turn
      new_game.switch_turns
      @@turn_counter += 1
    end
    if @@turn_counter == 9
      puts "IT WAS A TIE, YOU'RE BOTH SUCKERS"
    end
  end
end

win_sets = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9],
  [1, 4, 7],
  [2, 5, 8],
  [3, 6, 9],
  [1, 5, 9],
  [3, 5, 7]
]

idk = Play.new
