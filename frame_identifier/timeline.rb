class Timeline
  def initialize(timeline)
    @timeline = timeline
  end

  def partition
    game_starts = []
    game_ends = []
    in_game = false

    @timeline.each.with_index do |event, index|
      next unless index >= 10

      if !in_game
        last_ten_frames = @timeline[(index - 10)..index]
        if last_ten_frames.select { |f| f == :countdown}.count >= 6
          game_starts << index
          in_game = true
        end
      else
        if event == :ending
          game_ends << index
          in_game = false
        end
      end
    end

    game_starts.zip(game_ends).map do |game_start, game_end|
      {
          game_start: game_start,
          game_end: game_end
      }
    end
  end
end
