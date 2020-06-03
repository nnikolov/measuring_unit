class String
  def to_inch
    # Convert spaces into quotes
    tmp = self.strip.sub(/([ ]+)/, '"')
    # Convert multiple quotes into a single quote
    Inch.new(tmp.sub(/([\"]+)/, '"'))
  end

  alias inch to_inch
  alias inches to_inch
end

class Fixnum
  def mm_to_inch
    Inch.mm_to_inch(self)
  end

  def inches
    self.to_s.to_inch
  end

  def to_inch
    "#{self}".to_inch
  end

  alias inch inches
end

class Float
  def to_inch
    self.to_r.to_inch
  end

  alias inch to_inch
  alias inches to_inch
end

class Rational
  def to_inch
    sign = self < 0.to_r ? '-' : nil
    whole = self.to_i
    numerator = "#{self.numerator.abs % self.denominator}"
    fraction = self.denominator > 1 ? "#{numerator}/#{self.denominator}" : ''
    return Inch.new("#{sign}#{whole.abs}") if fraction == ''
    "#{sign}#{whole.abs} #{fraction}".to_inch
  end
end

class Inch < String

  def display
    return nil if self.nil? or self == ' ' or self == ''
    #ret = self.sub(/[ ]/, '"')
    ret = self.sub(/["]+/,' ').sub(/([\s]+)/,'"')
    ret.include?("\"") ? ret.inch : "#{ret}\"".inch
  end

  def >(other)
    self.to_inch.to_r > other.to_inch.to_r
  end

  def <(other)
    self.to_inch.to_r < other.to_inch.to_r
  end

  def +(other)
    (self.to_inch.to_r + other.to_inch.to_r).to_inch
  end

  def -(other)
    (self.to_inch.to_r - other.to_inch.to_r).to_inch
  end

  def *(other)
    (self.to_inch.to_r * other.to_inch.to_r).to_inch
  end

  def /(other)
    (self.to_inch.to_r / other.to_inch.to_r).to_inch
  end

  def fraction
    return self.sub(/["]+/,'') if self[-1] == "\""
    has_quotes? ? self.split('"')[1].to_s.to_r : self.to_s.to_r
  end

  def to_r
    sign = "-" if self[0] == '-'
    # Remove the quotes and return the number if number like 15" or 1/2"
    return self.sub(/["]+/,'').to_s.to_r if self[-1] == "\""
    # If a whole number and a fraction, add the two
    has_quotes? ? "#{sign}#{self.fraction + self.to_i.abs}".to_r : self.fraction
  end

  def to_f
    self.to_r.to_f
  end

  def to_mm
    Milimeter.new((self.to_f * 25.4).round(2))
  end

  def coerce(other)
    [to_mm, other]
  end

  def nearest(precision)
    p = precision.to_inch.to_r
    ((self.to_r / p).round * p).to_inch
  end

  def self.mm_to_inch(mm)
    (mm * 0.0393701).to_inch
  end

  def sqrt
    Math.sqrt(self.to_f).to_r.to_inch
  end

  private

  def has_quotes?
    self.include?('"')
  end

  def method_missing(meth, *args, &block)
    self.to_r.send(meth, *args, &block).to_r.to_inch
  rescue
    super
  end

end
