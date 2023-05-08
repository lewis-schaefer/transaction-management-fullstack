class Transaction < ApplicationRecord
  belongs_to :account

  validates :transaction_id, presence: true
  validates :transaction_account_id, presence: true
  validates :amount, presence: true
  validates :account_id, presence: true
  validates :amount, numericality: true
end
