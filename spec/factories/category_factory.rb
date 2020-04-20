FactoryBot.define do 
    factory :category_bank do
        category {"Cat1"}
        reviewStatus {"Approved"}
        created_at {Time.new}
        updated_at {Time.new}
        creator    {"test@testing.com"}
    end
end
