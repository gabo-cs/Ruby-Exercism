# Singly Linked List - Element/Node class
class Element
  attr_reader :value
  attr_accessor :next
  alias datum value

  def initialize(value)
    @value = value
    @next = nil
  end
end

# Singly Linked List - List class
class SimpleLinkedList
  attr_accessor :head, :tail

  def initialize(source = nil)
    @head = nil
    @tail = nil
    create_list_from(source) unless source.nil?
  end

  def push(element)
    if empty?
      @head = element
      @tail = element
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
    @head = current_head.next
    # Empty current_head next reference (as this element is being deleted) and return it
    current_head.next = nil
    current_head
  end

  def to_a
    return [] if empty?

    ptr = head
    data = []
    until ptr.nil?
      data << ptr.value
      ptr = ptr.next
    end
    data
  end

  def reverse!
    return self if empty?

    ptr = head
    # Since this is not a circular linked list, there's no previous node, so
    # we're going to "simulate" one in order to make the reverse easier.
    prev = nil
    until ptr.nil?
      # Temporarily store the next element
      temp = ptr.next
      # Point current element to prev, which starts at nil.
      ptr.next = prev
      # Reassign prev to ptr so it's the previous element in the next iteration
      prev = ptr
      # Reassign ptr to temp, the "original" next element that we first stored.
      ptr = temp
    end
    # Swap head and tail
    @head, @tail = tail, head
    self
  end

  private

  def empty?
    head.nil? && tail.nil?
  end

  def create_list_from(source)
    source.each { |val| push(Element.new(val)) }
  end
end
