require "curses"

class Window
  def initialize(size_y, size_x, pos_y, pos_x)
    @window = Curses::Window.new(size_y-2, size_x-2, pos_y+1, pos_x+1)
    @frame = Curses::Window.new(size_y, size_x, pos_y, pos_x)
    @size_x = size_x
    @size_y = size_y
  end

  def refresh
    draw_frame
    @window.refresh
  end

  def draw_frame
    @frame.box("|","~")
    @frame.refresh
  end
end

