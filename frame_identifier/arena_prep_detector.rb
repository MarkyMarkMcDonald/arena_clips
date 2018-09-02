require 'chunky_png'

class Detector
  WIDTH_OFFSET = 605
  BOX_WIDTH = 72

  HEIGHT_OFFSET = 313
  BOX_HEIGHT = 94

  HEIGHT_RANGE = HEIGHT_OFFSET..(HEIGHT_OFFSET + BOX_HEIGHT)
  WIDTH_RANGE = WIDTH_OFFSET..(WIDTH_OFFSET + BOX_WIDTH)

  def initialize
  end

  def countdown?(file_path)
    image = ChunkyPNG::Image.from_file(file_path)

    good_colors = 0
    WIDTH_RANGE.each do |width|
      HEIGHT_RANGE.each do |height|
        color = image.get_pixel(width, height)
        if ChunkyPNG::Color.r(color) > 150
          good_colors += 1
        end
      end
    end

    area = BOX_WIDTH * BOX_HEIGHT
    good_colors > (area * 0.1)
  end
end
