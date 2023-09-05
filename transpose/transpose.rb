# frozen_string_literal: true

# Given an input text output it transposed.
module Transpose
  def self.transpose(input)
    input = input.split("\n")
    length = input.map(&:size).max
    input.map { |row| row.ljust(length, "\0").chars }
         .transpose
         .map(&:join)
         .join("\n")
         .gsub(/\0+$/, '')
         .gsub(/\0/, ' ')
  end
end
