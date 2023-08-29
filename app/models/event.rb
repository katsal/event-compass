class Event < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :event_lists, dependent: :destroy
  has_many :lists, through: :event_lists

  validates :name, :location, :description, :latitude, :longitude, :category, presence: true
  # validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  # validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  # validates :url, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :validate_url
  # validate :end_date_after_start_date

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :description, :location ],
    using: {
      tsearch: { prefix: true }
    }

    scope :starts_within_range, ->(start_date, end_date) {
      if start_date > Event.date_today
        where('to_char(start_date,\'YYYY-MM-DD\') >= ? AND to_char(end_date,\'YYYY-MM-DD\') <= ?', start_date.strftime("%Y-%m-%d"), end_date.strftime("%Y-%m-%d"))
      else
        where('to_char(end_date,\'YYYY-MM-DD\') <= ?', end_date.strftime("%Y-%m-%d"))
      end
    }

    scope :for_a_day, ->(event_date) {
      where('? BETWEEN to_char(start_date,\'YYYY-MM-DD\') AND to_char(end_date,\'YYYY-MM-DD\')', event_date.strftime("%Y-%m-%d"))
    }

    scope :search_and_date_range, ->(query, start_date, end_date) {
      global_search(query).starts_within_range(start_date, end_date)
    }
  private

  def validate_url
    return if url.blank?

    uri = URI.parse(url)
    unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      errors.add(:url, "must be a valid website address")
    end
  rescue URI::InvalidURIError
    errors.add(:url, "is not a valid website address")
  end

  def end_date_after_start_date
    return unless start_date.present? && end_date.present?

    if end_date < start_date
      errors.add(:end_date, "can not be before the start date")
    end
  end

  def self.date_today
    Date.today.to_datetime
  end
end
