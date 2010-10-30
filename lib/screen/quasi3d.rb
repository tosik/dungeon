require "d"

class Quasi3d
  def initialize(parent)
    @parent = parent
    @panels = {}

    # rendering order
    [
      [ 4, 3], [-4, 3], [ 2, 3], [-2, 3],
      [ 0, 3], [ 3, 2], [-3, 2], [ 1, 2],
      [-1, 2], [ 4, 1], [-4, 1], [ 2, 1],
      [ 3, 0], [-3, 0],
      [-2, 1], [ 0, 1], [ 1, 0], [-1, 0],
    ].each do |xy|
      @panels[xy] = false
    end
  end

  def set_panel(x, y, bool)
    @panels[[x,y]] = bool
  end

  def refresh
    @panels.each do |xy, is_wall|
      clear_wall(*xy)
    end
    @panels.each do |xy, is_wall|
      build_wall(*xy) if is_wall
    end
    @panels.each do |xy, is_wall|
      refresh_wall(*xy) if is_wall
    end
  end

  def clear_wall(x,y)
    wall = walls[[x,y]][:wall]
    (0..wall.maxy).each do |y|
      (0..wall.maxx).each do |x|
        wall.setpos(y, x)
        wall.addch(" ")
      end
    end
  end

  def build_wall(x,y)
    info = walls[[x,y]]
    info[:wall] << info[:text]
  end

  def refresh_wall(x,y)
    info = walls[[x,y]]
    info[:wall].refresh
  end

  def walls
    parts = {}

    parts[[4,3]] = create_wall(5,11,7,1, <<-EOS
.---------.
|         |
|   4,3   |
|         |
"---------"
    EOS
    )

    parts[[-4,3]] = create_wall(5,11,7,41, <<-EOS
.---------.
|         |
|  -4,3   |
|         |
"---------"
    EOS
    )

    parts[[2,3]] = create_wall(5,11,7,11, <<-EOS
.---------.
|         |
|   2,3   |
|         |
"---------"
    EOS
    )

    parts[[-2,3]] = create_wall(5,11,7,31, <<-EOS
.---------.
|         |
|  -2,3   |
|         |
"---------"
    EOS
    )

    parts[[0,3]] = create_wall(5,11,7,21, <<-EOS
.---------.
|         |
|   0,3   |
|         |
"---------"
    EOS
    )

    parts[[1,2]] = create_wall(9,7,5,15, <<-EOS
.      
|"-.   
|   "-.
|     |
| 1,2 |
|     |
|   .-"
|.-"   
"      
    EOS
    )

    parts[[-1,2]] = create_wall(9,7,5,31, <<-EOS
      .
   .-"|
.-"   |
|     |
|-1,2 |
|     |
"-.   |
   "-.|
      "
    EOS
    )

    parts[[3,2]] = create_wall(9,9,5,3, <<-EOS
.._      
|  "-.   
|     "-.
|       |
|  3,2  |
|       |
|     .-"
|  .-"   
"""      
    EOS
    )

    parts[[-3,2]] = create_wall(9,9,5,41, <<-EOS
      _..
   .-"  |
.-"     |
|       |
| -3,2  |
|       |
"-.     |
   "-.  |
      """
    EOS
    )

    parts[[3,0]] = create_wall(9,3,5,1, <<-EOS
"-.
  |
  |
 3|
 ,|
 0|
  |
  |
.-"
    EOS
    )

    parts[[-3,0]] = create_wall(9,3,5,49, <<-EOS
.-"
|  
|  
|-3
| ,
| 0
|  
|  
"-.
    EOS
    )

    parts[[2,1]] = create_wall(9,15,5,1, <<-EOS
--------------.
              |
              |
              |
     2,1      |
              |
              |
              |
--------------"
    EOS
    )

    parts[[-2,1]] = create_wall(9,15,5,37, <<-EOS
.--------------
|              
|              
|              
|     -2,1     
|              
|              
|              
"--------------
    EOS
    )

    parts[[4,1]] = create_wall(9,3,5,1, <<-EOS
--.
  |
  |
 4|
 ,|
 1|
  |
  |
--"
    EOS
    )

    parts[[-4,1]] = create_wall(9,3,5,49, <<-EOS
.--
|  
|  
|-4
| ,
| 1
|  
|  
"--
    EOS
    )

    parts[[1,0]] = create_wall(17,15,1,1, <<-EOS
"-.            
   "-.         
      "-.      
         "-.   
            "-.
              |
              |
              |
     1.0      |
              |
              |
              |
            .-"
         .-"   
      .-"      
   .-"         
.-"            
    EOS
    )

    parts[[-1,0]] = create_wall(17,15,1,37, <<-EOS
            .-"
         .-"   
      .-"      
   .-"         
.-"            
|              
|              
|              
|     -1,0     
|              
|              
|              
"-.            
   "-.         
      "-.      
         "-.   
            "-.
    EOS
    )

    parts[[0,1]] = create_wall(9,23,5,15, <<-EOS
.---------------------.
|                     |
|                     |
|                     |
|         0,1         |
|                     |
|                     |
|                     |
"---------------------"
    EOS
    )

    parts
  end

  def create_wall(size_y, size_x, pos_y, pos_x, text)
    part = {
      :wall => @parent.subwin(size_y, size_x, pos_y, pos_x),
      :text => text.delete("\n"),
    }
    return part
  end
end

