# frozen_string_literal: true

# Implement the keep and discard operation on collections
class Array
  def keep
    each_with_object([]) do |item, result|
      result << item if yield(item)
    end
  end

  def discard
    each_with_object([]) do |item, result|
      result << item unless yield(item)
    end
  end
end
