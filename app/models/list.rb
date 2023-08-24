class List < ApplicationRecord
  has_many :event_lists, dependent: :destroy
  has_many :events, through: :event_lists
  belongs_to :user
  validates :name, presence: true#, uniqueness: { scope: :user_id }
  validates :user, presence: true
end
