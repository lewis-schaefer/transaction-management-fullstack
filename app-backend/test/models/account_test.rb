require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "should not create account if one already exists with matching account_id" do
    id = SecureRandom.uuid
    Account.create(account_id: id, balance: 0)

    assert_raises ActiveRecord::RecordInvalid do
      Account.create!(account_id: id, balance: 0)
    end

    puts "Account ID must be unique"
  end
end
