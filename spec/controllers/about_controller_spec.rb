require 'rails_helper'

RSpec.describe AboutController, type: :controller do
  include_context 'application controller'

  describe '#index' do
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
