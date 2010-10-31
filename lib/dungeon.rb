
require "screen"
require "d"

class Dungeon
  def run
    main_area = MainArea.new
    main_area.refresh

    menu_area = MenuArea.new
    menu_area.refresh

    message_area = MessageArea.new
    message_area.refresh

    loop do
      main_area.key_wait
      main_area.refresh
    end
  end
end

