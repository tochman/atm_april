require 'date'

class ATM
  attr_accessor :funds
  FUNDS_ON_INITIALIZE = 1000

  def initialize
    @funds = FUNDS_ON_INITIALIZE
  end

  def withdraw(amount, pin_code, account)
    if insufficient_funds_in_account?(amount, account)
      { status: false,
        message: 'Unsuccessful: insufficient funds in account',
        date: Date.today }
    elsif insufficient_funds_in_atm(amount)
      { status: false,
        message: 'Unsuccessful: insufficient funds in ATM',
        date: Date.today }
    elsif wrong_pin_is_provided(pin_code, account.pin_code)
      { status: false,
        message: 'Unsuccessful: wrong pin code',
        date: Date.today }
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
    { status: true, message: 'successful', date: Date.today, amount: amount }
  end

  def insufficient_funds_in_atm(amount)
    amount > @funds
  end

  def wrong_pin_is_provided(provided_pin, actual_pin)
    provided_pin != actual_pin
  end
end
