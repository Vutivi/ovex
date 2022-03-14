FactoryBot.define do
  factory :account do
    member { association(:member) }
    currency { association(:currency) }
    balance { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    locked { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end
