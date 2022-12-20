class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  has_many :giveaways
end
