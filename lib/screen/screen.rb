require "d"
require "screen/text_window"
require "screen/quasi3d"
require "position"
require "player"
require "maze"

require "matrix"

class MainArea < Window
  def initialize(options={})
    super 19, 53, 0, 0
    @quasi3d = Quasi3d.new @window
    @maze = Maze.new
    @map = TextWindow.new @maze.size_y + 5, @maze.size_x * 2 + 8, 25, 0
    @map.text = @maze.to_s.delete ?\n
    @player = Player.new @maze
  end

  def key_wait
    loop do
      case @window.getch
        when ?w then @player.move_front
        when ?a then @player.turn_left
        when ?d then @player.turn_right
        when ?s then @player.move_back
      end
      d @player.pos, @player.direction
      return
    end
  end

  def update
    [
      [-4, 3], [ 4, 3], [-2, 3], [ 2, 3], [ 0, 3], [-3, 2], [ 3, 2], [-1, 2],
      [ 1, 2], [-4, 1], [ 4, 1], [-2, 1], [ 2, 1], [ 0, 1], [-1, 0], [ 1, 0],
      [ 3, 0], [-3, 0],
    ].each {  |xy|  @quasi3d.set_panel *xy, @maze.panels(*@player.relative_pos *xy).wall? }
  end

  def refresh
    super
    update
    @quasi3d.refresh
    @map.refresh
  end
end

class MenuArea < Window
  def initialize
    super 19, 27, 0, 53
  end
end

class MessageArea < TextWindow
  def initialize
    super 6, 80, 19, 0
  end
end

