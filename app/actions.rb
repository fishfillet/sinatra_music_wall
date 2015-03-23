# Homepage (Root path)
get '/' do
  # erb :index
  redirect '/songs'
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @songs = Song.new
  erb :'songs/new'
end

# get '/songs/:id' do
#   @songs = Song.find params[:id]
#   erb :'songs/show'
# end

post '/songs' do
  @songs = Song.new(
    song_title:   params[:song_title],
    url: params[:url],
    author:  params[:author]
  )
  if @songs.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end 
