# emcoding: utf-8

module DiceGame
	class Game
		def initialize
		name = ask("What's your name?", "Invalid name") {|a| a.length >= 3 } 
		p "Hi, #{name}, let's play!"
		age = ask("How old are you?", "You must be 18") {|a| a.to_i >= 18 } 
		@first_player = DiceGame::Player.new(name, age)
		@second_player = DiceGame::Player.new("Robot", 42)
		@dice = DiceGame::Roller.new(2,6)
		play
		end

		private

		def winner
			@first_player.score >= 5 || @second_player.score >= 5

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
			until winner
				answer = ask("Do you wanna roll the dices or quit the game?", "Please, enter 'roll' or 'quit'") {|a| a == "roll" || a == "quit"}
				if answer == "quit"
					exit
				else
					makeroll @first_player
					makeroll @second_player										
				end
			end
			p "PARABÉNS!! O GANHADOR É #{winner_player}"
		end

		def winner_player
			if @first_player.score >= 5
				@first_player.name
			else
				@second_player.name
			end
		end

		def makeroll(user)
			score = @dice.roll
			result = score.odd? ? -1 : 1
			user.score += result
			p "#{user.name} rolou: #{score} e o seu placar atual é #{user.score}"
		end
 
		

	end
end
