class Topic < ApplicationRecord
  validates :user_name, presence: true, allow_blank: true
  validates :user_name, length: { in: 2..20 }
  validates :title, presence: true, length: { maximum: 255}
end
