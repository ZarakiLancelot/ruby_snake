module Model
  class Coordinate < Struct.new(:row, :col)
  end

  class Board < Struct.new(:rows, :cols)
  end

  class Food < Coordinate
  end

  class Snake < Struct.new(:coordinates)
  end

  class State < Struct.new(:snake, :food, :board)
  end

  def self.initial_state
    Model::State.new(
      Model::Snake.new([
        Model::Coordinate.new(1, 1),
        Model::Coordinate.new(0, 1),
      ]),
      Model::Food.new(4, 4),
      Model::Board.new(8, 12)
    )
  end
end
