class User < ApplicationRecord
  has_many :user_chats
  has_many :lists
  has_many :comments
  has_many :messages
  has_many :user_categories
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
