# Зробити невелику скрипт гру "камень ножиці папір".
# На вхід передаємо предмет у вигляді аргументу командного рядка
# На виході результат
#
# EX:
# input --> ruby game.rb Stone Paper
# output --> You lose

# Масив можливих виборів
OPTIONS = ["Rock", "Paper", "Scissors"]

# Масив виграшних комбінацій
WINNING_COMBINATIONS = [["Rock", "Scissors"], ["Paper", "Rock"], ["Scissors", "Paper"]]

def rock_paper_scissors
  unless ARGV.length == 2
    puts "Game requires exactly 2 choices"
    exit
  end

  user_choice, opponent_choice = ARGV
  validate_choices(user_choice, opponent_choice)
  display_result(user_choice, opponent_choice)
end

def validate_choices(user_choice, opponent_choice)
  unless OPTIONS.include?(user_choice) && OPTIONS.include?(opponent_choice)
    puts "Invalid choices, options are Rock, Paper, or Scissors"
    exit
  end
end

def display_result(user_choice, opponent_choice)
  if user_choice == opponent_choice
    puts "It's a tie!"
  elsif WINNING_COMBINATIONS.include?([user_choice, opponent_choice])
    puts "You win!"
  else
    puts "You lose!"
  end
end

rock_paper_scissors
