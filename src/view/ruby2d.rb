require 'ruby2d'
require_relative '../model/state'

module View
  class Ruby2dView
    def initialize(app)
      @square_size = 50
      @app = app
    end

    def start(state)
      extend Ruby2D::DSL
      set(
        title: "Snake",
        background: "navy",
        width: @square_size * state.board.cols,
        height: @square_size * state.board.rows
      )

      on :key_down do |event|
        handle_key_event(event)
        # puts event.key
      end
      show
    end

    def render(state)
      extend Ruby2D::DSL
      close if state.game_over
      render_snake(state)
      render_food(state)
    end

    private

    def render_food(state)
      @food.remove if @food
      extend Ruby2D::DSL
      food = state.food

      @food = Square.new(
        x: food.col * @square_size,
        y: food.row * @square_size,
        size: @square_size,
        color: 'yellow'
      )
    end

    def render_snake(state)
      @snake_coordinates.each(&:remove) if @snake_coordinates

      extend Ruby2D::DSL
      snake = state.snake

      @snake_coordinates = snake.coordinates.map do |coord|
        Square.new(
          x: coord.col * @square_size,
          y: coord.row * @square_size,
          size: @square_size,
          color: 'white'
        )
      end
    end

    def handle_key_event(event)
      case event.key
      when "up"
        @app.send_action(:change_direction, Model::Direction::UP)
      when "down"
        @app.send_action(:change_direction, Model::Direction::DOWN)
      when "left"
        @app.send_action(:change_direction, Model::Direction::LEFT)
      when "right"
        @app.send_action(:change_direction, Model::Direction::RIGHT)
      end
    end
  end
end
