class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :account_id
      t.integer :balance

      t.timestamps
    end
  end
end
