require 'date'

module DescriptorRefinement
  refine Array do
    def second; self[1]; end
    def third; self[2]; end
    def fourth; self[3]; end
    def fifth; self[4]; end
  end
end

# Calculate the date of meetups.
class Meetup
  SYMBOLIZE_DOWNCASE = ->(something) { something.downcase.intern }
  DAY_NAMES = Date::DAYNAMES.map { |dayname| SYMBOLIZE_DOWNCASE.call(dayname) }
  TEEN_WEEK = (13..19)
  private_constant :SYMBOLIZE_DOWNCASE, :DAY_NAMES, :TEEN_WEEK

  using DescriptorRefinement

  private

  attr_reader :month, :year

  def initialize(month, year)
    @month = month
    @year = year
  end

  # Takes 13th and goes all the way up to 19th and creates a hash.
  def teenth_days
    TEEN_WEEK.each_with_object({}) do |day, teenth_days|
      teenth_date = Date.new(year, month, day)
      teenth_days[SYMBOLIZE_DOWNCASE.call(teenth_date.strftime('%A'))] = teenth_date
    end
  end

  def month_days
    days = (1..date.next_month.prev_day.day).to_a
    date.wday.times { days.unshift(nil) }
    days
  end

  def month_weeks
    month_days.each_slice(7)
  end

  # Array of all specific days of a month: e.g. for 9/2013 sundays 1, 8, 15, ...
  def same_days(wday)
    month_weeks.map { |week| week[wday] }.compact
  end

  def date
    @date ||= Date.new(year, month)
  end

  public

  def day(day_name, descriptor)
    return teenth_days[day_name] if descriptor == :teenth

    final_day = same_days(DAY_NAMES.index(day_name)).send(descriptor)
    Date.new(year, month, final_day)
  end
end
