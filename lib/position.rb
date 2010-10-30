require "matrix"

class Position

  class << self
    def rot(mat, direction)
      mat * rotate_matrix(direction_to_degree(direction)).map(&:to_i)
    end

    def relative(base_xy, relative_xy, direction)
      mat = relative_matrix(Matrix[base_xy], Matrix[relative_xy], direction)
      [mat[0, 0], mat[0, 1]]
    end

    private
    def direction_to_degree(direction)
      [0, 270, 180, 90].at(direction) or raise "invalid direction #{direction}"
    end

    def relative_matrix(base_mat, relative_mat, direction)
      base_mat + rot(relative_mat, direction)
    end

    def rotate_matrix(degree)
      beta = degree * Math::PI / 180
      return Matrix[
        [Math.cos(beta), - Math.sin(beta)],
        [Math.sin(beta),   Math.cos(beta)]
      ]
    end
  end
end

