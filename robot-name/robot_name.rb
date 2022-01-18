# Manage robot factory settings.
class Robot
  NAMES = 'AA000'..'ZZ999'

  def self.forget
    @@names = NAMES.to_a.shuffle.each
  end

  private

  def initialize
    @name = names.next
  end

  alias :reset :initialize

  def names
    @@names
  end

  public

  public :reset

  attr_reader :name
end
