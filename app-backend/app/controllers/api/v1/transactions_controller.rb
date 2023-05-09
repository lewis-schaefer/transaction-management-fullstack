class Api::V1::TransactionsController < ApplicationController
  before_action :set_transactions, only: [:index]
  before_action :set_transaction, only: [:show]
  before_action :set_account, only: [:create]
  skip_before_action :verify_authenticity_token #solves the CSRF error

  def show
    render json: {
      data: {
        transaction_id: @transaction.transaction_id,
        transaction_amount: @transaction.amount,
        account_id: @transaction.account.account_id,
        account_balance: @transaction.account.balance,
        created_at: @transaction.created_at
      }
    }, status: :ok
  end

  def index
    render json: {
      data: {
        transactions: @transactions.map { |transaction| {
          transaction_id: transaction.transaction_id,
          transaction_amount: transaction.amount,
          account_id: transaction.account.account_id,
          account_balance: transaction.account.balance,
          created_at: transaction.created_at
        } }
      }, status: :ok
    }, status: :ok
  end

  def create
    # binding.pry
    if transaction_params[:amount].nil? # || transaction_params[:amount].empty?
      render json: { errors: "Transaction amount invalid" }, status: :bad_request, message: 'Mandatory body parameters missing or have incorrect type'
    elsif @account.present?
      transaction = Transaction.new(
        account: @account,
        transaction_id: SecureRandom.uuid,
        transaction_account_id: @account.account_id,
        amount: transaction_params[:amount]
      )

      @account.balance += transaction_params[:amount].to_f
      @account.save!

      if transaction.save!
        render json: transaction, status: :created, message: 'Transaction created'
      end

    else
      render json: { error: "Account not found" }, status: :bad_request
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find_by(transaction_id: params[:id])
  end

  def set_transactions
    @transactions = Transaction.all.includes(:account)
  end

  def set_account
    @account = Account.find_by(account_id: transaction_params[:accountId])
  end

  def transaction_params
    params.require(:transaction).permit(:amount).merge(accountId: params[:accountId])#.merge(accountId: params[:account_id])
  end
end
