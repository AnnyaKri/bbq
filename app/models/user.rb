class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events

  before_validation :set_name, on: :create

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }

  private
  def set_name
    self.name = "Товарисч №#{rand(777)}" if self.name.blank?
  end
end
