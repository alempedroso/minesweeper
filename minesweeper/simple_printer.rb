# Simply prints the board state
class SimplePrinter
  def print_board(state)
    state.each_with_index do |row, idx|
      print "|"
      row.each do |value|
        print " #{value} |"
      end
      puts
    end
  end
end
