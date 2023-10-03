FactoryBot.define do
    factory :admin do
      username { "admin" }
      name { "admin" }
      email { "admin@example.com" }
      phone_number { "999-999-9999" }
      address { "Crest road" }
      credit_number { "1234-1234-1234-1234" }
      password_digest { "Admin@pass123" }
    end
    
  end