class List < ApplicationRecord
  has_many :event_lists, dependent: :destroy
  belongs_to :user
  validates :name, presence: true, uniqueness :true { scope: :user:id }
  validates :user, presence: true
end
