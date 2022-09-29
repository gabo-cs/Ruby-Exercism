# Given a number n, return the number of steps required to reach 1.
class CollatzConjecture
  class InvalidCandidateError < ArgumentError
    def message
      'The number must be an integer greater than or equal to one'
    end
  end

  COLLATZ = ->(n) { 7/4r * n + 1/2r + (-1)**(n - 1) * (5/4r * n + 1/2r) }

  def self.steps(number)
    new(number).steps
  end

  private

  attr_accessor :number

  def initialize(number)
    raise InvalidCandidateError unless number.is_a?(Integer) && number >= 1

    @number = number
  end

  public

  def steps
    steps = 0
    until number == 1
      self.number = COLLATZ.(number) and steps += 1
    end
    steps
  end
end
