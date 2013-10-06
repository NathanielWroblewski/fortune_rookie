require 'spec_helper'

describe Player, 'validations' do
  it { expect(subject).to validate_presence_of(:first_name) }
  it { expect(subject).to validate_presence_of(:last_name) }
  it { expect(subject).to validate_presence_of(:draft_year) }
  it { expect(subject).to validate_presence_of(:ipo) }
  it { expect(subject).to validate_presence_of(:last_ask) }
  it { expect(subject).to validate_presence_of(:current_price) }
end

describe Player, '#current_price_in_dollars' do
  it 'converts the ipo into a dollar amount' do
    player = build(:player, current_price: 32_00)

    expect(player.current_price_in_dollars).to eq '$32.00'
  end
end

describe Player, '#set_current_price' do
  it 'should set the current price equal to the ipo' do
    player = create(:player, ipo: 32_00)

    expect(player.reload.current_price).to eq 3200
  end
end
