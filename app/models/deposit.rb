class Deposit < ApplicationRecord
  after_create :update_member_account_balance

  belongs_to :member
  belongs_to :currency

  validates :amount, :fee, :aasm_state, presence: true

  def amount_to_credit
    amount - fee
  end

  def member_account
    member.accounts&.first
  end

  def update_member_account_balance
    member_account.update!(balance: member_account.balance + amount_to_credit)
    AccountHistory.create!(balance: member_account.balance,
                           locked: member_account.locked,
                           event: 1,
                           change_amount: amount_to_credit,
                           loggable: member_account)
  end
end
