class Topic < ApplicationRecord
  has_many :topic_tags, dependent: :destroy
  has_many :tags, through: :topic_tags
  validates :user_name, presence: true
  validates :user_name, length: { in: 2..20 }, allow_blank: true
  validates :title, presence: true, length: { maximum: 255}
  validates :tag_ids, presence: true
end
