require 'spec_helper'

describe Transaction, 'associations' do
  it { expect(subject).to belong_to(:buyer) }
  it { expect(subject).to belong_to(:seller) }
  it { expect(subject).to belong_to(:player) }
end

describe Transaction, 'validations' do
  it { expect(subject).to validate_presence_of(:buyer) }
  it { expect(subject).to validate_presence_of(:player) }
  it { expect(subject).to validate_presence_of(:price) }
  it { expect(subject).to validate_presence_of(:seller) }
  it { expect(subject).to validate_presence_of(:shares) }
end

describe Transaction, '#price_in_dollars' do
  it 'converts the price into dollars' do
    transaction = create(:transaction, price: 10_00)

    expect(transaction.price_in_dollars).to eq '$10.00'
  end
end
