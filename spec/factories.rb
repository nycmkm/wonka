FactoryBot.define do
  factory :event do
    external_event_id { rand(100_000) }
    name { "Mars Mechanical Keyboard Meetup v.001" }
    date { "2023-02-05 22:02:18" }
  end

  factory :attendee do
    event
    external_id { rand(100_000) }
    name { "MyString" }
    email { "MyString" }
  end

  factory :user do
    email { "zaphod#{rand(1000)}@beeblebr.ox" }
    password { "hhgtg4242" }
  end

  factory :giveaway do
    prize { "Spaceship" }
    event
    num_winners { 3 }
    user
  end
end
