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

  describe '#show' do
    let(:item) { create(:item) }
    let(:call_request) { get :show, params: { id: item.id } }

    it_behaves_like 'an action rendering view'
  end

  describe '#destroy' do
    let!(:item) { create(:item) }
    let(:call_request) { delete :destroy, params: { id: item } }

    context 'when logged in as admin' do
      let!(:admin) { create(:admin) }
      context 'when is no bidders' do
        before { sign_in admin }

        it_behaves_like 'an action destroying object'
      end

      context 'when is at least one bidder' do
        let(:user) { create(:user) }
        let!(:bid) { item.bids.create(user: user) }
        before { sign_in admin }

        it_behaves_like 'an action destroying object', expect_failure: true
        it_behaves_like 'an action redirecting to', -> { item_path item }
      end
    end
    context 'when logged in as regular user' do
      let!(:user) { create(:user) }
      before { sign_in user }

      it_behaves_like 'an action destroying object', expect_failure: true
      it_behaves_like 'an action redirecting to', -> { new_user_session_path }
    end

    context 'when guest' do
      let(:call_request) { delete :destroy, params: { id: item.id } }

      it_behaves_like 'an action destroying object', expect_failure: true
      it_behaves_like 'an action redirecting to', -> { new_user_session_path }
    end
  end

  describe '#create' do
    let!(:item) { build(:item) }
    let(:attributes) { attributes_for(:item) }

    context 'when logged in as admin' do
      let!(:admin) { create(:admin) }
      before { sign_in admin }
      let(:call_request) { post :create, item: attributes }

      it_behaves_like 'an action creating object'
      it_behaves_like 'an action redirecting to', -> { controller.item }
    end

    context 'when logged in as regular user' do
      let!(:user) { create(:user) }
      before { sign_in user }
      let(:call_request) { post :create, item: attributes }

      it_behaves_like 'an action creating object', expect_failure: true
      it_behaves_like 'an action redirecting to', -> { new_user_session_path }
    end

    context 'when guest' do
      let(:call_request) { post :create, item: attributes }

      it_behaves_like 'an action creating object', expect_failure: true
      it_behaves_like 'an action redirecting to', -> { new_user_session_path }
    end
  end

  describe '#update' do
    let!(:item) { create(:item) }
    let(:attributes) { attributes_for(:item) }
    context 'when loggen in as admin' do
      let!(:admin) { create(:admin) }
      before { sign_in admin }
      let(:call_request) { patch :update, id: item, item: attributes }

      it_behaves_like 'an action updating object', [:name, :description]
      it_behaves_like 'an action redirecting to', -> { item_path }
    end

    context 'when logged in as regular user' do
      let!(:user) { create(:user) }
      before { sign_in user }
      let(:call_request) { patch :update, id: item.id, item: attributes }

      it_behaves_like 'an action updating object', expect_failure: true
      it_behaves_like 'an action redirecting to', -> { new_user_session_path }
    end

    context 'when guest' do
      let(:call_request) { patch :update, id: item.id, item: attributes }

      it_behaves_like 'an action updating object', expect_failure: true
      it_behaves_like 'an action redirecting to', -> { new_user_session_path }
    end
  end

  describe '#draw' do
    let(:item) { create(:item) }
    let(:admin) { create(:admin) }
    before do
      sign_in admin
      post :draw, params: { id: item }
    end

    context 'when cannot run draw' do
      it { expect(controller.item.user_id).to eql(nil) }
    end

    context 'when can run draw' do
      let(:user1) { create(:user) }
      let(:user2) { create(:user) }
      let!(:bid1) { item.bids.create(user: user1) }
      let!(:bid2) { item.bids.create(user: user2) }
      before do
        sign_in admin
        post :draw, params: { id: item.id }
      end

      it { expect(controller.item.user_id).not_to eql(nil) }
    end
  end
end
