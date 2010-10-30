
require "screen"
require "d"

class Dungeon
  def run
    main_area = MainArea.new
    main_area.refresh

    menu_area = MenuArea.new
    menu_area.refresh

    message_area = MessageArea.new
    message_area.text = "Here comes Santa Claus! Here comes Santa Claus! Right down Santa Claus Lane! Vixen and Blitzen and all his reindeer are pulling on the reins. Bells are ringing children singing; All is merry and bright. Hang your stockings and say your prayers, 'Cause Santa Claus comes tonight."
    message_area.refresh

    loop do
      main_area.key_wait
      main_area.refresh
    end
  end
end

