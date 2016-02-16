get '/create_photo' do
  erb :new_photo
end

post '/save_photo' do
  title = params[:title]
  photo = params[:photo]
  @user = User.find(session[:id])
  @photo = Photo.new(title: title, photo: photo, user_id: @user.id)
  @photo.save!
  photos_total = @user.photos.length
  Photo.update(@photo.id, photo_index: photos_total)
  redirect to ("/feed")
end

get '/show/:id' do
  @user = User.find(session[:id])
  @photo = Photo.find(params[:id])
  @answers_array = Answer.where(photo_id: @photo.id)
  erb :photo
end

get '/delete_photo/:id' do
  photo = Photo.find(params[:id])
  photo.destroy
  @user = User.find(session[:id])
  photo_array = Photo.where(user_id: @user.id).order(:photo_index)
  reorder_index(photo_array)
  redirect to ("/profile/#{@user.id}")
end

get '/gallery/:id' do
  @user = User.find(params[:id])
  @photos_array = Photo.where(user_id: @user.id).order(:photo_index)
  erb :gallery
end

get '/sort/:id' do
  @user = User.find(params[:id])
  @photos_array = Photo.where(user_id: @user.id).order(:photo_index)
  erb :sort
end

post '/save_sort' do
  order = params[:order]
  @user = User.find(session[:id])
  ordered = order.split(",")
  ordered_array = []
  photos_array = Photo.where(user_id: @user.id).order(:photo_index)
  ordered.each do |o|
    ordered_array << photos_array[o.to_i-1]
  end
  reorder_index(ordered_array)
  redirect to("/profile/#{session[:id]}")
end