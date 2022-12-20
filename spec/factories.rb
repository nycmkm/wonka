FactoryBot.define do
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
