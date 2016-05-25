String.class_eval do
  def to_unit(default="Inch")
    klass = MeasuringUnit.guess_unit(self,default)
    klass.constantize.new(self).display
  end
end
