class Topic < ApplicationRecord
  validates :user_name, presence: true
  validates :user_name, length: { in: 2..20 }, allow_blank: true
  validates :title, presence: true, length: { maximum: 255}
end
