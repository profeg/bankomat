require 'sinatra'
require 'json'
require 'byebug'
require './lib/bankomat'

class SinatraApp < Sinatra::Base

  @@bankomat = Bankomat.new
  
  get '/' do
    @cash_box = @@bankomat.get_cash_box
    erb :bankomat, :layout => :home
  end

  post '/get_coins' do
  	sum = request.body.gets.split('=').last.to_i
  	coins_set = @@bankomat.get_coins_set( sum )
  	cash_box = @@bankomat.get_cash_box
  	{ coins_set: coins_set, cash_box: cash_box }.to_json
  end

  post '/add_one_coin' do
  	nominal = request.body.gets.split('=').last.to_i
  	@@bankomat.add_one_coin( nominal )
  	cash_box = @@bankomat.get_cash_box
  	{ cash_box: cash_box }.to_json
  end

  post '/add_ten_coins' do
  	nominal = request.body.gets.split('=').last.to_i
  	@@bankomat.add_ten_coins( nominal )
  	cash_box = @@bankomat.get_cash_box
  	{ cash_box: cash_box }.to_json
  end


end
