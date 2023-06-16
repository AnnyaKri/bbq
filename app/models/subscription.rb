class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  validates :user_name, presence: true,
            unless: -> { user.present? }
  validates :user_email, presence: true,
            format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/,
            unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id },
            if: -> { user.present? }
  validates :user_email, uniqueness: { scope: :event_id },
            unless: -> { user.present? }

  validate :free_email, unless: -> { user.present? }

  validate :unique_subscription, unless: -> { user.present? }
  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def user_present?
    user.present?
  end

  def free_email
    errors.add(:base, :free_email) if User.find_by(email: user_email).present?
  end

  def unique_subscription
    errors.add(:base, :unique_subscription) if User.find_by(email: user_email) == event.user
  end
end
