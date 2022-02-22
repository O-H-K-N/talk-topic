class TopicTag < ApplicationRecord
  belongs_to :topic
  belongs_to :tag
  validates :topic_id, uniqueness: { scope: :tag_id }
end
