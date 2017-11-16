class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :title, presence: true,
    length: {maximum: Settings.max_length_title_post}
  validates :content, presence: true
  validates :user, presence: true
end
