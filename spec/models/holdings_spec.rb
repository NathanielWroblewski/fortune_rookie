require 'spec_helper'

describe Holding, 'associations' do
  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to belong_to(:player) }
end

describe Holding, 'validations' do
  it { expect(subject).to validate_presence_of(:shares) }
  it { expect(subject).to validate_presence_of(:price_per_share) }
  it { expect(subject).to validate_presence_of(:user) }
  it { expect(subject).to validate_presence_of(:player) }
end

describe Holding, '#cash_per_share' do
  it 'converts the price per share into a dollar amount' do
    holding = build(:holding, price_per_share: 10_00)

    expect(holding.cash_per_share).to eq '$10.00'
  end
end
