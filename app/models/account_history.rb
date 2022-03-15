class AccountHistory < ApplicationRecord
  belongs_to :loggable, polymorphic: true

  validates :balance, :locked, :event, :change_amount, presence: true
  
  enum event: { withdrawal: 0, deposit: 1 }
end
