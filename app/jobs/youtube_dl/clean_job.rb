module YoutubeDl
  class CleanJob < ApplicationJob
    queue_as :default

    def perform
      deleted_filenames = []

      puts 'Deleting mp3 files'

      Dir.glob(File.join(Rails.root, "*.mp3")).each do |file|
        deleted_filenames << file.split('/')[-1].chomp('.mp3')
        File.delete(file)
      end

      puts "Deleted #{deleted_filenames.count} mp3 files: "
      deleted_filenames.each_with_index do |filename, index|
        puts "  #{index+1}.- #{filename}"
      end
    end
  end
end
