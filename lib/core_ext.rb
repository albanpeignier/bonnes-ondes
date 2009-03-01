class Array

  def many?
    self.size > 1
  end

end

class Time

  def future?
    self > ::Time.current
  end

end
