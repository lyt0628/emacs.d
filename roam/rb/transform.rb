require './Point.rb'
require './vector.rb'
require './matrix.rb'

class Transform2D

end

class Transform3D
  def initialize(matrix, inversed_matrix)
    @matrix = matrix
    @inversed_matrix = inversed_matrix
  end
end

print "ok"
