require_relative "debug"

class Quasi3d
  def initialize(parent)
    @parent = parent
    @panels = {}
  end

  def refresh
    refresh_wall(-4, 3)
    refresh_wall(4, 3)
    refresh_wall(-2, 3)
    refresh_wall(2, 3)
    refresh_wall(0, 3)
    refresh_wall(-2, 1)
    refresh_wall(2, 1)
    #refresh_wall(-1, 0)
    refresh_wall(1, 0)
    refresh_wall(0, 1)
  end

  def refresh_wall(x,y)
    info = walls[[x,y]]
    info[:wall].clear
    info[:wall] << info[:text]
    info[:wall].refresh
  end

  def walls
    parts = {}

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

    parts[[-2,1]] = create_wall(9,15,5,1, <<-EOS
--------------.
              |
              |
              |
     -2,1     |
              |
              |
              |
--------------"
    EOS
    )

    parts[[2,1]] = create_wall(9,15,5,37, <<-EOS
.--------------
|              
|              
|              
|      2,1     
|              
|              
|              
"--------------
    EOS
    )

    parts[[-4,3]] = create_wall(5,11,7,1, <<-EOS
.---------.
|         |
|  -4,3   |
|         |
"---------"
    EOS
    )

    parts[[4,3]] = create_wall(5,11,7,41, <<-EOS
.---------.
|         |
|   4,3   |
|         |
"---------"
    EOS
    )

    parts[[-2,3]] = create_wall(5,11,7,11, <<-EOS
.---------.
|         |
|  -2,3   |
|         |
"---------"
    EOS
    )

    parts[[2,3]] = create_wall(5,11,7,31, <<-EOS
.---------.
|         |
|   2,3   |
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

    parts[[-1,0]] = create_wall(17,15,1,1, <<-EOS
"-.            
   "-.         
      "-.      
         "-.   
            "-.
              |
              |
              |
     -1.0     |
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

    parts[[1,0]] = create_wall(17,15,1,37, <<-EOS
            .-"
         .-"   
      .-"      
   .-"         
.-"            
|              
|              
|              
|      1,0     
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

