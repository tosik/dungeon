$: << "../automazerb/lib/"
require "automaze"

require_relative "text_window"
require_relative "quasi3d"
require_relative "debug"
require_relative "position"
require "matrix"

class MainArea < Window
  def initialize
    super(19, 53, 0, 0)
    @quasi3d = Quasi3d.new(@window)
    @maze = Automaze::Automaze.new(:algorithm => :dug_tunnels, :size_x => 10, :size_y => 10)
    @map = TextWindow.new(15, 28, 25, 0)
    @map.text = @maze.to_s.delete("\n")

    @pos = [0,0]
    @direction = 0
  end

  def key_wait
    loop do
      case @window.getch
      when ?w
        move_front
      when ?a
        @direction -= 1
      when ?d
        @direction += 1
      when ?s
        move_back
      end
      return
    end
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
    Position.relative(@pos, [x,y], @direction)
  end

  def move(x, y)
    next_pos = relative_pos(x, y)
    @pos = next_pos if @maze.panels(*next_pos).floor?
  end

  def move_front
    move(0, 2)
  end

  def move_back
    move(0, -2)
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

