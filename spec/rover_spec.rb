require 'spec_helper'
require 'rover'

describe 'Plateau' do
  it "should not allow negative positions" do
    plat = Plateau.new(4, 4)
    pos = Position.new(-3, 3)
    plat.negative_position(pos).should be(true)
  end

  it "should allow positive positions" do
    plat = Plateau.new(4, 4)
    pos = Position.new(3, 3)
    plat.negative_position(pos).should be(false)
  end

  it "should not allow out of grid positions" do
    plat = Plateau.new(5, 5)
    pos = Position.new(3, 8)
    plat.out_of_grid(pos).should be(true)
  end

  it "should allow positions within the grid" do
    plat = Plateau.new(5, 5)
    pos = Position.new(2, 3)
    plat.out_of_grid(pos).should be(false)
  end
end

describe 'Rover' do
  it "should move one step ahead" do
    my_rover = Rover.new(2, 3, 'N')
    instruction = 'M'
    my_rover.move(instruction) == [Position.new(2, 4), 'N']
  end

  it "should move 90 degrees to the left" do
    my_rover = Rover.new(4, 5, 'E')
    instruction = 'L'
    my_rover.move(instruction) == [Position.new(4, 5), 'N']
  end

  it "should move 90 degrees to the right" do
    my_rover = Rover.new(1, 1, 'S')
    instruction = 'R'
    my_rover.move(instruction) == [Position.new(4, 5), 'W']
  end

  it "should not move one step behind" do
    my_rover = Rover.new(2, 3, 'N')
    instruction = 'M'
    my_rover.move(instruction) != [Position.new(2, 2), 'N']
  end

  it "should not move 90 degrees to the right" do
    my_rover = Rover.new(4, 5, 'E')
    instruction = 'L'
    my_rover.move(instruction) != [Position.new(4, 5), 'S']
  end

  it "should not move 90 degrees to the left" do
    my_rover = Rover.new(1, 1, 'S')
    instruction = 'R'
    my_rover.move(instruction) != [Position.new(4, 5), 'E']
  end
end


