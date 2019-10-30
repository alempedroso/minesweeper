# Prints the board state with rows and columns indexes
class PrettyPrinter
  def print_board(state)
    (0..state[0].count-1).each { |n| print " %2d " % [n] }
    puts
    state.each_with_index do |row, idx|
      print "|"
      row.each do |value|
        print " #{value} |"
      end
      print " #{idx}"
      puts
    end
  end
end
