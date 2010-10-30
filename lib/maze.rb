
class Maze < Automaze::Automaze
  def initialize
    super(:algorithm => :dug_tunnels, :size_x => 50, :size_y => 14)

    10.times do
      create_room(rand(@size_x), rand(@size_y))
    end

    # recreate
    create_outer_walls
  end

  def create_outer_walls
    (-1..@size_y+1).each do |y|
      panels(-1, y).set_kind(:wall)
      panels(@size_x+1, y).set_kind(:wall)
    end

    (-1..@size_x+1).each do |x|
      panels(x, -1).set_kind(:wall)
      panels(x, @size_y+1).set_kind(:wall)
    end
  end

  def create_room(center_x, center_y)
    room_size_x = rand(3)
    room_size_y = rand(3)
    d room_size_x, room_size_y
    (-room_size_y..room_size_y).each do |y|
      (-room_size_x..room_size_x).each do |x|
        panels(center_x + x, center_y + y).set_kind(:floor)
      end
    end
  end
end

