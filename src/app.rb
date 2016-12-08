require 'sinatra'
require 'sinatra/reloader'
require 'json'

# Sinatra Main controller
class MainApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  configure do
    set :stat, {}
  end

  get '/' do
    "hello, world"
  end

  get '/now' do
    Time.now.to_s
  end

  get '/echo/:str' do
    params[:str].to_s
  end

  get '/add/:x/:y' do
    (params[:x].to_i + params[:y].to_i).to_s
  end

  get '/file/:name' do
    # :name で与えられたpublic/フォルダ内のファイルを開き、中の内容を返すようなコード
    # ファイルが存在しない場合は、適切なステータスコードを与えてエラーを返す。
  end

  post '/', provides: :json do
  params = JSON.parse(request.body.read, {:symbolize_names => true})
    "#{params[:first].chars.first}.#{params[:last].chars.first}.\n"
  end

  put '/' do
    status 204
    # 何らかの作成/更新処理
    "#{request.body.read}"
  end

  delete '/' do
    status 204
    # 何らかの削除処理
  end

  post '/file/:name/:content' do
    # :name で与えられたファイルを開き、内容(:content)を追記するようなコード
  end

  put '/file/:name/:line/:content' do
    # :name で与えられたファイルを開き、line行目の内容を:contentで書き換えるようなコード
  end

  delete '/file/:name' do
    # :name で与えられたファイルを削除するようなコード
  end

  # JSONのやり取りをするコード ↓
  # get
  # post
  # put
  # delete
end
