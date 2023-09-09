# Create a roster for the school.
class School
  attr_reader :registry

  def initialize
    @registry = Hash.new { |hash, key| hash[key] = [] }
  end

  def roster
    sorted_registry.values.flatten
  end

  def add(student, grade)
    return failure if roster.include?(student)

    registry[grade].push(student)
    success
  end

  def grade(grade)
    sorted_registry.fetch(grade, [])
  end

  private

  def sorted_registry
    registry
      .sort
      .to_h
      .transform_values(&:sort)
  end

  def success; true; end
  def failure; false; end
end
