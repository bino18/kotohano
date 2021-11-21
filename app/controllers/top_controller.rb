class TopController < ApplicationController
  skip_before_action :login_required, only: [:top]

  def top
    @posts = Post.includes(:user).order(id: "DESC").limit(10)
  end

  #コントローラーを作る
  def sunset
    def search
      if sunset = params[:year, :month, day, lat, :lng]
        uri = URI.parse("https://labs.bitmeister.jp/ohakon/json/?year=#{sunset.year}&month=#{sunset.month}&day=#{sunset.day}&lat=#{sunset.lat}&lng=#{sunset.lng}")
        response = Net::HTTP.get_response(uri)
        result = JSON.parse(response.body)
        if result["rise_and_set"]
          @sunset_time = result["rise_and_set"][3]["sunset_hm"]
        end
      end
    end
  
  end
end