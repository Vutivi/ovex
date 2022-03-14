FactoryBot.define do
  factory :deposit do
    member { association(:member) }
    currency { association(:currency) }
    amount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    fee { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    aasm_state { "MyString" }
  end
end
