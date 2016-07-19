require 'rails_helper'

RSpec.describe 'DrawWinner' do
  describe '#can_run_draw' do
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

  pending '#set_winner'

  pending '#send_win_confirmation'
end
