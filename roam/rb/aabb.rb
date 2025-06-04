module AABB
 # 基础AABB模块
   module AABBBehavior
     def self.included(base)
       base.extend ClassMethods
     end
 
     module ClassMethods
       def from_center(center, extent)
         min = center.zip(extent).map { |c, e| c - e/2.0 }
         max = center.zip(extent).map { |c, e| c + e/2.0 }
         new(*min, *max)
       end
 
       def from_point(*point)
         new(*point, *point)
       end
     end
 
     def merge(other)
       new_min = min_coords.zip(other.min_coords).map(&:min)
       new_max = max_coords.zip(other.max_coords).map(&:max)
       self.class.new(*new_min, *new_max)
     end
     alias :| :merge
 
     def intersection(other)
       new_min = min_coords.zip(other.min_coords).map(&:max)
       new_max = max_coords.zip(other.max_coords).map(&:min)
       self.class.new(*new_min, *new_max)
     end
     alias :& :intersection
 
     def expand(*point)
       new_min = min_coords.zip(point).map(&:min)
       new_max = max_coords.zip(point).map(&:max)
       self.class.new(*new_min, *new_max)
     end
 
     def overlaps?(other)
       min_coords.each_with_index.none? { |val, i| val > other.max_coords[i] } &&
       max_coords.each_with_index.none? { |val, i| val < other.min_coords[i] }
     end
 
     def contains?(*point)
       point.each_with_index.all? { |val, i| val.between?(min_coords[i], max_coords[i]) }
     end
 
     def strictly_contains?(*point)
       point.each_with_index.all? { |val, i| val > min_coords[i] && val < max_coords[i] }
     end
 
     def corners
       min_coords.zip(max_coords).reduce([[]]) do |product, (min, max)|
         product.product([min, max]).map(&:flatten)
       end
     end
 
     def center
       min_coords.zip(max_coords).map { |a, b| (a + b) / 2.0 }
     end
 
     def to_s
       "#{self.class.name}(min: #{min_coords}, max: #{max_coords})"
     end
 
     protected
     def min_coords; raise NotImplementedError end
     def max_coords; raise NotImplementedError end
   end
 class AABB2D
   include AABB
   attr_reader :min_x, :min_y, :max_x, :max_y
 
   def initialize(min_x, min_y, max_x, max_y)
     @min_x, @min_y = [min_x, max_x].minmax
     @max_x, @max_y = [min_y, max_y].minmax
   end
 
   protected
   def min_coords; [min_x, min_y] end
   def max_coords; [max_x, max_y] end
 end
 class Box3D
   include AABB
   attr_reader :min_x, :min_y, :min_z, :max_x, :max_y, :max_z
 
   def initialize(min_x, min_y, min_z, max_x, max_y, max_z)
     @min_x, @max_x = [min_x, max_x].minmax
     @min_y, @max_y = [min_y, max_y].minmax
     @min_z, @max_z = [min_z, max_z].minmax
   end
 
   protected
   def min_coords; [min_x, min_y, min_z] end
   def max_coords; [max_x, max_y, max_z] end
 end
end
