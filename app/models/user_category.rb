class UserCategory < ApplicationRecord
  belongs_to :user
  belongs_to :category
  acts_as_favoritor favoritable_class_name: 'User'
  acts_as_favoritable favoritor_class_name: 'User'
end
