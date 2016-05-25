class Fixnum
  def to_mm
    Milimeter.new(self)
  end

  alias mm to_mm
  alias milimeter to_mm
  alias milimeters to_mm
end

class Float
  def to_mm
    #Milimeter.new(self)
    self.to_s.to_mm
  end

  alias mm to_mm
  alias milimeter to_mm
  alias milimeters to_mm
end

class String
  def to_mm
    self.slice!("mm")
    Milimeter.new(self.strip)
  end
end

class Milimeter
  def initialize(number)
    @number = number.to_f
  end

  def display
    return nil if self.nil? or self == ' ' or self == ''
    "#{self.to_s}mm"
  end

  def coerce(other)
    [@number, other]
  end

  def +(other)
    (@number.to_s.to_f + other.to_mm.to_s.to_f).to_mm
  end

  def -(other)
    (@number.to_s.to_f - other.to_mm.to_s.to_f).to_mm
  end

  def *(other)
    (@number.to_s.to_f * other.to_mm.to_s.to_f).to_mm
  end

  def /(other)
    (@number.to_s.to_f / other.to_mm.to_s.to_f).to_mm
  end

  def ==(other)
    @number.to_s.to_f == other.to_s.to_f
  end

  def to_f
    @number.to_s.to_f
  end

  def to_inch
    Inch.mm_to_inch(@number)
  end

  def to_s
    "#{@number}"
  end

  def nearest(param)
    self
  end

  def to_unit
    self
  end

  def method_missing(name, *args, &blk)
    ret = @number.send(name, *args, &blk)
    return Milimeter.new(ret) if ret.is_a?(Numeric)
    return self if inch_method?(name)
    ret
  end

  def inch_method?(name)
    Inch.new.respond_to?(name) 
  end

  def sqrt
    Math.sqrt(self.to_f).to_s.to_mm
  end
end
