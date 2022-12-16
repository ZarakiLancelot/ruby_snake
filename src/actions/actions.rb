module Actions
  def self.move_snake(state)
    next_direction = state.next_direction
    next_position = next_position(state.snake, next_direction)

    if next_position_is_valid?(state, next_direction)
      move_snake_to(state, next_direction)
    else
      end_game(state)
    end
  end

  private

  def self.next_position(snake, direction)
    case direction
    when Model::Direction::UP
      Model::Coordinate.new(snake.coordinates.first.row - 1, snake.coordinates.first.col)
    when Model::Direction::DOWN
      Model::Coordinate.new(snake.coordinates.first.row + 1, snake.coordinates.first.col)
    when Model::Direction::LEFT
      Model::Coordinate.new(snake.coordinates.first.row, snake.coordinates.first.col - 1)
    when Model::Direction::RIGHT
      Model::Coordinate.new(snake.coordinates.first.row, snake.coordinates.first.col + 1)
    end
  end

  def self.next_position_is_valid?(state, direction)
    next_position = next_position(state.snake, direction)
    next_position.row >= 0 &&
      next_position.row < state.board.rows &&
      next_position.col >= 0 &&
      next_position.col < state.board.cols
  end

  def self.move_snake_to(state, direction)
    next_position = next_position(state.snake, direction)
    snake = state.snake
    snake.coordinates.unshift(next_position)
    snake.coordinates.pop
    state
  end

  def self.end_game(state)
    state
  end
end
