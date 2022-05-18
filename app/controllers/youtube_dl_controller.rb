class YoutubeDlController < ApplicationController

  def form
    render 'form'
  end

  def download_link
    url = params[:url]
    if url.present?
      @title = `youtube-dl --skip-download --get-title --no-warnings #{url} | sed 2d`.strip
      formatted_title = format_title(@title)
      system("youtube-dl --extract-audio --audio-format mp3 --output '#{formatted_title}.mp3' #{url}")
    end
    render 'download_link'
  end

  def send_song
    formatted_title = format_title(params[:title])
    send_file File.join(Rails.root, "#{formatted_title}.mp3"), type: "audio/mp3", filename: "#{formatted_title}.mp3"
  end

  private

  def format_title(title)
    title.gsub(' ', '_').downcase
  end
end
