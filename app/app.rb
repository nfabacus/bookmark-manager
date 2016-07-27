ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative 'models/data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/temporaryLink' do
      link = Link.create(url: params[:url], title: params[:title])
      # string "search-engine, bubbles"
      # into array seperated by comma and space
      tagsstring = params[:tag].split(", ")
      tagsstring.each do |word|
        tag = Tag.first_or_create(name: word)
        link.tags << tag
        link.save
      end

      redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/user/sign-up' do
    erb(:'/users/sign_up')
  end

  post '/user/new' do
    user = User.create(e_mail: params[:e_mail], password: params[:password])
    session[:user_id] = user.id
    redirect '/links'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end 


  # start the server if ruby file executed directly
  run! if app_file == $0
end
