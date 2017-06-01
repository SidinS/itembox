require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  include_context 'application controller'

  describe '#index' do
    let(:items) { double :items, favorites: favorites_items }
    let(:favorites_items) { double :items }

    before(:each) do
      allow(user).to receive(:items).and_return items
    end

    it 'should set @items instance variable' do
      get :index
      expect(controller.instance_variable_get(:@items)).to eq favorites_items
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

  describe '#create' do
    let(:items) { double :items }
    let(:item) { double :item, favorite!: nil }

    before(:each) do
      allow(user).to receive(:items).and_return items
      allow(items).to receive(:find).with('1').and_return item
    end

    it 'should set @item instance variable' do
      post :create, id: 1
      expect(controller.instance_variable_get(:@item)).to eq item
    end

    it 'should call favorite! on @item' do
      expect(item).to receive(:favorite!)
      post :create, id: 1
    end

    it 'should return 200 status code' do
      post :create, id: 1
      expect(response).to have_http_status :ok
    end
  end

  describe '#destroy' do
    let(:items) { double :items }
    let(:item) { double :item, favorite!: nil }

    before(:each) do
      allow(user).to receive(:items).and_return items
      allow(items).to receive(:find).with('1').and_return item
    end

    it 'should set @item instance variable' do
      delete :destroy, id: 1
      expect(controller.instance_variable_get(:@item)).to eq item
    end

    it 'should call favorite! with false on @item' do
      expect(item).to receive(:favorite!).with(false)
      delete :destroy, id: 1
    end

    it 'should return 200 status code' do
      delete :destroy, id: 1
      expect(response).to have_http_status :ok
    end
  end

  describe '#initialize_item' do
    let(:items) { double :items }
    let(:item) { double :item }

    before(:each) do
      allow(user).to receive(:items).and_return items
      allow(items).to receive(:find).with('1').and_return item
      allow(controller).to receive(:params).and_return id: '1'
    end

    it 'should set @item instance variable' do
      controller.send :initialize_item
      expect(controller.instance_variable_get(:@item)).to eq item
    end
  end
end
