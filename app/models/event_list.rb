class EventList < ApplicationRecord
  belongs_to :event
  belongs_to :list

  after_create :create_feed_post_for_favorited_users

  private

  def create_feed_post_for_favorited_users
    favorited_users = list.user.favoritors
    event = self.event
    favorited_users.each do |favorited_user|
      Comment.create(user: favorited_user, event: event)
    end
  end
end
