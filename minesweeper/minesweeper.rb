# Engine for the minesweeper game
class Minesweeper
  attr_accessor :board,
                :width,
                :height,
                :mines,
                :still_playing,
                :number_of_visited,
                :number_of_flags

  # initializes variables and plants mines on the board
  def initialize(height, width, mines)
    @width = width
    @height = height
    @mines = mines
    @still_playing = true
    @number_of_visited = 0
    @number_of_flags = 0
    @board = create_cell_matrix

    plant_mines
  end

  # creates a two-dimensional array of Cells
  def create_cell_matrix
    matrix = []

    for row in 0..@height-1
      aux = []
      for column in 0..@width-1
        aux.push(Cell.new(0))
      end
      matrix.push(aux)
    end

    matrix
  end

  def plant_mines
    for mine in 1..@mines
      loop do
        x = rand(0..(height-1))
        y = rand(0..(width-1))

        if !@board[x][y].has_bomb?
          @board[x][y].value = "#"
          fix_nearby(x, y)
          break
        end
      end
    end
  end

  def in_range(x, y)
    x > -1 && y > -1 && x < @height && y < @width
  end

  def fix_nearby(x ,y)
    for row in x-1..x+1
      for col in y-1..y+1
        if (in_range(row, col) && !@board[row][col].has_bomb?)
          @board[row][col].value += 1
        end
      end
    end
  end

  def value_to_print(cell)
    if cell.has_flag?
      return "F"
    elsif !cell.is_visited?
      return "."
    elsif cell.is_clear?
      return " "
    end
    return "#{cell.value}"
  end

  def board_state(args = nil)
    state = Array.new(@height){Array.new(@width) {""} }

    board.each_with_index do |row, x|
      row.each_with_index do |cell, y|
        if args == nil
          state[x][y] = value_to_print(cell)
        elsif args[:xray]
          state[x][y] = (cell.has_bomb?) ? "#" : value_to_print(cell)
        else
          state[x][y] = value_to_print(cell)
        end
      end
    end
    state
  end

  def discover(x, y)
    for row in x-1..x+1
      for col in y-1..y+1
        if in_range(row, col)
          if (!@board[row][col].is_visited? && !@board[row][col].has_flag?)
            @board[row][col].visited = true
            @number_of_visited += 1
            discover(row, col) if @board[row][col].is_clear?
          end
        end
      end
    end
  end

  def flag(x, y)
    invalid = (!in_range(x, y) || @board[x][y].is_visited? || @number_of_flags == @mines)

    return false if invalid

    @number_of_flags = (board[x][y].has_flag?) ? @number_of_flags - 1 : @number_of_flags + 1
    @board[x][y].has_flag = (@board[x][y].has_flag?) ? false : true

    true
  end

  def still_playing?
    @still_playing
  end

  def victory?
    @number_of_visited == (@height * @width) - @mines
  end

  def play(x, y)
    invalid = (!in_range(x, y) || @board[x][y].is_visited? || @board[x][y].has_flag?)

    return false if invalid

    if @board[x][y].has_bomb?
      @still_playing = false
      return true
    end

    if @board[x][y].is_clear?
      discover(x, y)
    else
      @board[x][y].visited = true
      @number_of_visited += 1
    end

    @still_playing = false if victory?
    true
  end
end
