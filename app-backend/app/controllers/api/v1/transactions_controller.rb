class Api::V1::TransactionsController < ApplicationController
  before_action :set_transactions, only: [:index]
  before_action :set_account, only: [:create]
  skip_before_action :verify_authenticity_token #solves the CSRF error

  def index
    render json: {
      data: {
        transactions: @transactions.map { |transaction| {
          transaction_id: transaction.transaction_id,
          transaction_amount: transaction.amount,
          account_id: transaction.account_id,
          account_balance: transaction.account.balance,
          created_at: transaction.created_at
        } }
      }, status: :ok
    }
  end

  def create
    # binding.pry

    if @account.present?
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

      # Error codes from schema needed??
      # else
      #   if transaction.errors.include?(:account_id)
      #     render json: { error: 'Specified content type not allowed' }, status: :unsupported_media_type
      #   elsif transaction.errors.any?
      #     render json: { errors: transaction.errors.full_messages }, status: :bad_request, message: 'Mandatory body parameters missing or have incorrect type'
      #   else
      #     render json: { error: 'Specified HTTP method not allowed' }, status: :method_not_allowed
      #   end
      end

    else
      render json: { error: "Account not found" }, status: :bad_request
    end
  end

  private

  def set_transactions
    @transactions = Transaction.all.includes(:account)
  end

  def set_account
    @account = Account.find_by(account_id: transaction_params[:accountId])
  end

  def transaction_params
    params.require(:transaction).permit(:amount).merge(accountId: params[:accountId])
  end
end
