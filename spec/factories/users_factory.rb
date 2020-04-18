FactoryBot.define do
  factory :user do
    name { 'test' }
    email { 'test@testing.com' }
    password {"pass1121212"}
    reviewStatus {"Approved"}
 
  end
end
