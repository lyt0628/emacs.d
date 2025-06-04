require './vector'

module CG
  module NormalBehavior
    include VectorBehavior  # 复用向量基础行为

    def initialize(*coordinates)
      super(*coordinates)
      normalize!  # 法向量初始化时自动标准化
    end

    # 强制保持单位长度
    def normalize!
      len = mag
      raise "Zero-length normal" if len == 0
      coords.each_with_index do |c, i|
        instance_variable_set("@#{%w[x y z w][i]}", c / len)
      end
      self
    end

    # 法向量反射计算 (入射向量 -> 反射向量)
    def reflect(incident)
      incident - self * 2 * incident.dot(self)
    end

    # 法向量折射计算 (斯涅尔定律)
    def refract(incident, eta)
      cosi = -incident.dot(self)
      k = 1 - eta**2 * (1 - cosi**2)
      k < 0 ? nil : incident * eta + self * (eta * cosi - Math.sqrt(k))
    end

    # 重写运算符保持单位长度
    def *(scalar)
      super.normalize!
    end

    def +(other)
      super.normalize!
    end
  end

  def self.define_normal(dimensions)
    klass = Class.new(const_get("Vec#{dimensions}")) do
      include NormalBehavior
    end
    const_set("Norm#{dimensions}", klass)
  end

  define_normal(3)  # 主要使用三维法向量
end

puts "ok"
