require_relative '../../../services/new_account'

class Api::V1::TransactionsController < ApplicationController
  before_action :set_transactions, only: [:index]
  before_action :set_transaction, only: [:show]
  before_action :set_account, only: [:create]
  skip_before_action :verify_authenticity_token

  def show
    render json: transaction_hash(@transaction), status: :ok
  end

  def index
    render json: { transactions: @transactions.map { |transaction| transaction_hash(transaction) } }, status: :ok
  end

  def create
    if @account.nil?
      if valid_uuid?(transaction_params[:account_id])
        @account = NewAccount.new(transaction_params[:account_id]).perform
      else
        render json: { error: "Account ID not valid" }, status: :bad_request
        return
      end
    end

    # if transaction_params[:amount].nil? || transaction_params[:amount] == 0
    #   render json: { errors: "Transaction amount invalid" }, status: :bad_request, message: 'Mandatory body parameters missing or have incorrect type'
    # else
    #   new_transaction
    # end
    new_transaction
  end

  private

  def set_transaction
    @transaction = Transaction.find_by(transaction_id: params[:id])
  end

  def set_transactions
    @transactions = Transaction.all.includes(:account)
  end

  def set_account
    @account = Account.find_by(account_id: transaction_params[:account_id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :account_id)
  end

  def valid_uuid?(uuid)
    uuid_regex = /\A[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}\z/i
    !uuid.nil? && uuid_regex.match?(uuid)
  end

  def transaction_hash(transaction)
    {
    transaction_id: transaction.transaction_id,
    amount: transaction.amount,
    account_id: transaction.account.account_id,
    account_balance: transaction.account.balance,
    created_at: transaction.created_at
    }
  end

  def new_transaction
    transaction = Transaction.create(
      account_id: @account.id,
      transaction_id: SecureRandom.uuid,
      transaction_account_id: @account.account_id,
      amount: transaction_params[:amount]
    )

    if transaction.save!
      @account.balance += transaction_params[:amount].to_f
      @account.save!
      render json: transaction, status: :created, message: 'Transaction created'
    else
      render json: { errors: "Transaction amount invalid" }, status: :bad_request, message: 'Mandatory body parameters missing or have incorrect type'
    end
  end
end
