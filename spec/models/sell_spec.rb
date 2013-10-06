require 'spec_helper'

describe Sell, 'associations' do
  it { expect(subject).to belong_to(:seller) }
end

describe Sell, 'validations' do
  it { expect(subject).to validate_presence_of(:seller) }
  it { expect(subject).to validate_presence_of(:shares) }
  it { expect(subject).to validate_presence_of(:price) }
end

describe Sell, '#price_in_dollars' do
  it 'converts the price to dollars' do
    sell = build(:sell, price: 10_00)

    expect(sell.price_in_dollars).to eq '$10.00'
  end
end
