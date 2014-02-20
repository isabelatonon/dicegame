module DiceGame
class Roller
	def initialize(dices, sides)
		@dices = dices
		@sides = sides
	end

	def roll
		the_array = []
		for i in 1..@dices	
			the_array << Random.new.rand(1..@sides)
		end
		result = the_array.inject(:+)	
	end




end
end
