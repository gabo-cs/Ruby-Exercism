# frozen_string_literal: true

# Output the lyrics to 'The Twelve Days of Christmas'.
class TwelveDays
  class << self
    ORDINALS = %w[first second third fourth fifth sixth seventh eighth ninth tenth
                  eleventh twelfth].freeze
    GIFTS = [
      'a Partridge in a Pear Tree',
      'two Turtle Doves',
      'three French Hens',
      'four Calling Birds',
      'five Gold Rings',
      'six Geese-a-Laying',
      'seven Swans-a-Swimming',
      'eight Maids-a-Milking',
      'nine Ladies Dancing',
      'ten Lords-a-Leaping',
      'eleven Pipers Piping',
      'twelve Drummers Drumming'
    ].freeze
    private_constant :ORDINALS, :GIFTS

    def song
      verses(1, 12)
    end

    private

    def verse(number)
      "On the #{ORDINALS[number]} day of Christmas my true love gave to me: #{gifts_per_amount(number)}\n"
    end

    def verses(first_verse, last_verse)
      (first_verse..last_verse).map { |n| verse(n - 1) }.join("\n")
    end

    def gifts_per_amount(day)
      first_gift = "#{GIFTS[0]}."
      return first_gift if day.zero?

      "#{GIFTS[1..day].reverse.join(', ')}, and #{first_gift}"
    end
  end
end
