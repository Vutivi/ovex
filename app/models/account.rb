class Account < ApplicationRecord
  belongs_to :member
  belongs_to :currency

  has_many :account_histories, as: :loggable, dependent: :destroy

  def withdraw(amount)
    raise "You have no funds in your account to withdraw" if balance <= 0
    raise "You cannot withdraw an amount higher than your balance" if amount > balance
    raise "Your withdrawal amount exceeds your withdrawable balance" if amount > (balance - locked)

    update!(locked: locked + amount)
    AccountHistory.create!(balance: reload.balance,
                           locked: reload.locked,
                           event: 0,
                           change_amount: amount,
                           loggable: self)
  end

  def clear_funds
    new_balance = balance - locked
    update!(balance: new_balance)
    update!(locked: 0.0)
  end
end
