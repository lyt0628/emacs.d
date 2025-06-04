require './matrix'

module CG
  class Transform3
    attr_reader :matrix, :inversed_matrix

    def initialize(matrix, inversed_matrix = nil)
      @matrix = matrix
      if inversed_matrix.nil?
        @inversed_matrix = matrix.inverse
      else
        @inversed_matrix = inversed_matrix
      end
        
    end

    def inverse()
      Transform3.new @inversed_matrix, @matrix
    end

    def transpose()
      Transform3.new @matrix.transpose, @inversed_matrix.transpose
    end
    # Combine with another transform (matrix multiplication)
    def *(other)
      Transform3.new(@matrix * other.matrix)
    end

    # Translation
    def self.translation(x, y, z)
      Transform3.new(CG::Mat4x4.new(
                      1, 0, 0, x,
                      0, 1, 0, y,
                      0, 0, 1, z,
                      0, 0, 0, 1
                    ))
    end
    
    # Scaling
    def self.scaling(x, y, z)
      Transform3.new(CG::Mat4x4.new(
                      x, 0, 0, 0,
                      0, y, 0, 0,
                      0, 0, z, 0,
                      0, 0, 0, 1
                    ))
    end

    # Rotation around X axis (angle in radians)
    def self.rotation_x(angle)
      c = Math.cos(angle)
      s = Math.sin(angle)
      Transform3.new(CG::Mat4x4.new(
                      1, 0,  0, 0,
                      0, c, -s, 0,
                      0, s,  c, 0,
                      0, 0,  0, 1
                    ))
    end

    # Rotation around Y axis (angle in radians)
    def self.rotation_y(angle)
      c = Math.cos(angle)
      s = Math.sin(angle)
      Transform3.new(CG::Mat4x4.new(
                      c, 0, s, 0,
                      0, 1, 0, 0,
                      -s, 0, c, 0,
                      0, 0, 0, 1
                    ))
    end

    # Rotation around Z axis (angle in radians)
    def self.rotation_z(angle)
      c = Math.cos(angle)
      s = Math.sin(angle)
      Transform3.new(CG::Mat4x4.new(
                      c, -s, 0, 0,
                      s,  c, 0, 0,
                      0,  0, 1, 0,
                      0,  0, 0, 1
                    ))
    end

    # Rotation around arbitrary axis (angle in radians)
    def self.rotation(axis, angle)
      axis = axis.norm
      x, y, z = axis.coords
      c = Math.cos(angle)
      s = Math.sin(angle)
      t = 1 - c

      Transform3.new(CG::Mat4x4.new(
                      t*x*x + c,   t*x*y - z*s, t*x*z + y*s, 0,
                      t*x*y + z*s, t*y*y + c,   t*y*z - x*s, 0,
                      t*x*z - y*s, t*y*z + x*s, t*z*z + c,   0,
                      0, 0, 0, 1
                    ))
    end

    # View transformation (look-at matrix)
    def self.look_at(eye, target, up)
      forward = (target - eye).norm
      right = forward.cross(up.norm).norm
      new_up = right.cross(forward)

      orientation = CG::Mat4x4.new(
        right.x, right.y, right.z, 0,
        new_up.x, new_up.y, new_up.z, 0,
        -forward.x, -forward.y, -forward.z, 0,
        0, 0, 0, 1
      )
    
      translation = Transform.translation(-eye.x, -eye.y, -eye.z)
      Transform3.new(orientation) * translation
    end
    def call(v)
      
    end
    def to_s
      @matrix.to_s
    end

  end
end

# Create transformations
translation = CG::Transform3.translation(10, 5, 2)
rotation = CG::Transform3.rotation_x(Math::PI/2)
scale = CG::Transform3.scaling(2, 2, 2)

# Combine transformations
transform = translation * rotation * scale

puts transform
