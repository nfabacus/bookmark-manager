ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'


class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    'Hello BookmarkManager!'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end


  post '/links' do
    link = Link.new(title: params[:title], url: params[:url])
    tags = params[:tag].split(", ")
    tag = tags.each do |tag|
      tag = Tag.first_or_create(name: tag)
      link.tags << tag
    end
    link.save
    redirect '/links'
  end

  get '/sign-up' do
    erb :'links/userform'
  end

  post '/newuser' do
    user = User.new(username: params[:username],
                    email: params[:email],
                    password: params[:password],
                    password_confirmation: params[:password_confirmation])

    if user.save
      session[:user_id] = user.id
      redirect '/links'
    else
      flash.now[:errors] = user.errors.full_messages
      erb :'links/userform'
    # elsif user.password != user.password_confirmation
    #   flash.now[:notice] = "Password and confirmation password do not match."
    #   erb :'links/userform'
    # elsif user.email.empty?
    #   flash.now[:notice] = "Please enter your email address."
    #   erb :'links/userform'
    # elsif !User.all(email: user.email).empty?
    #   flash.now[:notice] = "Email address already exists - please use unique email address"
    #   erb :'links/userform'
    # end
    end
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
