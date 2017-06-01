require 'rails_helper'

RSpec.describe RecentsController, type: :controller do
  include_context 'application controller'

  describe '#index' do
    let(:items) { double :items, recents: recents_items }
    let(:recents_items) { double :items }

    before(:each) do
      allow(user).to receive(:items).and_return items
    end

    it 'should set @items instance variable' do
      get :index
      expect(controller.instance_variable_get(:@items)).to eq recents_items
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
end
