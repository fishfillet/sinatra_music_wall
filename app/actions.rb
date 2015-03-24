# Homepage (Root path)
get '/' do
  # erb :index
  redirect '/login'
end

get '/login' do
  erb :'/login'
end

post '/login' do
  params[:username]
  params[:password]

  users = User.where(username: params[:username]).where(password: params[:password])
  if users.count > 0
    user = users[0]
    response.set_cookie("username", :value => params[:username], :path => "/", :expires => Time.now + 60*60*24*365*3)
    redirect '/songs'
  else
    # login failed
    redirect '/?message=Failed'
  end
end

post '/signup' do
  User.create(username: params[:username], password: params[:password])
  redirect '/songs'
end

get '/logout' do
  response.set_cookie("username", :value => '', :path => "/", :expires => Time.now - 60*60*24*365*3)
  redirect '/login'
end


#################################################################################

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @songs = Song.new
  erb :'songs/new'
end

post '/songs/new' do
  @current_user = User.where(username: request.cookies["username"])[0] 
  @songs = Song.new(
    song_title: params[:song_title],
    url: params[:url],
    author: params[:author],
    user_id: @current_user.id
  )
  if @songs.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end 
