helpers do

  def photo_score(id)
    photo_score = PhotoVote.where(photo_id: id)
    score = 0
    if photo_score.empty?
      score
    else
      photo_score.each do |pv|
        score += pv.vote
      end
    end
    score
  end

  def answer_score(id)
    answer_score = AnswerVote.where(answer_id: id)
    score = 0
    if answer_score.empty?
      score
    else
      answer_score.each do |pv|
        score += pv.vote
      end
    end
    score
  end

  def reorder_index(array)
    counter = 1
    array.each do |a|
      Photo.update(a.id, photo_index: counter)
      counter += 1
    end 
  end

end