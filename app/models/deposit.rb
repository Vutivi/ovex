class Deposit < ApplicationRecord
  belongs_to :member
  belongs_to :currency

  validates :amount, :fee, :aasm_state, presence: true
end
