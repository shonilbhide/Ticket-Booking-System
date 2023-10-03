FactoryBot.define do
    factory :passenger do
      name { "user name" }
      email { "user1@example.com" }
      phone_number { "999-999-9999" }
      address { "Crest road" }
      credit_number { "1234-1234-1234-1234" }
      password_digest { "Userpassword" }
    end
  end
