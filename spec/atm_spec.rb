#As a User
 #In order to make an withdrawal
 #The ATM needs to have funds

require './lib/atm.rb'

describe ATM do
  it 'has 1000 dollars on initialize' do
    expect(subject.funds).to eq 1000
  end

  it 'funds are reduced on withdrawal' do
    subject.withdraw 50
    expect(subject.funds).to eq 950
  end
end
