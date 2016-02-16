class AnswerVotes < ActiveRecord::Migration
  def change
    create_table :answer_votes do |av|
      av.integer :answer_id
      av.integer :user_id
      av.integer :vote
    end
  end
end
