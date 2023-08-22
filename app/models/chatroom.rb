class Chatroom < ApplicationRecord
  has_many :user_chats, dependent: :destroy
  has_many :messages
  validates :name, presence: true, uniqueness: true
end
