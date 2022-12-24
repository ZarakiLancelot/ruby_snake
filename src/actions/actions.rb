module Actions
  def self.move_snake(state)
    next_direction = state.next_direction
    next_position = calc_next_position(state)

    if next_position_is_valid?(state, next_position)
      move_snake_to(state, next_position)
    else
      end_game(state)
    end
  end

  private

  def self.calc_next_position(state)
    current_position = state.snake.coordinates.first

    case state.next_direction
    when Model::Direction::UP
      Model::Coordinate.new(current_position.row - 1, current_position.col)
    when Model::Direction::DOWN
      Model::Coordinate.new(current_position.row + 1, current_position.col)
    when Model::Direction::LEFT
      Model::Coordinate.new(current_position.row, current_position.col - 1)
    when Model::Direction::RIGHT
      Model::Coordinate.new(current_position.row, current_position.col + 1)
    end
  end

  def self.next_position_is_valid?(state, direction)
    is_invalid = ((direction.row >= state.board.rows || direction.row < 0) || (direction.col >= state.board.cols || direction.col < 0))
    return false if is_invalid
    
    return !(state.snake.coordinates.include?(direction))
  end

  def self.move_snake_to(state, direction)
    new_positions = [direction] + state.snake.coordinates[0...-1]
    state.snake.coordinates = new_positions
    state
  end

  def self.end_game(state)
    state.game_finished = true
    state
  end
end
