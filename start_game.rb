require_relative 'minesweeper/minesweeper'
require_relative 'minesweeper/pretty_printer'

def make_play(game)
  puts "Choose one"
  puts "P - Play | F - Flag | X - X-ray"

  move = gets.chomp.upcase

  if move == "P"
    puts "Type the X coordinate"
    x = gets.chomp.to_i

    puts "Type the Y coordinate"
    y = gets.chomp.to_i

    puts game.play(x, y)
  elsif move == "F"
    puts "Type the X coordinate"
    x = gets.chomp.to_i

    puts "Type the Y coordinate"
    y = gets.chomp.to_i
    puts game.flag(x, y)
  elsif move == "X"
    PrettyPrinter.new.print_board(game.board_state(xray: true))
    puts
  end

  move
end

game = Minesweeper.new(10,10,20)
PrettyPrinter.new.print_board(game.board_state)

while game.still_playing?
  move = make_play(game)
  PrettyPrinter.new.print_board(game.board_state) unless move == "X"
  puts game.number_of_visited
end

puts "Done!"

if game.victory?
  puts "You won!"
else
  puts "You lost!"
end

PrettyPrinter.new.print_board(game.board_state(xray: true))
