class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :comment, length: { minimum: 1 }
  has_many_attached :photos
  acts_as_votable
end
