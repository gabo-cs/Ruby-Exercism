# frozen_string_literal: true

# Tally the results of a small football competition.
class Tournament
  TABLE = "%-30s | %2s | %2s | %2s | %2s | %2s\n"
  HEADINGS = %w[Team MP W D L P].freeze
  OUTCOME_PAIRS = {
    'win' => 'loss',
    'loss' => 'win',
    'draw' => 'draw'
  }.freeze
  private_constant :TABLE, :HEADINGS, :OUTCOME_PAIRS

  attr_reader :input, :teams, :result

  def self.tally(input)
    new(input).tally
  end

  def initialize(input)
    @input = input.strip
    @teams = Hash.new { |hash, key| hash[key] = Team.new(key) }
  end

  def tally
    tally_teams_stats
    teams.values
         .sort
         .map(&:stats)
         .unshift(HEADINGS)
         .map(&TABLE.method(:%))
         .join
  end

  private

  def tally_teams_stats
    input.each_line do |line|
      home, away, match_outcome = line.strip.split(';')

      teams[home].wlr << match_outcome
      teams[away].wlr << OUTCOME_PAIRS[match_outcome]
    end
  end
end

# Team class
class Team
  SCORING = {
    'win' => 3,
    'draw' => 1,
    'loss' => 0
  }.freeze
  private_constant :SCORING

  attr_reader :name, :wlr

  def initialize(name)
    @name = name
    @wlr = []
  end

  def stats
    [@name, matches, wins, draws, losses, points]
  end

  def <=>(other)
    [-points, name] <=> [-other.points, other.name]
  end

  protected

  def matches
    @wlr.length
  end

  def wins
    @wlr.count('win')
  end

  def losses
    @wlr.count('loss')
  end

  def draws
    @wlr.count('draw')
  end

  def points
    @wlr.sum(&SCORING)
  end
end
