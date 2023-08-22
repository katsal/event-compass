class Category < ApplicationRecord
  has_many :events
  has_many :user_categories
end
