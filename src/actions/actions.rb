module Actions
  def self.move_snake(state)
    next_direction = state.current_direction
    next_position = calc_next_position(state)

    if next_position_is_valid?(state, next_position)
      move_snake_to(state, next_position)
    else
      end_game(state)
    end
  end

  def self.change_direction(state, direction)
    if next_direction_is_valid?(state, direction)
      state.current_direction = direction
    else
      puts 'Invalid direction'
    end

    state
  end

  private

  def self.calc_next_position(state)
    current_position = state.snake.coordinates.first

    case state.current_direction
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

  def self.next_direction_is_valid?(state, direction)
    case state.current_direction
    when Model::Direction::UP
      return true if direction != Model::Direction::DOWN
    when Model::Direction::DOWN
      return true if direction != Model::Direction::UP
    when Model::Direction::LEFT
      return true if direction != Model::Direction::RIGHT
    when Model::Direction::RIGHT
      return true if direction != Model::Direction::LEFT
    end

    return false
  end

  def self.end_game(state)
    state.game_over = true
    state
  end
end
