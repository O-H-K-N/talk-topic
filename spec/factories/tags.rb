FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "Rspec用タグ_#{n}" }
  end
end
