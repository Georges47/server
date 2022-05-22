module YoutubeDl
  class DownloadJob < ApplicationJob
    queue_as :default

    def perform(filename, url)
      Rails.logger "Starting download job"

      command = "youtube-dl --newline --no-warnings --extract-audio --audio-format mp3 --output '#{filename}.mp3' #{url}" #| grep -e ETA -e \"Downloading video #\""

      Open3.popen3(command) do |stdin, stdout, stderr|
        while (line = stdout.gets)
          message = line.strip.split
          if message.include? "[download]"
            Rails.logger message
            ActionCable.server.broadcast "youtube_dl_channel", message[1]
          end
        end
      end

      ActionCable.server.broadcast "youtube_dl_channel", "[link] #{File.join(Rails.root, "#{filename}.mp3")}"

      Rails.logger "Download job finished"
    end
  end
end
