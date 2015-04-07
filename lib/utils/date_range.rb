class DateRange < Range
  # step is similar to DateTime#advance argument
  def every(step)
    step_time = self.begin.to_datetime
    end_time = self.end.to_datetime
    less_than = self.exclude_end? ? :< : :<=
    while step_time.send(less_than, end_time) do 
      yield step_time
      step_time = step_time.advance(step)
    end
  end

  def to_s
    "DateRange(DateTime.parse(\"#{self.begin}\")..DateTime.parse(\"#{self.end}\"))"
  end

  def self.today
    DateRange(Time.now..Time.now)
  end

  def self.since(date_or_time)
    date_or_time = Time.at(date_or_time) if date_or_time.is_a? Integer
    DateRange(date_or_time..Time.now)
  end
end

# Convenience method to deeserialize date ranges
def DateRange(range)
  if range.is_a? String
    DateRange.class_eval(range)
  elsif range.is_a? DateRange
    range
  elsif range.is_a? Range
    DateRange.new(range.begin, range.end, range.exclude_end?)
  end
end
