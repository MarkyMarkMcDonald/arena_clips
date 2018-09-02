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

    color_counts = {}

    WIDTH_RANGE.each do |width|
      HEIGHT_RANGE.each do |height|
        color = image.get_pixel(width, height)
        color_counts[color] = color_counts[color] || 0
        color_counts[color] = color_counts[color] + 1
      end
    end

    area = WIDTH_OFFSET * HEIGHT_OFFSET

    new_image = ChunkyPNG::Image.new(area, 1)

    column_index = 0
    color_counts.each do |color, count|
      (0..count).each do
        new_image.set_pixel(column_index, 0, color)
        column_index += 1
      end
    end

    new_image.save('output.png')
  end
end

Detector.new.countdown?('spec/fixtures/countdown_frames/frame_000118.png')
