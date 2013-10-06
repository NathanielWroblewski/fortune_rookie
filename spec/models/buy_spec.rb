require 'spec_helper'

describe Buy, 'associations' do
  it { expect(subject).to belong_to(:buyer) }
end

describe Buy, 'validations' do
  it { expect(subject).to validate_presence_of(:buyer) }
  it { expect(subject).to validate_presence_of(:shares) }
  it { expect(subject).to validate_presence_of(:price) }
end

describe Buy, '#price_in_dollars' do
  it 'converts the price to dollars' do
    buy = build(:buy, price: 10_00)

    expect(buy.price_in_dollars).to eq '$10.00'
  end
end
