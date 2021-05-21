class Article < ApplicationRecord
  include Visible
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
  VALID_STATUSES = ['Sport', 'Art', 'Science']
  validates :category, inclusion: { in: VALID_STATUSES }


  has_one_attached :image
end
