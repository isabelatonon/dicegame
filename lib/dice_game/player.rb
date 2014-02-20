module DiceGame
	class Player
		attr_reader :name, :age
		attr_accessor :score

		def initialize(name, age)
			@name = name
			@age = age
			@score = 0
		end

		def add_score

		end
	end
	
end