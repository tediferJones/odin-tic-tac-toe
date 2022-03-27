# This is the game class
class Game
  attr_reader :player1

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_turn = @player1
    #@board = Array.new(3) { Array.new(3, '-') }
    @board = (1..9).to_a
    p @board
  end

  def display
    # OBSOLETE (hopefully)
    # generates current board  user

    row_count = 0
    board.each do |row|
      item_count = 0
      row.each do |item|
        if item_count < 2
          print "#{item} | "
          item_count += 1
        else
          print item.to_s
        end
      end

      if row_count < 2
        print "\n---------\n"
      else
        print "\n"
      end
      row_count += 1
    end
  end

  def display2
    @board.each do |item|
      if [3, 6].include?(item)
        print " #{item} \n-----------\n"
      elsif item == 9
        print " #{item} \n"
      else
        print " #{item} |"
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

  def place_mark
    # think about making a player class with data for name and marker type ("x" or "o") and a method for making moves
  end

  def play
    # maybe this should be its own class or function that initiates two players and then starts the game
  end
end

# Creates a player with attribute name and marker
class Player
  attr_reader :name, :marker

  @@taken = nil

  def initialize
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

this_game = Game.new('ted', 'bed')
this_game.display2
#ted = Player.new
#bob = Player.new
#new_game = Game.new(ted, bob)
#p new_game.player1


#p ted.name
#p ted.marker

#this_game.display
#this_game.switch_turns
#this_game.switch_turns
