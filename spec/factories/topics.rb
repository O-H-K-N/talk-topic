FactoryBot.define do
  factory :topic do
    sequence(:user_name) { |n| "投稿者のお名前_#{n}" }
    sequence(:title) { |n| "会話のネタ_#{n}" }
  end
end
