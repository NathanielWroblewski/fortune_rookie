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

describe Transaction, '#create_holding' do
  it 'creates a holding with the transaction data' do
    buyer = create(:user)
    seller = create(:user)
    player = create(:player)
    transaction = build(:transaction,
      price: 10_00,
      buyer: buyer,
      seller: seller,
      player: player,
      shares: 15
    )

    holding = transaction.create_holding

    expect(holding).to be
    expect(holding.price_per_share).to eq transaction.price
    expect(holding.shares).to eq transaction.shares
    expect(holding.user).to eq buyer
    expect(holding.player).to eq player
  end
end

describe Transaction, '#price_in_dollars' do
  it 'converts the price into dollars' do
    transaction = build(:transaction, price: 10_00)
    transaction.stub(:vanquish_holding)

    expect(transaction.price_in_dollars).to eq '$10.00'
  end
end

describe Transaction, '#update_player' do
  it 'updates the current price to equal the last sale price' do
    player = build(:player, current_price: 500_00)
    player.stub(:set_current_price)
    player.save
    transaction = build(:transaction, player: player, price: 10_00)

    transaction.update_player

    expect(player.reload.current_price).to eq 10_00
  end
end

describe Transaction, '#vanquish_holding' do
  it 'destroys the sellers holding' do
    seller = create(:user)
    player = create(:player)
    holding = create(:holding, user: seller, shares: 10, player: player)
    transaction = build(:transaction, seller: seller, shares: 10, player: player)

    transaction.vanquish_holding

    expect(seller.holdings).to_not be_present
  end
end
