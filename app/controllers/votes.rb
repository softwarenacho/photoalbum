get '/answer_vote/:user_id&:answer_id&:vote' do
  vote = params[:vote]
  if AnswerVote.where(user_id: params[:user_id], answer_id: params[:answer_id]).length == 0
    AnswerVote.create(user_id: params[:user_id], answer_id: params[:answer_id], vote: vote)
  end
  redirect to("/show/#{Answer.find(params[:answer_id]).photo_id}")
end

get '/photo_vote/:user_id&:photo_id&:vote' do
  vote = params[:vote]
  if PhotoVote.where(user_id: params[:user_id], photo_id: params[:photo_id]).length == 0
    PhotoVote.create(user_id: params[:user_id], photo_id: params[:photo_id], vote: vote)
  end
  redirect to("/show/#{params[:photo_id]}")
end
