require 'rails_helper'

RSpec.describe 'DrawWinner' do

  describe '#call' do
    let(:item) { create(:item) }
    let(:draw_winner) { DrawWinner.new(item) }
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let!(:bid1) { item.bids.create(user: user1) }
    let!(:bid2) { item.bids.create(user: user2) }
    before { draw_winner.call }

    it { expect([user1, user2]).to include(item.user) }
  end
end
