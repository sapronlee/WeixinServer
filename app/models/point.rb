class Point
  
  attr_reader :lat, :lng
  
  def initialize(lng, lat)
    @lng, @lat = lng, lat
  end
  
  def mongoize
    [@lng, @lat]
  end
  
  class << self
    def demongoize(object)
      return nil if object.nil?
      Point.new(object[0], object[1])
    end

    def mongoize(object)
      case object
      when Point then object.mongoize
      when Hash then Point.new(object[:lng], object[:lat]).mongoize
      else object
      end
    end

    def evolve(object)
      case object
      when Point then object.mongoize
      else object
      end
    end
  end
end