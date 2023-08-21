class EventList < ApplicationRecord
  belongs_to :event
  belongs_to :list

  include PgSearch::Model
  pg_search_scope :search_by_title_and_synopsis,
    against: [ :name, :description, :location ],
    using: {
      tsearch: { prefix: true }
    }
end
