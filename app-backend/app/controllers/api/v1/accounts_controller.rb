class Api::V1::AccountsController < ApplicationController
  before_action :set_account, only: [:show]

  def show
    render json: {
      account_id: @account.account_id,
      balance: @account.balance,
      transactions: @account.transactions.map { |transaction|
        {
          transaction_id: transaction.transaction_id,
          amount: transaction.amount
        }
      }
    }, status: :ok
  end

  private

  def set_account
    @account = Account.find_by(account_id: params[:id])
  end

  def account_params
    @account = Account.find_by(account_id: params[:id])
  end
end
