#!/usr/bin/env ruby

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

class Position

  attr_reader :x
  attr_reader :y

  def initialize(x, y)
    @x = x.to_i
    @y = y.to_i
  end

  def to_s
    "#{@x}, #{@y}"
  end
end

class Rover

  @@rover_count = 0
  @@rover_hash = {}

  attr_accessor :direction
  attr_accessor :position
  attr_accessor :final_position

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
    return [Position.new(x, y), directions[direction]]

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


def validate_position(plateau, position)

  # check if the new position is negative
  if plateau.negative_position(position)
    puts "Skipped new position #{position} - negative position"
    return false
  end

  # check if new position is beyond the grid size
  if plateau.out_of_grid(position)
    puts "Skipped new position #{position} - out of grid"
    return false
  end

  # check if the new position equals the position of another rover
  if Rover.stomp_rover(position)
    puts "Skipped new_position #{position} - another rover location"
    return false
  end

  return true
end


def main

  puts("\nEnter the grid size")
  grid_x, grid_y = gets.chomp.split

  my_plateau = Plateau.new(grid_x, grid_y)

  puts("\nEnter number of rovers")
  num_rovers = gets.chomp.to_i

  (1..num_rovers).each do

    puts("Current location of existing rovers - #{Rover.get_rovers()}")

    puts("\nPlease enter starting position")
    x, y, dir = gets.chomp.split

    next unless validate_position(my_plateau, Position.new(x, y))
    #if Rover.stomp_rover(Position.new(x, y))
    #  puts "Another rover already present at position #{x}, #{y}"
    #  next
    #end

    my_rover = Rover.new(x, y, dir)
    puts("#{my_rover}")

    puts("Please enter the instructions to be sent")
    instructions = gets.chomp

    # Process each instruction
    instructions.chars.to_a.each do |instruction|

      new_pos, dir = my_rover.move(instruction)

      if validate_position(my_plateau, new_pos)

        # accept the new position
        my_rover.position = new_pos
        my_rover.direction = dir

      end
      puts "Changed position - #{my_rover.position.x} #{my_rover.position.y} #{my_rover.direction}\n"

    end
    puts("\nFinal #{my_rover}")
    Rover.add_rover_to_hash(my_rover)
  end
end

if __FILE__ == $0
    main()
end