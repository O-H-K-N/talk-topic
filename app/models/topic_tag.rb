class TopicTag < ApplicationRecord
  belongs_to :topic
  belongs_to :tag
  validates :post_id, presence: true
  validates :tag_id, presence: true
  validates :topic_id, uniqueness: { scope: :tag_id }
end
