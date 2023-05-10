require 'test_helper'

class Api::V1::TransactionsControllerTest < ActionController::TestCase

  test "should not create account if one already exists with matching account_id" do
    id = SecureRandom.uuid
    Account.create(account_id: id, balance: 0)

    assert_raises ActiveRecord::RecordInvalid do
      Account.create!(account_id: id, balance: 0)
    end

    puts "Account ID must be unique"
  end

  test "should create transaction with all required attributes" do
    account = Account.create(account_id: SecureRandom.uuid, balance: 0)

    assert_difference("Transaction.count") do
      post :create, params: { transaction: { account_id: account.account_id, amount: 100 } }
    end
    assert_response :created

    transaction = Transaction.last
    assert_equal account, transaction.account
    assert_equal 100, transaction.amount
    assert_equal 100, transaction.account.balance

    puts "Transaction created with all required attributes"
  end

  test "should not create transaction without account_id" do
    assert_no_difference("Transaction.count") do
      post :create, params: { transaction: { account_id: "", amount: 100 } }
    end
    assert_response :bad_request
    assert_includes response.body, "Account ID not valid"

    puts "Transaction cannot be made without account_id"
  end

  test "should not create transaction without account_id as UUID" do
    assert_no_difference("Transaction.count") do
      post :create, params: { transaction: { account_id: "1234567890", amount: 100 } }
    end
    assert_response :bad_request
    assert_includes response.body, "Account ID not valid"

    puts "Transaction cannot be made without account_id as UUID"
  end

  test "should not create transaction with amount equal to 0" do
    account = Account.create(account_id: SecureRandom.uuid, balance: 0)

    assert_no_difference("Transaction.count") do
      post :create, params: { transaction: { account_id: account.account_id, amount: 0 } }
    end

    assert_response :bad_request
    assert_includes response.body, "Transaction amount invalid"

    puts "Transaction cannot be made with amount of 0"
  end

  test "should not create transaction with amount equal to string" do
    account = Account.create(account_id: SecureRandom.uuid, balance: 0)

    assert_no_difference("Transaction.count") do
      post :create, params: { transaction: { account_id: account.account_id, amount: "a" } }
    end

    assert_response :bad_request
    assert_includes response.body, "Transaction amount invalid"

    puts "Transaction cannot be made with amount of string"
  end

  test "should create transaction with negative amount" do
    account = Account.create(account_id: SecureRandom.uuid, balance: 100)

    assert_difference("Transaction.count") do
      post :create, params: { transaction: { account_id: account.account_id, amount: -12 } }
    end
    assert_response :created

    transaction = Transaction.last
    assert_equal account, transaction.account
    assert_equal -12, transaction.amount
    assert_equal 88, transaction.account.balance

    puts "Transaction cannot be made with negative amount"
  end

  test "should not create transaction with amount equal to nil" do
    account = Account.create(account_id: SecureRandom.uuid, balance: 0)

    assert_no_difference("Transaction.count") do
      post :create, params: { transaction: { account_id: account.account_id, amount: nil } }
    end

    assert_response :bad_request
    assert_includes response.body, "Transaction amount invalid"

    puts "Transaction cannot be made with amount of nil"
  end

  test "should access transaction by transaction_id" do
    account = Account.create(account_id: SecureRandom.uuid, balance: 0)
    post :create, params: { transaction: { account_id: account.account_id, amount: 100 } }

    get :show, params: { id: Transaction.last.transaction_id }
    assert_response :ok

    puts "Transaction can be accessed by transaction_id"
  end

  test "should not access transaction by transaction_id if transaction_id does not exist" do
    get :show, params: { id: "123" }
    assert_response :not_found

    puts "Transaction cannot be accessed by transaction_id if transaction_id does not exist"
  end
end
