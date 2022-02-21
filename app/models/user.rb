class User < ApplicationRecord
  authenticates_with_sorcery!

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :account_name, presence: true, allow_blank: true
  validates :account_name, uniqueness: true, length: { in: 4..20 }
  validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :email, presence: true
  validates :password, length: { in: 8..20 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
end
