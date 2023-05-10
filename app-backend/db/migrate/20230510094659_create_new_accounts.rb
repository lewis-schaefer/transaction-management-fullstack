class CreateNewAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :new_accounts do |t|

      t.timestamps
    end
  end
end
