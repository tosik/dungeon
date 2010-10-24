$: << "../automazerb/lib/"
require "automaze"

require_relative "text_window"
require_relative "quasi3d"
require_relative "debug"

class MainArea < Window
  def initialize
    super(19, 53, 0, 0)
    @quasi3d = Quasi3d.new(@window)
    @maze = Automaze::Automaze.new(:algorithm => :dug_tunnels, :size_x => 10, :size_y => 10)
    @map = TextWindow.new(15, 28, 25, 0)
    @map.text = @maze.to_s.delete("\n")

    @pos = [0,0]
    @eye = [0,1]
  end

  def key_wait
    loop do
      case @window.getch
      when ?w
        @pos = relative_pos(*[0,2])
        d "pos", @pos
        return
      when ?a
        @eye = rotate_left(@eye)
        d "eye", @eye
        return
      when ?d
        @eye = rotate_right(@eye)
        d "eye", @eye
        return
      else
        return
      end
    end
  end

  def rotate_left(xy)
    return [ 1, 0] if xy == [ 0, 1]
    return [-1, 0] if xy == [ 0,-1]
    return [ 0,-1] if xy == [ 1, 0]
    return [ 0, 1] if xy == [-1, 0]
  end
  def rotate_right(xy)
    return [-1, 0] if xy == [ 0, 1]
    return [ 1, 0] if xy == [ 0,-1]
    return [ 0, 1] if xy == [ 1, 0]
    return [ 0,-1] if xy == [-1, 0]
  end

  def update
    [
      [-4, 3], [ 4, 3], [-2, 3], [ 2, 3], [ 0, 3], [-3, 2], [ 3, 2], [-1, 2],
      [ 1, 2], [-4, 1], [ 4, 1], [-2, 1], [ 2, 1], [ 0, 1], [-1, 0], [ 1, 0],
    ].each do |xy|
      @quasi3d.set_panel(*xy, @maze.panels(*relative_pos(*xy)).wall?)
    end
  end

  def relative_pos(x, y)
    return [@pos[0] + x, @pos[1] + y] if @eye == [0, 1]
    return [@pos[0] - x, @pos[1] - y] if @eye == [0, -1]
    return [@pos[0] + y, @pos[1] - x] if @eye == [1, 0]
    return [@pos[0] - y, @pos[1] + x] if @eye == [-1, 0]
    raise "@eye is invalid"
  end

  def refresh
    super
    update
    @quasi3d.refresh
    @map.refresh
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

