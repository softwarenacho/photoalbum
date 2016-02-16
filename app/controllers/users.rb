post '/login' do
  email = params[:user]
  pwd = params[:pwd]
  @user = User.authenticate(email, pwd)
  if @user == nil
    result = "User or password are incorrect"
  else
    session[:id] = @user.id
    erb :feed
  end
end

get '/register' do
  erb :register
end

post '/save_user' do
  name = params[:name]
  email = params[:email]
  pwd1 = params[:pwd1]
  pwd2 = params[:pwd2]
  email_exist = User.find_by(email: email)
  if (pwd1 != pwd2)
    result = "Your passwords do not match, please retype."
  elsif email_exist != nil
    result = "Your email is already registered."
  else
    @user = User.new(name: name, email: email)
    @user.password = pwd1
    if @user.save!
      session.clear
      session[:id] = @user.id
      redirect to('/feed')
    end
  end
end

get '/edit' do
  @user = User.find(session[:id])
  puts "ID del usuario #{@user.id}"
  erb :edit_user
end

post '/update_user' do
  @user = User.find(session[:id])
  name = params[:name]
  email = params[:email]
  pwd1 = params[:pwd1]
  pwd2 = params[:pwd2]
  email_check = User.find_by(email: email)

  if email_check == nil
    if pwd1 == "" || pwd2 == ""
      User.update(@user.id, :name => name, :email => email)
      redirect to('/profile/#{@user.id}')
    else
      if pwd1 == pwd2
        User.update(@user.id, :name => name, :email => email)
        @user.password = pwd1
        @user.save!
        result = "Data updated"
      else
        result = "Your passwords do not match, please retype."
      end
    end
  else
    if (email_check.email != @user.email)
      result = "This email is already registered."
    else
      if pwd1 == "" || pwd2 == ""
        User.update(@user.id, name: name, email: email)
        result = "Data updated"
      else
        if pwd1 == pwd2
          User.update(@user.id, name: name, email: email)
          @user.password = pwd1
          @user.save!
          result = "Data updated"
        else
          result = "Your passwords do not match, please retype."
        end
      end
    end
  end
end

get '/profile/:id' do
  @user = User.find(params[:id])
  @photos_array = Photo.where(user_id: @user.id).order(:photo_index)
  @answered_photo = @user.answers.map {|answer| answer.photo }
  @answered_photo.uniq!
  erb :profile
end

get '/users_list' do
  @users_list = User.all
  erb :users_list
end

get '/delete_user' do
  user = User.find(session[:id])
  user.destroy
  session.clear
  erb :index
end

get '/logout' do
  session.clear
  erb :index
end