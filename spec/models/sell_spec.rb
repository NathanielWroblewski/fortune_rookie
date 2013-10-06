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

describe Sell, '#buyer_waiting?' do
  it 'return true if someone wants to buy the player' do
    player = create(:player)
    buy = create(:buy, player: player)
    sell = create(:sell, player: player)

    expect(sell.buyer_waiting?).to eq true
  end

  it 'returns false if no one wants to buy the player' do
    player = create(:player)
    sell = create(:sell, player: player)

    expect(sell.buyer_waiting?).to eq false
  end
end

describe Sell, '#create_transaction' do
  it 'creates a transaction if there is a buyer' do
    player = create(:player)
    buyer = create(:user)
    seller = create(:user)
    sell = build(:sell, player: player, price: 9_00, seller: seller, shares: 0)
    buy = create(:buy, player: player, price: 10_00, buyer: buyer)

    transaction = sell.create_transaction

    expect(transaction).to be
    expect(transaction.buyer_id).to eq buyer.id
    expect(transaction.seller_id).to eq seller.id
    expect(transaction.price).to eq sell.price
  end

  it 'does not create a transaction if there is no buyer' do
    sell = build(:sell)

    expect(sell.create_transaction).to eq nil
  end
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
