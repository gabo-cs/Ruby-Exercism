# Given the position of two queens on a chess board,
# indicate whether or not they are positioned so that they can attack each other.
class Queens
  VALID_COORDINATES = ->(file, rank) { file.between?(0, 7) && rank.between?(0, 7) }
  private_constant :VALID_COORDINATES

  def attack?
    on_same_file? || on_same_rank? || on_same_diagonal?
  end

  private

  attr_reader :white, :black

  def initialize(white: [0, 0], black: [7, 7])
    @white = white
    @black = black

    raise ArgumentError unless valid_squares?
  end

  def valid_squares?
    white != black &&
      [white, black].all? { |coords| VALID_COORDINATES.(*coords) }
  end

  def on_same_file?
    white[0] == black[0]
  end

  def on_same_rank?
    white[1] == black[1]
  end

  def on_same_diagonal?
    (white[0] - black[0]).abs == (white[1] - black[1]).abs
  end
end
