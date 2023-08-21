class List < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness :true { scope: :user:id }
  validates :user, presence: true
end
