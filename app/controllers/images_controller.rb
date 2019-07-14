class ImagesController < ApplicationController

    get '/images' do
    if logged_in?
      @images = Image.all
      erb :'images/images'
    else
      redirect '/login'
    end
  end

  post '/save_image' do
    @filename = params[:file][:filename]
    file = params[:file][:tempfile]

    File.open("./public/#{@filename}", 'wb') do |f|
      f.write(file.read)
    end
    
    erb :"posts/show_image"
  end




  
end
