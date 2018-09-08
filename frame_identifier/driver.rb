require_relative './timeline'
require_relative './arena_prep_detector'

def frame_test(file)
  file.start_with?('frame_')
end

class Driver
  def initialize(frame_directory, files, detector = Detector.new, frame_test = method(:frame_test))
    @frame_directory = frame_directory
    @files = files
    @detector = detector
    @frame_test = frame_test
  end

  def timeline
    events = frames.map do |path|
      print '.'
      $stdout.flush
      real_path = "#{@frame_directory}/#{path}"

      next :countdown if @detector.countdown?(real_path)
      next :ending if @detector.ending?(real_path)
      :nothing
    end

    events.compact!

    puts "\n"

    Timeline.new(events).partition
  end

  private

  def frames
    @files.select(&@frame_test)
  end
end
