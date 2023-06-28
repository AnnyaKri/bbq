class Subscription < ApplicationRecord
  EMAIL_FORMAT = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/.freeze
  belongs_to :event
  belongs_to :user, optional: true

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email, presence: true,
              format: { with: EMAIL_FORMAT }
    validates :user_email, uniqueness: { scope: :event_id }
    validate :email_in_use
  end

  with_options if: -> { user.present? } do
    validates :user, uniqueness: { scope: :event_id }
    validate :canceling_self_subscription
  end

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user&.email || super
    end
  end

  private

  def email_in_use
    errors.add(:user_email, :email_in_use) if User.exists?(email: user_email)
  end

  def canceling_self_subscription
    errors.add(:base, :canceling_self_subscription) if user_email == event.user.email
  end
end
