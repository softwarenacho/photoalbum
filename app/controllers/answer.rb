get '/answer_new/:id&:photo_id&:answer' do
  @user = User.find(session[:id])
  @photo = Photo.find(params[:photo_id])
  answer = params[:answer]
  Answer.create(user_id: @user.id, photo_id: @photo.id, answer: answer)
end

get '/delete/:id' do
  answer = Answer.find(params[:id])
  photo_id = answer.photo_id
  answer.destroy
  @user = User.find(session[:id])
  redirect to ("/show/#{photo_id}")
end