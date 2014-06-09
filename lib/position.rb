
class Position

  attr_reader :x
  attr_reader :y

  def initialize(x, y)
    @x = x.to_i
    @y = y.to_i
  end

  def to_a
    [@x, @y]
  end

def to_s
	"#{@x} #{@y}"
end

end