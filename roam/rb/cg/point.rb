require './vector'

module CG
  module PointBehavior
    def coords
      instance_variables.map { |var| instance_variable_get(var) }
    end
  
    # 点减点得到向量
    def -(other)
      V::Vec3.new(*coords.zip(other.coords).map { |a, b| a - b })
    end
  
    # 点加向量得到新点
    def +(vector)
      self.class.new(*coords.zip(vector.coords).map { |a, b| a + b })
    end
  
    # 点到点距离
    def distance_to(other)
      (self - other).mag
    end
  
    def to_s
      "Point(#{coords.join(', ')})"
    end
  
    def ==(other)
      coords == other.coords
    end
  end
  def self.define_point(dimensions)
    klass = Class.new do
      include PointBehavior

      define_method :initialize do |*coordinates|
        raise "Dimension mismatch" if coordinates.size != dimensions
        coordinates.each_with_index do |val, i|
          instance_variable_set("@#{%w[x y z w][i]}", val.to_f)
        end
      end

      dimensions.times do |i|
        attr_reader %w[x y z w][i].to_sym
      end
    end

    const_set("Point#{dimensions}D", klass)
  end

  define_point(2)
  define_point(3)
  define_point(4)
end

