
class Player
  def initialize(maze)
    @pos = [0,0]
    @direction = 0
    @maze = maze
  end
  attr_reader :pos
  attr_reader :direction

  def relative_pos(x, y)
    Position.relative(@pos, [x,y], @direction)
  end

  def move_front
    @pos = relative_pos(0, 2) if @maze.panels(*relative_pos(0, 1)).floor?
  end

  def move_back
    @pos = relative_pos(0, -2) if @maze.panels(*relative_pos(0, -1)).floor?
  end

  def turn_left
    @direction -= 1
    @direction = 3 if @direction == -1
  end

  def turn_right
    @direction += 1
    @direction = 0 if @direction == 4
  end

end

