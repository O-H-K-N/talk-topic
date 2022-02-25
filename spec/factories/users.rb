FactoryBot.define do
  factory :user do
    email { 'hoge@hege.com' }
    account_name { 'hoge' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
