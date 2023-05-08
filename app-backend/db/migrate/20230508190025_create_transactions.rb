class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.string :transaction_id
      t.integer :amount
      t.string :transaction_account_id

      t.timestamps
    end
  end
end
