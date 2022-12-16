require 'ruby2d'

module View
  class Ruby2dView
    def initialize
      @square_size = 50
    end

    def render(state)
      extend Ruby2D::DSL
      set(
        title: "Snake",
        background: "navy",
        width: @square_size * state.board.cols,
        height: @square_size * state.board.rows
      )
      render_snake(state)
      render_food(state)
      show
    end

    private

    def render_food(state)
      Square.new(
        x: state.food.col * @square_size,
        y: state.food.row * @square_size,
        size: @square_size,
        color: 'yellow'
      )
    end

    def render_snake(state)
      state.snake.coordinates.each do |coord|
        Square.new(
          x: coord.col * @square_size,
          y: coord.row * @square_size,
          size: @square_size - 1,
          color: 'white'
        )
      end
    end
  end
end
