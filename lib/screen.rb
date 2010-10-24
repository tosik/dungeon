$: << "../automazerb/lib/"
require "automaze"

require_relative "text_window"
require_relative "quasi3d"
require_relative "debug"

class MainArea < Window
  def initialize
    super(19, 53, 0, 0)
    @quasi3d = Quasi3d.new(@window)

    @pos = [0,0]
    @eye = [1,0]
    @maze = Automaze::Automaze.new(:algorithm => :dug_tunnels)

    [
      [-4, 3], [ 4, 3], [-2, 3], [ 2, 3], [ 0, 3], [-3, 2], [ 3, 2], [-1, 2],
      [ 1, 2], [-4, 1], [ 4, 1], [-2, 1], [ 2, 1], [ 0, 1], [-1, 0], [ 1, 0],
    ].each do |xy|
      @quasi3d.set_panel(*xy, @maze.panels(*relative_pos(*xy)).wall?)
    end
  end

  def relative_pos(x, y)
    return [@pos[0] + x, @pos[1] + y] if @eye == [0, 1]
    return [@pos[0] + x, @pos[1] - y] if @eye == [0, -1]
    return [@pos[0] + x, @pos[1] + y] if @eye == [1, 0]
    return [@pos[0] - x, @pos[1] + y] if @eye == [-1, 0]
    raise "@eye is invalid"
  end

  def refresh
    super
    @quasi3d.refresh
  end

  def getch
    @window.getch
  end
end

class MenuArea < Window
  def initialize
    super(19, 27, 0, 53)
  end
end

class MessageArea < TextWindow
  def initialize
    super(6, 80, 19, 0)
  end
end

