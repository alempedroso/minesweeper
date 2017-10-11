require 'minitest/autorun'
require_relative 'minesweeper'

class MinesweeperTest < Minitest::Test
  attr_accessor :game

  def plant_defined_mines
    h = [[0,9], [1,3], [1,8], [2,0], [2,3], [3,0], [3,5], [3,6], [4,0], [4,8], [5,0], [5,1], [5,5], [5,6], [6,2], [7,3], [7,5], [7,6], [9,0], [9,1]]

    h.each do |element|
      @game.board[element[0]][element[1]].value = "#"
      @game.fix_nearby(element[0], element[1])
    end
  end

  def setup
    @game = Minesweeper.new(10, 10, 20)

    (0..@game.height-1).each do |x|
      (0..@game.width-1).each do |y|
        @game.board[x][y].value = 0
      end
    end

    plant_defined_mines
  end

  def test_play_in_a_cell_with_a_number
    assert_equal(true, @game.play(0, 8))
    puts "Number"
    PrettyPrinter.new.print_board(@game.board_state(xray:true))
  end

  def test_play_in_a_clear_cell
    assert_equal(true, @game.play(0, 5))
    puts "Clear"
    PrettyPrinter.new.print_board(@game.board_state(xray:true))
  end

  def test_play_in_a_visited_cell
    assert_equal(true, @game.play(6, 0))
    assert_equal(false, @game.play(6, 0))
    puts "Visited"
    PrettyPrinter.new.print_board(@game.board_state(xray:true))
  end

  def test_play_in_a_cell_at_the_middle
    assert_equal(true, @game.play(4, 3))
    puts "Middle"
    PrettyPrinter.new.print_board(@game.board_state(xray:true))
  end

  def test_flag_and_unflag_a_cell
    assert_equal(true, @game.flag(1, 0))
    puts "Flag"
    PrettyPrinter.new.print_board(@game.board_state(xray:true))
    assert_equal(true, @game.flag(1, 0))
    puts "Unflag"
    PrettyPrinter.new.print_board(@game.board_state(xray:true))
  end

  def test_play_a_flagged_cell
    assert_equal(true, @game.flag(1, 0))
    assert_equal(false, @game.play(1, 0))
  end

  def test_flag_a_visited_cell
    assert_equal(true, @game.play(1, 0))
    assert_equal(false, @game.flag(1, 0))
  end

  def test_play_a_cell_out_of_borders
    assert_equal(false, @game.play(-1,0))
    assert_equal(false, @game.play(11,0))
    assert_equal(false, @game.play(2,-3))
    assert_equal(false, @game.play(2,15))
  end

  def test_flag_a_cell_out_of_borders
    assert_equal(false, @game.flag(-1,0))
    assert_equal(false, @game.flag(11,0))
    assert_equal(false, @game.flag(2,-3))
    assert_equal(false, @game.flag(2,15))
  end
end