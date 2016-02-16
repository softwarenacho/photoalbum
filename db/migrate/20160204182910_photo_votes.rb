class PhotoVotes < ActiveRecord::Migration
  def change
    create_table :photo_votes do |pv|
      pv.integer :photo_id
      pv.integer :user_id
      pv.integer :vote
    end
  end
end
