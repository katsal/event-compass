class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :comment, length: { minimum: 1 }
end
