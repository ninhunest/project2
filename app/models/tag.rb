class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, presence: true,
    length: {maximum: Settings.max_length_name_tag}

  def self.counts
    self.select("name, count(post_tags.tag_id) as count").joins(:post_tags).group(
      "post_tags.tag_id")
  end
end
