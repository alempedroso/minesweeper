# Stores the required information of a playable cell of the board
class Cell
  attr_accessor :value, :visited, :has_flag

  def initialize (value)
    @value = value
    @visited = false
    @has_flag = false
  end

  def has_flag?
    @has_flag
  end

  def is_visited?
    @visited
  end

  def has_bomb?
    @value == "#"
  end

  def is_clear?
    @value == 0
  end
end
