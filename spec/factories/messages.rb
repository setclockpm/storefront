FactoryGirl.define do
  factory :message do
    content "Hello World"
    email   "test@poorboyalexander.com"
    name    "Holbert Ohtis"
    phone   "980-555-1234"
    
    trait :extended do
      subject "Wholesale"
    end
    
  end
end
