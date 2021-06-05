class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar

  validates :name, presence: true
  validates :email, presence:true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
