# A binary search algorithm.
class BinarySearch
  HALF = ->(left, right) { (left + right) / 2 }
  private_constant :HALF

  private

  attr_reader :list

  def initialize(list)
    @list = list
  end

  public

  def search_for(target)
    left = 0
    right = list.length - 1
    while left <= right
      middle = HALF[left, right]
      if list[middle] > target
        right = middle - 1
      elsif list[middle] < target
        left = middle + 1
      else
        return middle
      end
    end
  end
end
