class RemoveNewAccounts < ActiveRecord::Migration[7.0]
  def change
    drop_table :new_accounts
  end
end
