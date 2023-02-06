FactoryBot.define do
  factory :event do
    eventbrite_id { rand(100_000) }
    name { "Mars Mechanical Keyboard Meetup v.001" }
    date { "2023-02-05 22:02:18" }
  end

  factory :attendee do
    event { nil }
    eventbrite_id { "" }
    name { "MyString" }
    email { "MyString" }
  end

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
    prize { "Spaceship" }
    event { create(:event) }
    num_winners { 3 }
    user { create(:user) }
  end
end
