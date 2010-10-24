require_relative "text_window"
require_relative "quasi3d"

class MainArea < Window
  def initialize
    super(19, 53, 0, 0)
    @quasi3d = Quasi3d.new(@window)
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

