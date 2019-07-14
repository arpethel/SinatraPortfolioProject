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
    if logged_in?
      if params[:title] !=""
        @image = Image.new(title: params[:title][:file][:filename])
        @image.user = current_user
        @image.save

        file = params[:file][:tempfile]

        File.open("./public/#{@image}", 'wb') do |i|
        i.write(file.read)
        end

        redirect "/images/#{@image.id}"
      else
        redirect '/images/upload_image'
      end
    else
      redirect '/login'
    end
  end

    get '/images/:id' do
        if logged_in?
            @image = Image.find_by_id(params[:id])
            erb :"images/show_image"
        else
            redirect to '/login'
        end
    end

end
