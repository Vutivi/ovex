class Currency < ApplicationRecord
  has_many :accounts

  validates :name, :code, presence: true
  validates :name, :code, uniqueness: true
end
