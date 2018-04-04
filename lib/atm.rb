require 'date'

class ATM
  attr_accessor :funds
  FUNDS_ON_INITIALIZE = 1000

  def initialize
    @funds = FUNDS_ON_INITIALIZE
  end

  def withdraw(amount, account)
    case
    when insufficient_funds_in_account?(amount, account)
      { status: false, message: 'Unsuccessful: insufficient funds in account', date: Date.today }
    else
      perform_transaction(amount, account)
    end
  end

  private
  def insufficient_funds_in_account?(amount, account)
    amount > account.balance
  end

  def perform_transaction(amount, account)
    @funds -= amount
    account.balance -= amount
    { status: true, message: 'successful', date: Date.today, amount: amount}
  end
end
