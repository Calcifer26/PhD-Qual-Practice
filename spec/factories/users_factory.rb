FactoryBot.define do
  factory :user do
    name { 'test' }
    email { 'test@testing.com' }
    password {"pass1121212"}
    reviewStatus {"Approved"}
    confirmed_at{"2020-04-20 06:20:34.974867"}
 
  end
end
