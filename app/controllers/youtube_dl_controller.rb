class YoutubeDlController < ApplicationController

  def form
    render 'form'
  end

  def download
    url = params[:url]
    if url.present?
      title = `youtube-dl --skip-download --get-title --no-warnings #{url} | sed 2d`.strip
      filename = get_filename(title)
      # link = "#{filename}.mp3"
      # link = `youtube-dl --extract-audio --audio-format mp3 --output '#{filename}.mp3' --get-url #{url}` #--skip-download
      # system("youtube-dl --extract-audio --audio-format mp3 --output '#{formatted_title}.mp3' #{url}")
      DownloadJob.perform_later(filename, url)
      # render json: { title: title, link: link }, status: :ok
      p "RESPONSE---"
      p "#{{ title: title, filename: filename }}"
      p filename
      p "RESPONSE---"
      render json: {title: title, filename: filename}, status: :ok
      # send_file File.join(Rails.root, "#{filename}.mp3"), type: "audio/mp3", filename: "#{filename}.mp3"
    else
      render json: { message: 'No URL' }, status: :unprocessable_entity
    end
    # render 'download_link'
  end

  def send_song
    # title = `youtube-dl --skip-download --get-title --no-warnings #{url} | sed 2d`.strip
    filename = params[:filename] #get_filename(title)
    send_file File.join(Rails.root, "#{filename}.mp3"), type: "audio/mp3", filename: "#{filename}.mp3" #disposition: attachment
  end

  private

  def get_filename(title)
    title.gsub(' ', '_').downcase
  end
end
