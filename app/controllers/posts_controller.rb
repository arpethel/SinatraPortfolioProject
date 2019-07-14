class PostsController < ApplicationController

  get '/posts' do
    if logged_in?
      @posts = Post.all
      erb :'posts/all_posts'
    else
      redirect '/login'
    end
  end

  get '/posts/new' do
    if logged_in?
      erb :"posts/new"
    else
      redirect '/login'
    end
  end

  post '/posts' do
    if logged_in?
      if params[:caption] !=""
        @post = Post.new(caption: params[:caption])
        @post.user = current_user
        @post.save

        redirect "/posts/#{@post.id}"
      else
        redirect '/posts/new'
      end
    else
      redirect '/login'
    end
  end

  get '/posts/:id' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      erb :"posts/show_post"
    else
      redirect to '/login'
    end
  end

  get '/posts/:id/edit' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      if @post && @post.user == current_user
        erb :"/posts/edit_post"
      else
        redirect '/posts'
      end
    else
      redirect '/login'
    end
  end

  patch '/posts/:id' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      if params[:caption] != ""
        @post.update(caption: params[:caption])
        erb :"posts/show_post"
      else
        redirect "/posts/#{@post.id}/edit"
      end
    else
      redirect '/login'
    end
  end

  delete '/posts/:id/delete' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      if @post.user == current_user
        @post.destroy
        redirect '/posts'
      else
        redirect '/posts'
      end
    else
      redirect '/login'
    end
  end

end
