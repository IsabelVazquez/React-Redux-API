class Image < ApplicationRecord
  validates :imgur_id, :user_id, presence: true
  belongs_to :user
end
