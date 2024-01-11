#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "pizzashop.db"}

class Product < ActiveRecord::Base 

end

before do
	@products = Product.all

end


get '/' do
	erb :index
end

get '/catalog' do
	erb :catalog
end

post '/cart' do
	erb 'Hi'
end

get '/product/:id' do

	# получаем переменную url
	@id = params[:id]

	#@c = Comment.new 
	

	# получаем список постов 
	# у нас будет только один пост
	#results = @db.execute 'select * from Posts where id = ?', [post_id]
	@product = Product.find(params[:id])

	# выбираем этот один пост в переменную @row
	@row = @product[0]

	
	# выбираем комментарии для нашего поста
	#@comment = Comment.find_by(post_id: '1')
	
	#Comment.destroy_all
	# возвращаем представление details.erb
	erb :product
end

post '/product/:id' do

# получаем переменную url
	id = params[:id]

# получаем переменную из post-запроса	
  	product = params[:product] 

	@p = Product.new params[:product]
	@p.id = id
	@p.save
 	
 	
	redirect to ('/product/' + id)
 
end