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
