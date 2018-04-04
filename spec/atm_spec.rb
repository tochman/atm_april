require './lib/atm.rb'

describe ATM do
  let(:account) { instance_double('Account') }

  before do
    allow(account).to receive(:balance).and_return(100)
    allow(account).to receive(:pin_code).and_return(1234)

    allow(account).to receive(:balance=)
    @wrong_pin = 9999
    @correct_pin = 1234
  end

  it 'has 1000 dollars on initialize' do
    expect(subject.funds).to eq 1000
  end

  it 'funds are reduced on withdrawal' do
    subject.withdraw(50, @correct_pin, account)
    expect(subject.funds).to eq 950
  end

  it 'allow withdraw if account has enough balance' do
    expected_output = { status: true,
                        message: 'successful',
                        date: Date.today,
                        amount: 45 }
    expect(subject.withdraw(45, @correct_pin, account)).to eq expected_output
  end

  it 'rejects withdraw if account has insufficient funds' do
    expected_output = { status: false,
                        message: 'Unsuccessful: insufficient funds in account',
                        date: Date.today }
    expect(subject.withdraw(105, @correct_pin, account)).to eq expected_output
  end

  it 'rejects withdraw if ATM has insufficient funds' do
    subject.funds = 500
    allow(account).to receive(:balance).and_return(600)
    expected_output = { status: false,
                        message: 'Unsuccessful: insufficient funds in ATM',
                        date: Date.today }
    expect(subject.withdraw(600, @correct_pin, account)).to eq expected_output
  end

  it 'rejects withdrawal if PinCode is not correct' do
    expected_output = { status: false,
                        message: 'Unsuccessful: wrong pin code',
                        date: Date.today }
    expect(subject.withdraw(50, @wrong_pin, account)).to eq expected_output
  end
end
