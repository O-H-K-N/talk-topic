class Tag < ApplicationRecord
  has_many :topics, through: :topic_tags
  has_many :topic_tags, dependent: :destroy, foreign_key: 'topic_id'
  validates :name, uniqueness: true, presence: true
end
