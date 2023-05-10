class NewAccount < ApplicationRecord
  def initialize(account_id)
    @account_id = account_id
  end

  def perform
    new_account
  end

  private

  def new_account
    Account.create(account_id: @account_id, balance: 0)
  end
end
