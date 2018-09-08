require_relative '../arena_prep_detector'

detector = Detector.new

def check_directory(detector, directory_path)
  Dir.foreach(directory_path) do |path|
    next unless path.start_with?('frame_')
    real_path = "#{directory_path}/#{path}"
    countdown = detector.countdown?(real_path)
    ending = detector.ending?(real_path)
    puts "#{real_path} - countdown: #{countdown}, ending: #{ending}"
  end
end

puts "Countdown:"
check_directory(detector, 'fixtures/countdown_frames')
puts "Random:"
check_directory(detector, 'fixtures/random_frames')
puts "Ending:"
check_directory(detector, 'fixtures/ending_frames')


