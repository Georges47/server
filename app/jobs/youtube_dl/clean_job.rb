module YoutubeDl
  class CleanJob < ApplicationJob
    queue_as :default

    def perform
      p "Deleting mp3 files"
      Dir.glob(File.join(Rails.root, "?.mp3")).each { |file| File.delete(file) }
      p "mp3 files deleted"
    end
  end
end
