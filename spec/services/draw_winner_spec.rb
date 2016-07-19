require 'rails_helper'

RSpec.describe 'DrawWinner' do
  describe '#can_run_draw?' do
    let(:item) { create(:item) }
    let(:draw_winner) { DrawWinner.new(item) }
    context 'yes' do
      let(:user1) { create(:user) }
      let(:user2) { create(:user) }
      let!(:bid1) { item.bids.create(user: user1) }
      let!(:bid2) { item.bids.create(user: user2) }

      it { expect(draw_winner.can_run_draw?).to eql(true) }
    end
    context 'no' do
      it { expect(draw_winner.can_run_draw?).to eql(false) }
    end
  end

  describe '#rand_winner' do
    let(:item) { create(:item) }
    let(:draw_winner) { DrawWinner.new(item) }
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let!(:bid1) { item.bids.create(user: user1) }
    let!(:bid2) { item.bids.create(user: user2) }
    before { draw_winner.rand_winner }

    it { expect([user1, user2]).to include(item.user) }
  end

  describe '#send_mail' do
    let(:draw_winner) { DrawWinner.new(item) }
    let(:user) { create(:user) }
    let(:item) { create(:item, user: user) }
    it { expect{draw_winner.send_mail}.to change { ActionMailer::Base.deliveries.count}.by(1) }
  end
end
