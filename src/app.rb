require 'sinatra'
require 'sinatra/reloader'

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
    # :name で与えられたファイルを開き、中の内容を返すようなコード
    # ファイルが存在しない場合は、ステータスコードを変えてエラーを返す。
  end

  post '/post', provides: :json do
  params = JSON.parse(request.body.read, {:symbolize_names => true})
    "#{params[:first].chars.first}.#{params[:last].chars.first}.\n"
  end


  put '/put' do
    # 何らかの作成/更新処理
    "#{request.body.read}"
  end

  put '/put_del' do
    settings.stat = JSON.parse(request.body.read, {:symbolize_names => true})
    status 204
  end

  delete '/put_del/:num' do
    sym = params[:num].to_sym
    if settings.stat[sym] != nil then
      settings.stat[sym] = false
      status 204
    else
      status 501
    end
  end

  get '/put_del/:num' do
    sym = params[:num].to_sym
    if settings.stat[sym] == true then
      "#{params[:num]}"
    else
      status 404
    end
  end

  delete '/delete' do
    # 何らかの削除処理
    status 204
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
