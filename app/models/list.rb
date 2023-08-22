class List < ApplicationRecord
  has_many :event_lists, dependent: :destroy
  belongs_to :user
  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :user, presence: true
end
