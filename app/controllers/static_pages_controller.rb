class StaticPagesController < ApplicationController
  def index 
    FlickRaw.api_key = ENV["FLICKR_KEY"]
    FlickRaw.shared_secret = ENV["FLICKR_SECRET"]

    @user_id = params[:user_id]
    if @user_id
      @user = flickr.people.getInfo(:user_id => @user_id)
      photos = flickr.people.getPublicPhotos(:user_id => @user_id)
      @urls = []
      photos.each do |photo|
        info = flickr.photos.getInfo(:photo_id => photo.id)
        url = FlickRaw.url_b(info)
        @urls << url
      end
    end
  end
end
