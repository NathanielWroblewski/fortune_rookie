require 'spec_helper'

describe Sell, 'associations' do
  it { expect(subject).to belong_to(:seller) }
  it { expect(subject).to belong_to(:player) }
end

describe Sell, 'validations' do
  it { expect(subject).to validate_presence_of(:player) }
  it { expect(subject).to validate_presence_of(:price) }
  it { expect(subject).to validate_presence_of(:seller) }
  it { expect(subject).to validate_presence_of(:shares) }
end

describe Sell, '#pair_with_a_buy' do
  it 'returns a sale of equal value to the buy price' do
    player = create(:player)
    existing_sell = create(:sell, player: player, price: 10)

    sell = Sell.pair_with_a_buy(player.id, 10)

    expect(sell).to eq existing_sell
  end

  it 'returns a sale with a lower price than the buy price' do
    player = create(:player)
    existing_sell = create(:sell, player: player, price: 3)

    sell = Sell.pair_with_a_buy(player.id, 10)

    expect(sell).to eq existing_sell

  end

  it 'does not a sale with a price higher than the buy price' do
    player = create(:player)
    existing_sell = create(:sell, player: player, price: 15)

    sell = Sell.pair_with_a_buy(player.id, 10)

    expect(sell).to_not be_present
  end

  it 'returns the earliest posted sale if two sales have the same price' do
    player = create(:player)
    earliest_sell = create(:sell, player: player, price: 15)
    later_sell = create(:sell, player: player, price: 15)

    sell = Sell.pair_with_a_buy(player.id, 15)

    expect(sell).to eq earliest_sell
    expect(sell).to_not eq later_sell
  end
end

describe Sell, '#price_in_dollars' do
  it 'converts the price to dollars' do
    sell = build(:sell, price: 10_00)

    expect(sell.price_in_dollars).to eq '$10.00'
  end
end
