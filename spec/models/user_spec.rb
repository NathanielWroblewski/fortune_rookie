require 'spec_helper'

describe User, '#balance_as_money' do
  it 'shows the balance as a dollar amount' do
    user = create(:user, balance: 100_00)

    expect(user.balance_as_money).to eq '$100.00'
  end
end
