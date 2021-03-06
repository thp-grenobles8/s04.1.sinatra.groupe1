require 'gossip'
require 'comment'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/:id' do
    erb :show, locals: {
      id: params["id"],
      gossip: Gossip.find(params["id"]),
      comments: Comment.get(params["id"])
    }
  end

  get '/gossips/:id/edit' do
    erb :edit, locals: {
      id: params["id"],
      gossip: Gossip.find(params["id"].to_i)
    }
  end

  post '/gossips/com/:id' do #ajout d'un commentaire
    Comment.add(params["id"],params["com_text"])
    erb :show, locals: {
      id: params["id"],
      gossip: Gossip.find(params["id"]),
      comments: Comment.get(params["id"])
    }
  end

  post '/gossips/:id/edit/' do
    Gossip.update(params['id'],params["gossip_author"],params["gossip_content"])
    puts "gossip updaté"
    redirect '/'
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"],params["gossip_content"]).save
    puts "gossip enregistré"
    redirect '/'
  end

  # run! if app_file == $0
end
