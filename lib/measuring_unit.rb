require 'measuring_unit/core_ext'
require 'measuring_unit/inch'
require 'measuring_unit/milimeter'

module MeasuringUnit
 
  def self.guess_unit(measurement, default="Inch")
    return "Milimeter" if measurement.to_s.include?("mm")
    return "Inch" if measurement.to_s.include?("\"") or measurement.to_s.include?("/") or measurement.to_s.strip.include?(" ")
    return default
    rescue
      return "Inch"
  end
 
end
