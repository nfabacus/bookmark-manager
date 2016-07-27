ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require_relative 'models/data_mapper_setup'

class BookmarkManager < Sinatra::Base
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

  # start the server if ruby file executed directly
  run! if app_file == $0
end
