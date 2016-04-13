
require "screen"
require "d"

class Dungeon
  def run
    3.times do
      main_area = MainArea.new
      main_area.refresh
    end

    message_area = MessageArea.new
    message_area.refresh
    loop do
      main_area.key_wait
      main_area.refresh
    end
  end
end

