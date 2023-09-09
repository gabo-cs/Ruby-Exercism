# frozen_string_literal: true

# Evaluate simple math word problems returning the answer as an integer
class WordProblem
  class InvalidProblem < ArgumentError; end

  OPERATIONS = {
    'plus' => '+',
    'minus' => '-',
    'multiplied by' => '*',
    'divided by' => '/'
  }.freeze
  private_constant :OPERATIONS

  attr_reader :problem

  def initialize(problem)
    @problem = problem
  end

  def answer
    raise InvalidProblem unless valid_problem?

    result
  end

  private

  def valid_problem?
    operands.any? && operations.any? &&
      operands.count != operations.count
  end

  def result
    result = operands.first
    operations.each_with_index do |operation, i|
      operand = operands[i + 1]
      result = result.public_send(operation, operand)
    end
    result
  end

  def operands
    problem
      .scan(/-?\d+/)
      .map(&:to_i)
  end

  def operations
    problem
      .scan(/#{OPERATIONS.keys.join('|')}/)
      .map(&OPERATIONS)
  end
end
