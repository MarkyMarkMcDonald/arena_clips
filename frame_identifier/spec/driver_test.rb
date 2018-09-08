require_relative '../driver'

puts "Expect one event starting on frame 12 and ending on frame 21"

$events_list = [
    :nothing,
    :nothing,
    :nothing,
    :nothing,
    :nothing,
    :nothing,
    :nothing,
    :countdown,
    :countdown,
    :countdown,
    :countdown,
    :countdown,
    :countdown,
    :nothing,
    :nothing,
    :nothing,
    :nothing,
    :nothing,
    :nothing,
    :nothing,
    :nothing,
    :nothing,
    :ending,
    :ending,
    :nothing,
    :nothing,
]

class FakeDetector
  def initialize
    @calls = 0
  end

  def countdown?(_path)
    ($events_list[@calls] == :countdown).tap do
      @calls += 1
    end
  end

  def ending?(_path)
    $events_list[@calls] == :ending
  end
end

stubbed_frame_test = proc {true}
timeline = Driver.new('', (1..$events_list.length).to_a, FakeDetector.new, stubbed_frame_test).timeline

puts timeline