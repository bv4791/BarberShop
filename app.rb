require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
  return SQLite3::Database.new 'base.db'
end

configure do
  db = get_db
  db.execute ' CREATE TABLE IF NOT EXISTS 
  "Users"
   ( 
   		"Id" INTEGER,
   		 "Username" TEXT, 
   		 "Phone" TEXT, 
   		 "DateStamp" TEXT,
   		 "barber" TEXT, 
   		 "color" TEXT, 
   		 PRIMARY KEY("Id" AUTOINCREMENT) )'
  db.close
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	# хеш
	hh = { 	:username => 'Введите имя',
			:phone => 'Введите телефон',
			:datetime => 'Введите дату и время' }

	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != ''
		return erb :visit
	end

  db = get_db
  db.execute 'INSERT INTO Users (Username, Phone, DateStamp, barber, color)
  VALUES (?, ?, ?, ?, ?)', [@username, @phone, @email, @option, @comment]
  db.close

	erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}"

end
