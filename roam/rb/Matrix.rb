module M
  module MatrixBehavior
    attr_reader :rows, :cols
    def *(other)
      if other.is_a?(Numeric)
        self.class.new(*(rows.map { |row| row.map { |v| v * other } }))
      else
        raise "Dimension mismatch" unless cols == other.rows
        product = []
        to_rows.each do |row|
          new_row = []
          other.to_rows.transpose.each do |col|
            new_row << row.zip(col).sum { |a,b| a * b }
          end
          product << new_row
        end
        self.class.new(*product)
      end
    end
  
    def to_rows
      @data.each_slice(@cols).to_a
    end
  
    def [](row, col)
      # Check Shape
      @data[row * @cols + col]
    end
  
    def []=(row, col, value)
      # Check Shape
      @data[row * @cols + col] = value
    end
  
    def +(other)
      self.class.new(*(rows.zip(other.rows).map { |r1, r2| r1.zip(r2).map { |a,b| a + b } }))
    end
  
    def -(other)
      self.class.new(*(rows.zip(other.rows).map { |r1, r2| r1.zip(r2).map { |a,b| a - b } }))
    end
  
    def transpose
      self.class.new(*rows.transpose)
    end
  
    def to_s
      to_rows.map { |r| "(#{r.join(', ')})" }.join("\n")
    end
  
    def ==(other)
      rows == other.rows
    end
  
  end
  def self.define_matrix(rows, cols)
    klass = Class.new do
      include MatrixBehavior

      define_method :initialize do |*values|
        @rows = rows
        @cols = cols
        # Check Shape
        @data = values.flatten
      end

      rows.times do |i|
        define_method("row#{i}") { rows[i] }
      end
    end

    const_set("Mat#{rows}x#{cols}", klass)
  end

  define_matrix(2, 2)
  define_matrix(3, 3)
  define_matrix(4, 4)

  class Mat3x3
    def det
      a, b, c = row0
      d, e, f = row1
      g, h, i = row2
      a*(e*i - f*h) - b*(d*i - f*g) + c*(d*h - e*g)
    end
  end
end

