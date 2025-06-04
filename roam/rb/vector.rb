module V
  module VectorBehavior
      def coords
        instance_variables.map { |var| instance_variable_get(var) }
      end
  
      def +(other)
        self.class.new(*coords.zip(other.coords).map { |a, b| a + b })
      end
  
      def -(other)
        self.class.new(*coords.zip(other.coords).map { |a, b| a - b })
      end
  
      def *(scalar)
        self.class.new(*coords.map { |c| c * scalar })
      end
  
      def dot(other)
        coords.zip(other.coords).sum { |a, b| a * b }
      end
  
      def mag
        Math.sqrt(dot(self))
      end
  
      def norm
        len = mag
        self.class.new(*coords.map { |c| c / len })
      end
  
      def to_s
        "(#{coords.join(', ')})"
      end
  
      def ==(other)
        coords == other.coords
      end
    end
  def self.define_vector(dimensions)
    klass = Class.new do
      include VectorBehavior

      define_method :initialize do |*coordinates|
        #TODO: Check Dimensions

        coordinates.each_with_index do |val, i|
          instance_variable_set("@#{%w[x y z w].to_a[i]}", val)
        end
      end

      dimensions.times do |i|
        attr_reader %w[x y z w].to_a[i].to_sym
      end
    end

    const_set("Vec#{dimensions}", klass)
  end

  define_vector(2)
  define_vector(3)
  define_vector(4)

  class Vec3
    def cross(other)
      self.class.new(
        y * other.z - z * other.y,
        z * other.x - x * other.z,
        x * other.y - y * other.x
      )
    end
  end
end
