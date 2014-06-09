
class Plateau

  attr_reader :grid

  def initialize(x, y)
    @grid = Position.new(x, y)
  end

  def negative_position(position)

    return true if position.x < 0 || position.y < 0
    return false

  end

  def out_of_grid(position)
    return true if position.x > grid.x || position.y > grid.y
    return false

  end

end