class Guess
    attr_accessor :input
    def initialize(input = 0)
        @input = input.to_i
    end

    def random_answer
        return rand(100)
    end

    def attempts
        puts "Please input your guess between 1 and 100. You have 5 guesses: "
        @input = gets.strip.to_i
        answer = random_answer
        x = 5
        loop do
            if (@input == answer)
                puts "Congratulations! You win! The answer was #{answer}!"
                break
            elsif (@input > answer)
                puts "Your guess of #{@input} is too high, you have #{x} guesses remaining."
                puts "Please enter your next Guess: "
                @input = gets.strip.to_i
            elsif (@input < answer)
                puts "Your guess of #{@input} is too low, you have #{x} guesses remaining."
                puts "Please enter your next Guess: "
                @input = gets.strip.to_i
            end
            x -= 1
            if x == 0
                puts "Sorry, you have no more guesses remaining"
                break
            end
        end
    end
end