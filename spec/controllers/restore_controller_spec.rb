require 'rails_helper'

RSpec.describe RestoreController, type: :controller do
  include_context 'application controller'

  describe '#index' do
    let(:items) { double :items, only_deleted: deleted_items }
    let(:deleted_items) { double :items }

    before(:each) do
      allow(user).to receive(:items).and_return items
    end

    it 'should set @items instance variable' do
      get :index
      expect(controller.instance_variable_get(:@items)).to eq deleted_items
    end

    it 'should return 200 status code' do
      get :index
      expect(response).to have_http_status :ok
    end

    it 'should render index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe '#update' do
    let(:folder) { build :folder }
    let(:restore_service) { double :service, restore: nil, folder: folder }

    before(:each) do
      allow(RestoreService).to receive(:new).with(user, '1').and_return restore_service
    end

    it 'should call restore on service' do
      expect(restore_service).to receive(:restore)
      patch :update, id: 1
    end

    it 'should return 200 status code' do
      patch :update, id: 1
      expect(response).to have_http_status :found
    end

    it 'should render index template' do
      patch :update, id: 1
      expect(response).to redirect_to folder
    end
  end
end
