require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  include_context 'application controller'

  context 'filters' do
    it { is_expected.to use_before_action :ensure_can_upload }
  end

  describe '#show' do
    let(:user) { create :user }
    let(:folder) { user.folders.first }
    let(:item) { create :item, user: user, folder_id: folder.id }
    let(:file_path) { "#{Rails.root}/spec/fixtures/carrierwave/IMG_1.png" }

    it 'should send file to user' do
      get :show, folder_id: folder.id, id: item.id
      expect(response.body).to eq IO.binread(file_path)
    end
  end

  describe '#create' do
    let(:user) { create :user }
    let(:folder) { user.folders.first }
    let(:file) { Rack::Test::UploadedFile.new File.open(File.join(Rails.root, '/spec/fixtures/carrierwave/IMG_1.png')) }

    it 'should create an item and return 200 status code' do
      post :create, folder_id: folder.id, item: { file: file }
      expect(response).to have_http_status :ok
    end
  end

  describe '#destroy' do
    let(:user) { create :user }
    let(:folder) { user.folders.first }
    let(:item) { create :item, user: user, folder_id: folder.id }

    it 'should redirect to current folder with notice if destroy was success' do
      allow(item).to receive(:destroy).and_return true
      delete :destroy, folder_id: folder.id, id: item.id
      expect(response).to redirect_to folder
      expect(response).to have_http_status :found
      expect(controller).to set_flash[:notice]
    end
  end
end
