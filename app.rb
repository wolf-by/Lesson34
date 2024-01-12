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
	orders_input = params[:orders]
	@orders = parse_orders_input orders_input
	erb :cart
end

def parse_orders_input orders_input

	s1 = orders_input.split(/,/)
	#puts s1.inspect

	arr = []

	s1.each do |x| 
		s2 = x.split(/=/)
		s3 = s2[0].split(/_/)
		#puts s3.inspect

		id = s3[1]
		cnt = s2[1]

		#puts "Product: #{key}, number of item: #{value}"
		arr2 = [id, cnt]
		arr.push arr2	

	end
	return arr
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