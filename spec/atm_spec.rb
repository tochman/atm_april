require './lib/atm.rb'

describe ATM do
  let(:account) { instance_double('Account') }

  before do
    allow(account).to receive(:balance).and_return(100)
    allow(account).to receive(:balance=)
  end

  it 'has 1000 dollars on initialize' do
    expect(subject.funds).to eq 1000
  end

  it 'funds are reduced on withdrawal' do
    subject.withdraw(50, account)
    expect(subject.funds).to eq 950
  end

  it 'allow withdraw if account has enough balance' do
    expected_output = { status: true,
                        message: 'successful',
                        date: Date.today,
                        amount: 45 }
    expect(subject.withdraw(45, account)).to eq expected_output
  end

  it 'rejects withdraw if account has insufficient funds' do
    expected_output = { status: false,
                        message: 'Unsuccessful: insufficient funds in account',
                        date: Date.today }
    expect(subject.withdraw(105, account)).to eq expected_output
  end

  it 'rejects withdraw if ATM has insufficient funds' do
    subject.funds = 500
    allow(account).to receive(:balance).and_return(600)
    expected_output = { status: false,
                        message: 'Unsuccessful: insufficient funds in ATM',
                        date: Date.today }
    expect(subject.withdraw(600, account)).to eq expected_output
  end
end
