class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
end
