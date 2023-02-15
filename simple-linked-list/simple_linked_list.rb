# Singly Linked List - Element/Node class
class Element
  attr_reader :value
  attr_accessor :next
  alias datum value

  def initialize(value)
    @value = value
  end
end

# Singly Linked List - List class
class SimpleLinkedList
  private

  attr_accessor :head, :tail

  def initialize(source = [])
    create_list_from(source)
  end

  def empty?
    [head, tail].none?
  end

  def create_list_from(source)
    source.each { |value| push(Element.new(value)) }
  end

  public

  def push(element)
    if empty?
      self.head = element
      self.tail = element
    else
      # This must be LIFO.
      # Point element to current head
      element.next = head
      # Reassign head to new element
      @head = element
    end
    self
  end

  def pop
    return nil if empty?

    current_head = head

    # Reassign head to current head's next, i.e. second element
    self.head = current_head.next
    # Empty current_head next reference (as this element is being deleted) and return it
    current_head.next = nil
    current_head
  end

  def to_a
    return [] if empty?

    pointer = head
    data = []
    while pointer
      data << pointer.value
      pointer = pointer.next
    end
    data
  end

  def reverse!
    return self if empty?

    pointer = head
    # Since this is not a circular linked list, there's no previous node, so
    # we're going to "simulate" one in order to make the reverse easier.
    previous = nil
    while pointer
      # Temporarily store the next element
      temp = pointer.next
      # Point current element to previous, which starts at nil.
      pointer.next = previous
      # Reassign previous to pointer so it's the previous element in the next iteration
      previous = pointer
      # Reassign pointer to temp, the "original" next element that we first stored.
      pointer = temp
    end
    # Swap head and tail
    self.head, self.tail = tail, head
    self
  end
end
