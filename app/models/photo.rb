class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event, presence: true
  validates :user, presence: true
  validates :photo, presence: true, content_type: %w[image/png image/jpeg image/jpg image/gif]

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
    attachable.variant :middle, resize_to_limit: [500, 500]
  end

  scope :persisted, -> { where "id IS NOT NULL" }
end
