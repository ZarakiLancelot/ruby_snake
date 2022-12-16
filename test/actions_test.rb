require 'minitest/autorun'
require_relative '../src/actions/actions'
require_relative '../src/model/state'

class ActionsTest < MiniTest::Test
  def test_move_snake
    state = Model.initial_state
    state = Actions.move_snake(state)
    assert_equal 2, state.snake.coordinates.first.row
    assert_equal 1, state.snake.coordinates.first.col
  end
end
