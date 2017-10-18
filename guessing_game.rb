class Guess
    attr_accessor :input

    def initialize(input = 0)
        @input = input.to_i
    end

    def random_answer
        rand(100)
    end

    def attempts
        puts "Please input your guess between 1 and 100. You have 5 guesses:"
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


# Comments:
# 01. Ruby code usually indent with 2 spaces, instead of 4.
# 02. Ruby implicitly return anything that is the last line of the method/block. So the keyword 'return'
#     is rarely used. In fact, it is only used when you want to return early.
# 03. I don't see the need to have input as attr_accessor. User input can be a local variable inside your
#     #attepmt method. Keep every variable in a minimum scope.
# 04. If you have attr_accessor defined, use it like: `self.input = ...` for assignment, and just `input`
#     for reading the value of it. Instance variables (@input) are used when you don't want to define 
#     attr_accessor/attr_reader/attr_writer.
# 05. More on differences between `@input` and `attr_accessor :input`:
#     - `@input` is visible inside the class, accross all methods. You can't access it from outside of class.
#     - `attr_accessor` 
#     - attr_accessor is actually a meta-method that defines two methods on class instances, and they are
#       visible from outside of class. E.g. if you have `attr_accessor :input`, it will define these two
#       public methods for you:
#
#         def input=(input)
#           @input = input
#         end
#
#         def input
#           @input
#         end
#
# 06. I also don't see the need to initialise @input. IMO initialising the answer and lives left makes
#     more sense.
# 07. Variable naming `x` is not very good.
# 08. In your flow control, it's not a correct place to do `x -= 1`. You're using x to prompt player
#     before self-decrementing.
# 09. `@input = gets.strip.to_i` needs to handle malicious input. In ruby, `"abc".to_i` gives us 0,
#     so we need some code to ask for a re-input if the user input is not integer. Possibly use regex
#     matching.
# 10. It could be better designed for when to get the user input. You have 3 of `@input = gets.strip.to_i`.
# 11. Try to use whitespaces to make the code more readable. Whitespaces are hard. Here is a quote from 
#     devtrain channel, which I think is great:


#   Never put a new line at the top of a scope
#     So that you can see the structure of the tree
#
#     Always put new lines between things on the same level with different responsibilities
#
#     But if you have some things that are alike
#
#     Like
#       This
#       And that
#       Or this
#     Y'know
#
#     Then put them together to make it clear
#
#     Same as the top, no empty lines at the bottom
#   Whitespace is our friend, be liberal


# This is what I'd do if I was to write it:

class AnotherGuess
  attr_accessor :answer, :lives_left

  def initialize
    self.answer = rand(100)
    self.lives_left = 5
  end

  def run_game
    puts "Please input your guess between 1 and 100. You have 5 guesses:"
    
    loop do
      user_input = gets

      # Here we need some code to repeatedly asking for re-input if user_input is not integer
      # Ideally we can also ask for re-input if user_input <= 0 || user_input >= 100
      
      # Assume after this point, user_input is a integer between 0 and 100.

      if user_input == answer
        puts "Congratulations! You win! The answer was #{answer}!"
        break
      end

      puts "Your guess of #{user_input} is too #{user_input > answer ? "high" : "low"}."
      self.lives_left = lives_left - 1

      if lives_left <= 0
        puts "Sorry, you have no more guesses remaining, game over."
        puts "The magic number is #{answer}."
        break
      end

      puts "You have #{lives_left} guesses remaining, please enter your next Guess: "
    end
  end
end

AnotherGuess.new.run_game
