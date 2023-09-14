# frozen_string_literal: true

# Implementation of the rotational cipher, a.k.a. the Caesar cipher.
class RotationalCipher
  ALPHABET = ('a'..'z').to_a
  private_constant :ALPHABET

  attr_reader :text, :key

  def self.rotate(text, key)
    new(text, key).rotate
  end

  def initialize(text, key)
    @text = text
    @key = key
  end

  def rotate
    text.each_char.map do |char|
      rotate_char(char)
    end.join
  end

  private

  def rotate_char(char)
    return char unless char.match?(/[a-zA-Z]/)

    if char.match?(/[a-z]/)
      rotate_lowercase_char(char)
    else
      rotate_uppercase_char(char)
    end
  end

  def rotate_lowercase_char(char)
    rot_key = (ALPHABET.index(char) + key) % ALPHABET.count
    ALPHABET[rot_key]
  end

  def rotate_uppercase_char(char)
    rotate_lowercase_char(char.downcase).upcase
  end
end
