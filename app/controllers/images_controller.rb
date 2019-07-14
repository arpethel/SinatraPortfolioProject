class ImagesController < ApplicationController

    get '/images' do
    if logged_in?
      @images = Image.all
      erb :'images/images'
    else
      redirect '/login'
    end
  end

end
