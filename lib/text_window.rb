require_relative "window"

class TextWindow < Window
  def initialize(size_y, size_x, pos_y, pos_x, options={})
    super(size_y, size_x, pos_y, pos_x)
    @text = ""
    @scroll = options.delete(:scroll)
  end
  attr_accessor :text

  def refresh
    if @scroll
      ncount = @text.count("\n")
      if ncount >= @size_y - 2
        @text = @text.split("\n")[ncount-@size_y+2..ncount].join("\n")
      end
    end

    @window.clear
    @window << @text
    super
  end
end

