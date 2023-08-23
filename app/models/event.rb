class Event < ApplicationRecord
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :event_lists, dependent: :destroy

  validates :name, :location, :description, :latitude, :longitude, :category, presence: true
  # validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  # validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  # validates :url, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :validate_url
  # validate :end_date_after_start_date


  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :description, :location ],
    using: {
      tsearch: { prefix: true }
    }

    scope :starts_within_range, ->(start_date, end_date) {
      where('start_date >= ? AND start_date <= ?', start_date, end_date)
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
end
