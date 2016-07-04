require 'pry'

INITAIL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]]

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(arr, delimeter= ',', conjuc = 'or')
  last_element = arr.pop unless arr.size == 1
  if arr.size != 1
    ("#{arr.join("#{delimeter} ")}#{delimeter} #{conjuc} " +
    last_element.to_s)
  else
    arr[0].to_s
  end
end

def someone_won_series?(player_score, computer_score)
  player_score == 5 || computer_score == 5
end

def current_player(brd)
  empty_squares(brd).size.odd? ? "X" : "O"
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(board)
  system 'clear'
  prompt "You're #{PLAYER_MARKER}, Computer is #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts "     |     |"
  puts "-----------------"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts "     |     |"
  puts "-----------------"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/MethodLength

def display_score(player_score, computer_score)
  prompt "Computer: #{computer_score}"
  prompt "Player: #{player_score}"
end

def empty_square?(brd, move)
  empty_squares(brd).include?(move)
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = ' ' }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == ' ' }
end

def taken_squares(brd)
  brd.keys.select { |num| brd[num] != ' '}
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd), ';', 'and')})"
    square = gets.chomp.to_i

    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice"
  end
  brd[square] = 'X'
end

def immediate_win?(brd)
  WINNING_LINES.any? do |line|
    brd.values_at(*line).count("O") == 2 &&
    brd.values_at(*line).count(" ") == 1
  end
end

def immediate_threat?(brd)
  WINNING_LINES.any? do |line|
    brd.values_at(*line).count("X") == 2 &&
    brd.values_at(*line).count(" ") == 1
  end
end

def place_winning_piece!(brd)
  threat = WINNING_LINES.detect do |line|
    brd.values_at(*line).count("O") == 2 &&
    brd.values_at(*line).count(" ") == 1
  end

  square = threat.detect {|move| empty_squares(brd).include?(move)}
  brd[square] = "O"
end


def place_safe_piece!(brd)
  threat = WINNING_LINES.detect do |line|
    brd.values_at(*line).count("X") == 2 &&
    brd.values_at(*line).count(" ") == 1
  end


  square = threat.detect {|move| empty_squares(brd).include?(move)}
  brd[square] = "O"
end

def computer_places_piece!(brd)
  if immediate_win?(brd)
    place_winning_piece!(brd)
  elsif immediate_threat?(brd)
    place_safe_piece!(brd)
  else
    square = empty_squares(brd).sample
    square = 5 if empty_square?(brd, 5)
    brd[square] = 'O'
  end
end

def place_piece!(brd, current_player)
  current_player == "X" ? player_places_piece!(brd) : computer_places_piece!(brd)
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd[line[0]] == PLAYER_MARKER &&
       brd[line[1]] == PLAYER_MARKER &&
       brd[line[2]] == PLAYER_MARKER
      return 'Player'
    elsif brd[line[0]] == COMPUTER_MARKER &&
          brd[line[1]] == COMPUTER_MARKER &&
          brd[line[2]] == COMPUTER_MARKER
      return 'Computer'
    end
  end
  nil
end

def someone_won?(brd)
  !!detect_winner(brd)
end

player_score = 0
computer_score = 0

loop do
  board = initialize_board
  loop do
    display_board(board)
    place_piece!(board, current_player(board))
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    winner = detect_winner(board)
    prompt "#{winner} won!"
    winner == 'Player' ? player_score += 1 : computer_score += 1
    display_score(player_score, computer_score)
  else
    prompt "It's a tie!"
  end

  if someone_won_series?(player_score, computer_score)
    prompt "Play again?(y or n)"
    answer = gets.chomp.downcase
    break unless answer.start_with?('y')
  end
end

prompt "Thank you for playing! Good bye"
