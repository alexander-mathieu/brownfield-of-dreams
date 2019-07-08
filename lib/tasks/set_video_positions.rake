# lib/tasks/set_video_positions.rake

namespace :videos do
  desc 'Set missing video positions in db'
    task set_position_if_missing: :environment do
      while Video.where(position: nil).exists?
        Video.where(position: nil).each do |null_pos_vid|
          videos = Video.where(tutorial_id: null_pos_vid.tutorial_id)

          @position_counter = 1
          videos.each do |video|
            video.update(position: @position_counter)
            @position_counter += 1
          end
        end
      end

      puts 'All video positions have been updated.'
    end
end
