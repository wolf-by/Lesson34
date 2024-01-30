#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "pizzashop.db"}

class Product < ActiveRecord::Base 

end

class Order < ActiveRecord::Base

	validates :name_client, presence: true, length: {minimum: 3}
	validates :phone_client, presence: true
	validates :address_client, presence: true

end	

before do
	@products = Product.all
	@orders = Order.all
end


get '/' do
	erb :index
end

get '/catalog' do
	erb :catalog
end

post '/cart' do
	@orders_input = params[:orders]
	@items = parse_orders_input @orders_input

	@items.each do |item|
		# id, cnt
		item[0] = Product.find(item[0])

	end

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

post '/place_order' do
	@name_client = params[:name_client]
	@phone_client = params[:phone_client]
	@address_client = params[:address_client]

	@total_item = params[:title]
	@total_price = params[:total_price]
	@total_quantity = params[:total_quantity]


	hh2 = { :name_client => 'Введите Имя',
			:phone_client => 'Введите телефон',
			:address_client => 'Введите адрес'
	}

	hh2.each do |key, value|
		if params[key] == ''
			@error = hh2[key]
			return erb :contacts
		end	
	end	
	
	Order.create :name_client => @name_client, :phone_client => @phone_client, 
	:address_client => @address_client, :title => @total_item, :total_price => @total_price, 
	:total_quantity => @total_quantity

	f = File.open './public/contacts.txt', 'a'
	f.write "Имя клиента: #{@name_client}\n, Телефон: #{@phone_client}\n, Адрес: #{@address_client}\n "
	f.close



	erb "Ваш заказ принят! Спасибо!" 
end

get '/order' do

	@orders = Order.order(:id)
	erb :order
end