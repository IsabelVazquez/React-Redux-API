class User < ApplicationRecord
  has_secure_password
  validates :email, :name, :password, presence: true
  validates :email, uniqueness: true
  has_many :images
end
