class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :photos, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [200, 200]
    attachable.variant :middle, resize_to_fill: [400, 400]
  end

  before_validation :set_name, on: :create

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :avatar, content_type: %w[image/png image/jpeg image/jpg image/gif]
  after_commit :link_subscriptions, on: :create

  private

  def set_name
    self.name = "#{I18n.t('model.set_name')}№#{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email)
                .update_all(user_id: self.id)
  end
end
