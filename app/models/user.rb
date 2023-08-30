class User < ApplicationRecord
  has_many :user_chats, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :messages_as_sender, class_name: "Message", foreign_key: :sender_id
  has_many :messages_as_recipient, class_name: "Message", foreign_key: :recipient_id
  has_many :user_categories, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_one_attached :my_photo
  acts_as_favoritor
  acts_as_favoritable

  STATUS = ["solo adventurer", "social butterfly"]

  def admin
    @admin
  end

  def messages(recipient)
    Message.where(sender: self, recipient: recipient).or(Message.where(sender: recipient, recipient: self))
  end
end
