#As a User
 #In order to make an withdrawal
 #The ATM needs to have funds

require './lib/atm.rb'

describe ATM do
  it 'has 1000 dollars on initialize' do
    expect(subject.funds).to eq 1000
  end
end
