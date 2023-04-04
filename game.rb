require './player'

class Game
  attr_reader :player1, :player2, :current_player, :game_over
  
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @game_over = false
  end
  
  def start
    puts "Let the games begin!!!!!"
    until game_over?
      question = generate_question
      puts "#{current_player.name}: What does #{question.num1} + #{question.num2} equal?"
      answer = gets.chomp.to_i
      if answer == question.answer
        puts "That's right! Way to go :)"
        current_player.increase_score
      else
        puts "Oh no...That's wrong. You lose a life."
        current_player.lose_life
      end
      puts "Current Scores -- #{player1.name}: #{player1.score} / #{player2.name}: #{player2.score}"
      switch_player
    end
    declare_winner
  end
  
  def generate_question
    num1 = rand(1..20)
    num2 = rand(1..20)
    Question.new
  end
  
  def switch_player
    @current_player = (current_player == player1) ? player2 : player1
  end
  
  def game_over?
    player1.lives == 0 || player2.lives == 0
  end
  
  def declare_winner
    winner = (player1.lives == 0) ? player2 : player1
    puts "Welp, that's a wrap! #{winner.name} wins with a score of #{winner.score}!"
    puts "#{winner.name}, best of luck in your future endeavors, your rival #{(winner == player1) ? player2.name : player1.name} had a score of #{(winner == player1) ? player2.score : player1.score}!"
  end
end
