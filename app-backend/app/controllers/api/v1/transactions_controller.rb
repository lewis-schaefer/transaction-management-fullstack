class Api::V1::TransactionsController < ApplicationController
  before_action :set_transactions, only: [:index]

  def index
    render json: {
      data: {
        transactions: @transactions.map { |transaction| {
          transaction_id: transaction.transaction_id,
          transaction_amount: transaction.amount,
          account_id: transaction.account_id,
          account_balance: transaction.account.balance,
          created_at: transaction.created_at
        }}
      }, status: :ok
    }
  end

  private

  def set_transactions
    @transactions = Transaction.all.includes(:account)
  end
end
