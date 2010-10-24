require_relative "window"

class TextWindow < Window
  def initialize(size_y, size_x, pos_y, pos_x)
    super
    @text = ""
  end
  attr_accessor :text

  def refresh
    @window.clear
    @window << @text
    super
  end
end

