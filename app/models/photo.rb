class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event, presence: true
  validates :user, presence: true
  validates :photo, presence: true

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
    attachable.variant :middle, resize_to_limit: [500, 500]
  end
  #добавить варианты расширения картинок
  scope :persisted, -> { where "id IS NOT NULL" }
end
