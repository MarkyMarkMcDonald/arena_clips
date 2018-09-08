require 'chunky_png'

class Window
  def initialize(width_offset:, height_offset:, width:, height:)
    @width_offset = width_offset
    @height_offset = height_offset
    @width = width
    @height = height
  end

  def width_range
    @width_offset..(@width_offset + @width)
  end

  def height_range
    @height_offset..(@height_offset + @height)
  end

  def area
    @width * @height
  end
end

class Detector
  COUNTDOWN_WINDOW = Window.new(width_offset: 605, height_offset: 313, width: 72, height: 94)
  ENDING_WINDOW = Window.new(width_offset: 347, height_offset: 352, width: 550, height: 120)

  def initialize
  end

  def countdown?(file_path)
    image = ChunkyPNG::Image.from_file(file_path)

    good_colors = in_window(image, COUNTDOWN_WINDOW).select do |color|
      ChunkyPNG::Color.r(color) > 150
    end

    good_colors.count > COUNTDOWN_WINDOW.area * 0.1
  end

  def ending?(file_path)
    image = ChunkyPNG::Image.from_file(file_path)

    good_colors = in_window(image, ENDING_WINDOW).select do |color|
      ChunkyPNG::Color.r(color) < 25 &&
      ChunkyPNG::Color.g(color) < 25 &&
      ChunkyPNG::Color.b(color) < 25
    end

    good_colors.count > ENDING_WINDOW.area * 0.9
  end

  private

  def in_window(image, window)
    Enumerator.new do |y|
      window.width_range.each do |width|
        window.height_range.each do |height|
          y << image.get_pixel(width, height)
        end
      end
    end
  end
end
