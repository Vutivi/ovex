class Member < ApplicationRecord
  has_many :accounts
  has_many :deposits
end
