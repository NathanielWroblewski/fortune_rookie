require 'spec_helper'

describe Buy, 'associations' do
  it { expect(subject).to belong_to(:buyer) }
  it { expect(subject).to belong_to(:player) }
end

describe Buy, 'validations' do
  it { expect(subject).to validate_presence_of(:buyer) }
  it { expect(subject).to validate_presence_of(:player) }
  it { expect(subject).to validate_presence_of(:price) }
  it { expect(subject).to validate_presence_of(:shares) }
end

describe Buy, '#create_transaction' do
  it 'creates a transaction if there is a seller' do
    player = create(:player)
    seller = create(:user)
    buyer = create(:user)
    buy = build(:buy, player: player, price: 10_00, buyer: buyer, shares: 0)
    sell = create(:sell, player: player, price: 9_00, seller: seller)

    transaction = buy.create_transaction

    expect(transaction).to be
    expect(transaction.buyer_id).to eq buy.buyer_id
    expect(transaction.seller_id).to eq sell.seller_id
    expect(transaction.price).to eq sell.price
  end

  it 'does not create a transaction if there is not a seller' do
    buy = build(:buy)

    expect(buy.create_transaction).to eq nil
  end
end

describe Buy, '#pair_with_a_sell' do
  it 'returns the buy of equal value to the sell price' do
    player = create(:player)
    existing_buy = create(:buy, price: 10_00, player: player)

    buy = Buy.pair_with_a_sell(player.id, 10_00)

    expect(buy).to eq existing_buy
  end

  it 'returns a buy with a higher price than the sale price' do
    player = create(:player)
    existing_buy = create(:buy, price: 20_00, player: player)

    buy = Buy.pair_with_a_sell(player.id, 10_00)

    expect(buy).to eq existing_buy
  end

  it 'does not return a buy with a price lower than the sell price' do
    player = create(:player)
    existing_buy = create(:buy, price: 10_00, player: player)

    buy = Buy.pair_with_a_sell(player.id, 20_00)

    expect(buy).to_not eq existing_buy
    expect(buy).to_not be_present
  end

  it 'returns the earliest posted buy above the sale price' do
    player = create(:player)
    early_buy = create(:buy, price: 10_00, player: player)
    expensive_buy = create(:buy, price: 20_00, player: player)

    buy = Buy.pair_with_a_sell(player.id, 5_00)

    expect(buy).to_not eq expensive_buy
    expect(buy).to eq early_buy
  end
end

describe Buy, '#price_in_dollars' do
  it 'converts the price to dollars' do
    buy = build(:buy, price: 10_00)

    expect(buy.price_in_dollars).to eq '$10.00'
  end
end

describe Buy, '#seller_waiting?' do
  it 'returns true if the current player is for sale' do
    player = create(:player)
    sell = create(:sell, player: player)
    buy = build(:buy, player: player)

    expect(buy.seller_waiting?).to eq true
  end

  it 'returns false if the current player is not for sale' do
    buy = build(:buy, player_id: 1)

    expect(buy.seller_waiting?).to eq false
  end
end
