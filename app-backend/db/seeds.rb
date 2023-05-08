# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Account.create(account_id: SecureRandom.uuid, balance: 1000)

account = Account.first

Transaction.create!(account_id: account.id, amount: 10, transaction_id: SecureRandom.uuid, transaction_account_id: account.account_id)
Transaction.create!(account_id: account.id, amount: 10, transaction_id: SecureRandom.uuid, transaction_account_id: account.account_id)
Transaction.create!(account_id: account.id, amount: 10, transaction_id: SecureRandom.uuid, transaction_account_id: account.account_id)
