#!/usr/bin/env ruby

require './rover'
require './plateau'
require './position'

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

def process_rovers(my_plateau, num_rovers)


  (1..num_rovers).each do

    puts("Current location of existing rovers - #{Rover.get_rovers()}")

    puts("\nPlease enter starting position")
    x, y, dir = gets.chomp.split

    # If validate_position return false, it moves to the next rover
    next unless validate_position(my_plateau, Position.new(x, y))

    # Create the new rover object with the x,y positions & direction
    my_rover = Rover.new(x, y, dir)
    puts("#{my_rover}")

    puts("Please enter the instructions to be sent")
    instructions = gets.chomp

    # Process each instruction
    instructions.chars.to_a.each do |instruction|

      pos_arr, dir = my_rover.move(instruction)
      new_pos = Position.new(pos_arr[0], pos_arr[1])

      # if validate_position returns false, it skips the new position
      if validate_position(my_plateau, new_pos)

        # accept the new position
        my_rover.position = new_pos
        my_rover.direction = dir
        puts "Changed position - #{my_rover.position.x} #{my_rover.position.y} #{my_rover.direction}\n"
      end

    end

    puts("\nFinal #{my_rover}")
    Rover.add_rover_to_hash(my_rover)
  end


end


def main

  puts("\nEnter the grid size")
  grid_x, grid_y = gets.chomp.split

  my_plateau = Plateau.new(grid_x, grid_y)

  puts("\nEnter number of rovers")
  num_rovers = gets.chomp.to_i

  process_rovers(my_plateau, num_rovers)

end

if __FILE__ == $0
    main()
end