class Post < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  mount_uploader :picture, PictureUploader
  validates :title, presence: true,
    length: {maximum: Settings.max_length_title_post}
  validates :content, presence: true
  scope :sort_by_updated, ->{order updated_at: :desc}

  def list_tags= names
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def list_tags
    self.tags.map(&:name).join(", ")
  end
end
