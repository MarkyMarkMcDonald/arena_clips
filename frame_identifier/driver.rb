require_relative './timeline'
require_relative './arena_prep_detector'

class Driver
  def initialize(directory)
    @directory = directory
  end

  def timeline
    count = 0

    puts "\n"

    events = Dir.foreach(@directory).map do |path|
      p '.'
      next unless path.start_with?('frame_')
      count += 1
      break if count >= 285

      real_path = "#{@directory}/#{path}"
      countdown = Detector.new.countdown?(real_path)

      if countdown
        :countdown
      else
        :nothing
      end
    end.compact

    puts "events: #{events}"

    Timeline.new(events).partition
  end
end

directory = '../examples/1/frames/'

puts Driver.new(directory).timeline

puts "expected something like"
puts "00:52 01:03 GAME_START_COUNTDOWN"
puts "02:12 02:14 GAME_END_SCOREBOARD"
puts "04:29 04:39 GAME_START_COUNTDOWN"
puts "09:19 09:21 GAME_END_SCOREBOARD"
puts "13:48 13:58 GAME_START_COUNTDOWN"
puts "14:58 15:01 GAME_END_SCOREBOARD"
puts "16:29 16:39 GAME_START_COUNTDOWN"
puts "17:38 17:39 GAME_END_SCOREBOARD"
