require 'sinatra/base'
require_relative 'models/link'

class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links/new' do
    erb :'links/new'
    #Link.create(url: params['url'], title: params['title'])
    #erb :'links/index'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
