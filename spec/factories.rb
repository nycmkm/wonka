FactoryBot.define do
  factory :winner do
    name { "MyString" }
    attendee_id { "" }
    email { "MyString" }
    giveaway { nil }
  end

  factory :user do
    email { "zaphod@beeblebr.ox" }
    password { "hhgtg4242" }
  end

  factory :giveaway do
    name { "Spaceship" }
    event_id { 42 }
    user { create(:user) }
  end
end
