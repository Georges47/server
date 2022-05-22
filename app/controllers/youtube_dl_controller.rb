class YoutubeDlController < ApplicationController
  def download
    url = params[:url]
    if url.present?
      title = `youtube-dl --skip-download --get-title --no-warnings #{url} | sed 2d`.strip
      filename = title.gsub(' ', '_').downcase
      YoutubeDl::DownloadJob.perform_later(filename, url)
      render json: { title: title, filename: filename }, status: :ok
    else
      render json: { message: 'No URL' }, status: :unprocessable_entity
    end
    # render 'download_link'
  end

  def send_song
    filename = params[:filename]
    send_file File.join(Rails.root, "#{filename}.mp3"), type: "audio/mp3", filename: "#{filename}.mp3" #disposition: attachment
  end

end
