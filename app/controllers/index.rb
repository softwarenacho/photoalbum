get '/' do
  if session[:id]
    redirect to('/feed')
  else
    erb :index
  end
end

get '/feed' do
  if session[:id]
    @user = User.find(session[:id])
    @photos_array = Photo.all
    erb :feed
  else
    erb :index
  end
end