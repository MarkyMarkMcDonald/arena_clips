require_relative '../driver'

directory = '../../examples/1/frames/'

puts Driver.new(directory, Dir.entries(directory)).timeline

puts "expected something like"
puts "00:52 01:03 GAME_START_COUNTDOWN"
puts "02:12 02:14 GAME_END_SCOREBOARD"
puts "04:29 04:39 GAME_START_COUNTDOWN"
puts "09:19 09:21 GAME_END_SCOREBOARD"
puts "13:48 13:58 GAME_START_COUNTDOWN"
puts "14:58 15:01 GAME_END_SCOREBOARD"
puts "16:29 16:39 GAME_START_COUNTDOWN"
puts "17:38 17:39 GAME_END_SCOREBOARD"
