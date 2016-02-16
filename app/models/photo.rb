class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :answers
  mount_uploader :photo, PhotoUploader
end
