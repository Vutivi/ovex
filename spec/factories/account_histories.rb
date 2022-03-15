FactoryBot.define do
  amount = Faker::Number.decimal(l_digits: 3, r_digits: 2)

  factory :account_history do
    # account { association(:account) }
    balance { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    locked { amount }
    event { 0 }
    change_amount { amount }
    loggable { association(:account) }
  end
end
