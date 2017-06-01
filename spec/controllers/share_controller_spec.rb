require 'rails_helper'

RSpec.describe ShareController, type: :controller do
  include_context 'application controller'

  context 'filters' do
    it { is_expected.to use_before_action :initialize_share }
    it { is_expected.to use_before_action :ensure_has_access }
  end

  describe '#index' do
    let(:user) { create :user }
    let(:folder) { user.folders.first }
    let(:item1) { create :item, user: user, folder_id: folder.id, share_url: 'share_url' }
    let(:item2) { create :item, user: user, folder_id: folder.id, share_url: 'share_url' }

    it 'should render 200 status code' do
      get :index
      expect(response).to have_http_status :ok
    end

    it 'should render index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'should render index template' do
      get :index
      expect(controller.instance_variable_get(:@items)).to match_array [item1]
    end
  end

  describe '#show' do
    let(:user) { create :user }
    let(:file_path) { "#{Rails.root}/spec/fixtures/carrierwave/IMG_1.png" }

    it 'should send file to user' do
      item = create :item, user: user, share_url: 'share_url'
      get :show, id: item.id
      expect(response.body).to eq IO.binread(file_path)
    end

    it 'should return forbidden if items is not share' do
      item = create :item, user: user
      get :show, id: item.id
      expect(response).to have_http_status :forbidden
    end
  end

  describe '#create' do
    let(:item) { create :item }

    it 'should add share url to item and return 200 status code' do
      post :create, id: item.id
      expect(response).to have_http_status :ok
    end

    it 'should add share url to item' do
      post :create, id: item.id
      expect(item.reload.share_url).to eq share_url(item)
    end
  end

  describe '#destroy' do
    let(:item) { create :item, share_url: 'share_url' }

    it 'should remove share url to item and return 200 status code' do
      delete :destroy, id: item.id
      expect(response).to have_http_status :ok
    end

    it 'should remove share url to item' do
      delete :destroy, id: item.id
      expect(item.reload.share_url).to be nil
    end
  end
end
