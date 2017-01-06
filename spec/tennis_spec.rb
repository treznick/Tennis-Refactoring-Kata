require 'spec_helper'

TEST_CASES = [
  [0, 0, "Love-All", 'player1', 'player2'],
  [1, 1, "Fifteen-All", 'player1', 'player2'],
  [2, 2, "Thirty-All", 'player1', 'player2'],
  [3, 3, "Deuce", 'player1', 'player2'],
  [4, 4, "Deuce", 'player1', 'player2'],

  [1, 0, "Fifteen-Love", 'player1', 'player2'],
  [0, 1, "Love-Fifteen", 'player1', 'player2'],
  [2, 0, "Thirty-Love", 'player1', 'player2'],
  [0, 2, "Love-Thirty", 'player1', 'player2'],
  [3, 0, "Forty-Love", 'player1', 'player2'],
  [0, 3, "Love-Forty", 'player1', 'player2'],
  [4, 0, "Win for player1", 'player1', 'player2'],
  [0, 4, "Win for player2", 'player1', 'player2'],

  [2, 1, "Thirty-Fifteen", 'player1', 'player2'],
  [1, 2, "Fifteen-Thirty", 'player1', 'player2'],
  [3, 1, "Forty-Fifteen", 'player1', 'player2'],
  [1, 3, "Fifteen-Forty", 'player1', 'player2'],
  [4, 1, "Win for player1", 'player1', 'player2'],
  [1, 4, "Win for player2", 'player1', 'player2'],

  [3, 2, "Forty-Thirty", 'player1', 'player2'],
  [2, 3, "Thirty-Forty", 'player1', 'player2'],
  [4, 2, "Win for player1", 'player1', 'player2'],
  [2, 4, "Win for player2", 'player1', 'player2'],

  [4, 3, "Advantage player1", 'player1', 'player2'],
  [3, 4, "Advantage player2", 'player1', 'player2'],
  [5, 4, "Advantage player1", 'player1', 'player2'],
  [4, 5, "Advantage player2", 'player1', 'player2'],
  [15, 14, "Advantage player1", 'player1', 'player2'],
  [14, 15, "Advantage player2", 'player1', 'player2'],

  [6, 4, 'Win for player1', 'player1', 'player2'],
  [4, 6, 'Win for player2', 'player1', 'player2'],
  [16, 14, 'Win for player1', 'player1', 'player2'],
  [14, 16, 'Win for player2', 'player1', 'player2'],

  [6, 4, 'Win for One', 'One', 'player2'],
  [4, 6, 'Win for Two', 'player1', 'Two'],
  [6, 5, 'Advantage One', 'One', 'player2'],
  [5, 6, 'Advantage Two', 'player1', 'Two']
]

IMPLEMENTATIONS = [
  TennisGame1,
  TennisGame2,
  TennisGame3
]

def play_game(game_class, player_one_points, player_two_points, player_one_name, player_two_name)
  game = game_class.new(player_one_name, player_two_name)

  points_array = [player_one_points, player_two_points]

  (0..points_array.max).each do |points|
    if points < player_one_points
      game.won_point(player_one_name)
    end

    if points < player_two_points
      game.won_point(player_two_name)
    end
  end

  game
end

describe "#score" do
  IMPLEMENTATIONS.each do |implementation_constant|
    context "given implementation given in #{implementation_constant}" do
      TEST_CASES.each do |test_case|
        context "and the score: Player One: #{test_case[0]}, Player Two: #{test_case[1]}" do
          it "should return #{test_case[2]}" do
            (player_one_points, player_two_points, score, player_one_name, player_two_name) = test_case
            game = play_game(implementation_constant,
                             player_one_points,
                             player_two_points,
                             player_one_name,
                             player_two_name)
            expect(game.score).to eq(score)
          end
        end
      end
    end
  end
end
