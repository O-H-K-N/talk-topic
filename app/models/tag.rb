class Tag < ApplicationRecord
  has_many :topic_tags, dependent: :destroy
  has_many :topics, through: :topic_tags
  validates :name, presence: true
  validates :name, length: { in: 2..20 }, uniqueness: true, allow_blank: true
end
