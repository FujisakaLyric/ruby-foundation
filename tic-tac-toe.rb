module BoardFunctions
    def play_piece
        if @current_player == @player_one.name
            @array[gets.chomp.to_i - 1] = "X"
            @current_player = @player_two.name
        else
            @array[gets.chomp.to_i - 1] = "O"
            @current_player = @player_one.name
        end
    end

    def check_horizontal
        if (@array[0] == @array[1] && @array[1] == @array[2])
            return display_winner(@array[0])   
        elsif (@array[3] == @array[4] && @array[4] == @array[5])
            return display_winner(@array[3]) 
        elsif (@array[6] == @array[7] && @array[7] == @array[8])
            return display_winner(@array[6]) 
        end
        false
    end

    def check_vertical
        if (@array[0] == @array[3] && @array[3] == @array[6])
            return display_winner(@array[0])           
        elsif (@array[1] == @array[4] && @array[4] == @array[7])
            return display_winner(@array[1])  
        elsif (@array[2] == @array[5] && @array[5] == @array[8])
            return display_winner(@array[2])    
        end
        false
    end

    def check_diag
        if (@array[0] == @array[4] && @array[4] == @array[8])
            return display_winner(@array[0])
        elsif (@array[2] == @array[4] && @array[4] == @array[6])
            return display_winner(@array[2])
        end
        false
    end

    def display_winner(piece)
        if (piece == "X")
            puts "#{@player_one.name} wins!"
        else
            puts "#{@player_two.name} wins!"
        end
        return true
    end
end

class Player
    attr_reader :name
    def initialize(name)
        @name = name
    end
end

class Board
    include BoardFunctions

    attr_reader :is_playing
    def initialize
        @array = ["1", "2", "3", "4", "5", "6", "7", "8" , "9"]
        @is_playing = true
        @round_counter = 0
        puts "Enter the name of Player 1"
        @player_one = Player.new(gets.chomp)
        puts "Welcome #{@player_one.name}! You are X"
        puts "Enter the name of Player 2"
        @player_two = Player.new(gets.chomp)
        puts "Welcome #{@player_two.name}! You are O"
        puts "Let's Play!"
        @current_player = @player_one.name
        display_board
    end

    def play_turn
        puts "It's #{@current_player}'s turn! Choose a number from 1-9 to place your piece."
        play_piece
        @round_counter += 1
        display_board

        #Win Condition
        if (check_diag || check_horizontal || check_vertical)
            @is_playing = false
        end

        #GameOver Condition
        if (@round_counter == 9)
            @is_playing = false
            puts "It's a draw!"
        end
    end

    private
    def display_board
        puts ""
        puts " #{@array[0]} | #{@array[1]} | #{@array[2]}"
        puts "---+---+---"
        puts " #{@array[3]} | #{@array[4]} | #{@array[5]}"
        puts "---+---+---"
        puts " #{@array[6]} | #{@array[7]} | #{@array[8]}"
        puts ""
    end
end

tic_tac_toe = Board.new

while (tic_tac_toe.is_playing == true) do
    tic_tac_toe.play_turn
end