class ImagesController < ApplicationController

  get '/images' do
    if logged_in?
      @images = Image.all
      erb :'images/images'
    else
      redirect '/login'
    end
  end

  get '/images/new' do
    if logged_in?
      erb :"images/new"
    else
      redirect '/login'
    end
  end

  post '/images' do
    if logged_in?
      if params[:content] !=""
        @image = Image.new(content: params[:content])
        @image.user = current_user
        @image.save

        redirect "/images/#{@image.id}"
      else
        redirect '/images/new'
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

  get '/images/:id/edit' do
    if logged_in?
      @image = Image.find_by_id(params[:id])
      if @image && @image.user == current_user
        erb :"/images/edit_image"
      else
        redirect '/images'
      end
    else
      redirect '/login'
    end
  end

  patch '/images/:id' do
    if logged_in?
      @image = Image.find_by_id(params[:id])
      if params[:content] != ""
        @image.update(content: params[:content])
        erb :"images/show_image"
      else
        redirect "/images/#{@image.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  delete '/images/:id/delete' do
    if logged_in?
      @image = Image.find_by_id(params[:id])
      if @image.user == current_user
        @image.destroy
        redirect '/images'
      else
        redirect '/images'
      end
    else
      redirect '/login'
    end
  end

end
