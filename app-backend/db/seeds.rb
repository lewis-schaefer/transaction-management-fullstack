# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Account.create(account_id: SecureRandom.uuid, balance: 1000)

# account = Account.first

# Transaction.create!(account_id: account.id, amount: 10, transaction_id: SecureRandom.uuid, transaction_account_id: account.account_id)
# Transaction.create!(account_id: account.id, amount: 10, transaction_id: SecureRandom.uuid, transaction_account_id: account.account_id)
# Transaction.create!(account_id: account.id, amount: 10, transaction_id: SecureRandom.uuid, transaction_account_id: account.account_id)

Account.create(account_id: "54b58b00-b48b-45f7-a839-ec4a683667d7", balance: 0)
Account.create(account_id: "25ad2792-eb37-4851-8288-59c52e9a14e2", balance: 0)
Account.create(account_id: "2026d3b5-c4c8-4062-bd68-ca5b2d52dfe1", balance: 0)
Account.create(account_id: "d8bcd7ef-7a3c-46c9-9d36-badd62e3e242", balance: 0)
