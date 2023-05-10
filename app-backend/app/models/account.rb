class Account < ApplicationRecord
  validates :account_id, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: true

  has_many :transactions
end
