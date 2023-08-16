# frozen_string_literal: true

# Given a list of inputs, generate the relevant proverb.
class Proverb
  attr_reader :list, :qualifier

  def initialize(*list, qualifier: nil)
    @list = list
    @qualifier = qualifier
  end

  def to_s
    list.each_cons(2).map do |wanted, lost|
      format(single_consequence, wanted: wanted, lost: lost)
    end.join + final_consequence
  end

  private

  def single_consequence
    "For want of a %<wanted>s the %<lost>s was lost.\n"
  end

  def final_consequence
    "And all for the want of a #{qualifier} #{list.first}.".gsub(/\s+/, ' ')
  end
end
