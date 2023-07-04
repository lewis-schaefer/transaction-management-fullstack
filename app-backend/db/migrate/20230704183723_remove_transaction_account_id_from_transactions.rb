class RemoveTransactionAccountIdFromTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :transaction_account_id
  end
end
