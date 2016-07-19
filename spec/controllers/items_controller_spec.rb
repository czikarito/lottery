require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe '#index' do
    let!(:items) { create_list(:item, 7) }
    context 'home' do
      before { get :index }

      it { expect(controller.items).to contain_exactly(*items[0..5]) }

      it { expect(response).to render_template(:index) }
    end

    context 'search' do
      let(:item) { create(:item) }
      before { get :index, params: { q: { name_cont: item.name } } }

      it { expect(controller.items).to contain_exactly(item) }
    end
  end
end
