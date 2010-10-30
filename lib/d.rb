require "screen/text_window"

def d(*args)
  @win ||= TextWindow.new(25, 31, 0, 80)
  @win.text = "------- debug window -------\n" if @win.text.empty?
  @win.text += args.map{|arg| arg.inspect}.join(" ") + "\n"
  @win.text = "" if @win.text.count("\n") > 25
  @win.refresh
end

