# emcoding: utf-8

module DiceGame
	class Game

		def initialize
		@first_player = create_player("FIRST")
		@second_player = create_player("SECOND")
		p "LET'S PLAY!!!"
		@dice = DiceGame::Roller.new(2,6)
		play
		end

		private

		def create_player(title)
			p "-----------------------------------------------------------"
			p "#{title} player"
			name = ask("What's your name?", "Invalid name") {|a| a.length >= 3 } 
			age = ask("How old are you?", "You must be 18") {|a| a.to_i >= 18 } 
			p "OK, First Player is #{name}, #{age} years old. Good luck!"
			p "-----------------------------------------------------------"
			DiceGame::Player.new(name, age)
		end

		def ask(question, wrong_answer, &block)
			p question
			while response = gets.chomp
				return response unless block_given?
				return response if block.call(response)
				p wrong_answer
				p question
			end
		end

		def play
			@odd_even = ask("#{@first_player.name}, do you wanna be the Even or the Odd Player? Type 'even' or 'odd'", "Please, enter 'even' or 'odd'") {|a| a == "even" || a == "odd"}
			odd_even
			p "OK. #{@first_player.name}, you're the #{@odd_even} player, and #{@second_player.name}, you are the #{@other} player."
			until winner
				answer = ask("Roll the dices or quit the game?", "Please, enter 'roll', 'quit' or just hit enter") {|a| a == "roll" || a == "quit" || a == ""}
				if answer == "quit"
					p "Hope to see you soon!"
					exit
				else
					makeroll								
				end
			end
			p "PARABÉNS, #{winner_player}, VOCÊ GANHOU!!"
		end

		def odd_even
			@other = (@odd_even == "even") ? "odd" : "even"
		end

		def winner
			@first_player.score >= 5 || @second_player.score >= 5
		end
		
		def winner_player
			if @first_player.score >= 5
				@first_player.name
			else
				@second_player.name
			end
		end

		def makeroll
			score = @dice.roll
			if @odd_even == "odd" && score.odd?
				@first_player.score += 1
			elsif @odd_even == "odd" && score.even?
				@second_player.score += 1
			elsif @odd_even == "even" && score.even?
				@first_player.score += 1
			else 
				@second_player.score += 1
			end
			p "-----------------------------------------------------------"
			p "The number is #{score}"
			p "#{@first_player.name}, your score is  #{@first_player.score}"
			p "#{@second_player.name}, your score is #{@second_player.score}"
			p "-----------------------------------------------------------"
		end

	end
end