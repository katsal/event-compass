class User < ApplicationRecord
  has_many :user_chats
  has_many :lists
  has_many :comments
  has_many :messages
  has_many :user_categories
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
