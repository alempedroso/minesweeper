require_relative 'minesweeper'

width, height, num_mines = 10, 20, 50
game = Minesweeper.new(width, height, num_mines)

while game.still_playing?
  valid_move = game.play(rand(width), rand(height))
  valid_flag = game.flag(rand(width), rand(height))
  if valid_move || valid_flag
    printer = (rand > 0.5) ? SimplePrinter.new : PrettyPrinter.new
    printer.print_board(game.board_state)
    puts
  end
end

puts "Fim do jogo!"

if game.victory?
  puts "Você venceu!"
else
  puts "Você perdeu! As minas eram:"
  SimplePrinter.new.print_board(game.board_state(xray: true))
end