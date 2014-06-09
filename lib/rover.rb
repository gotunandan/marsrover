
class Rover

  @@rover_count = 0
  @@rover_hash = {}

  attr_accessor :direction
  attr_accessor :position
  #attr_accessor :final_position

  def initialize(x, y, direction)
    @position = Position.new(x, y)
    @direction = direction
    @@rover_count += 1
  end

  def to_s
    "Rover Position is - #{@position} #{@direction}"
  end

  def move(instruction)

    # directions
    directions = "NESW"

    dir_index = directions.index(@direction)
    x = @position.x
    y = @position.y
    instruction = instruction.to_sym

    # moves to be made according to the directions
    moves = [[0, 1], [1, 0], [0, -1], [-1, 0]]

    # positions to be changed for each move
    right_move = lambda {|x, y, dir_index| ret = x, y, (dir_index + 1) % 4}

    left_move = lambda {|x, y, dir_index| ret = x, y, (dir_index - 1 + 4) % 4}

    forward_move = lambda {|x, y, dir_index| ret = (x + moves[dir_index][0]), (y + moves [dir_index][1]), dir_index}

    # hash contains the lambda function corresponding to the instruction given
    my_hash = {R: right_move, L: left_move, M: forward_move}

    # call the lambda method as per the instruction provided
    x, y, direction = my_hash[instruction].call(x, y, dir_index)

    # return the new position and direction
    return [[x, y], directions[direction]]
  end

  def self.stomp_rover(position)

    return unless @@rover_hash.respond_to? :each
    #puts("position in stomprover is #{position.x} #{position.y}")

    @@rover_hash.each do |k, v|
      if position.x == v[0] && position.y == v[1]
        return true
      end
    end
    return false
  end

  def self.add_rover_to_hash(rover)

    @@rover_hash[@@rover_count] = [rover.position.x, rover.position.y]

  end

  def self.get_rovers()
    return @@rover_hash
  end

end


