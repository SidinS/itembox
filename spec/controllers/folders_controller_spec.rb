require 'rails_helper'

RSpec.describe FoldersController, type: :controller do
  include_context 'application controller'

  context 'filters' do
    it { is_expected.to use_before_action :set_folder }
  end

  describe '#index' do
    let(:folder1) { double :folder }
    let(:folder2) { double :folder }

    before(:each) do
      allow(user).to receive(:folders).and_return [folder1, folder2]
    end

    it 'should set @folder instance variable' do
      get :index
      expect(controller.instance_variable_get(:@folder)).to eq folder1
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

  describe '#show' do
    let(:root_folder) { double :folder, id: 1 }
    let(:folder) { double :folder, id: 2 }
    let(:folders) { double :folders }

    before(:each) do
      allow(controller).to receive(:root_folder).and_return root_folder
      allow(user).to receive(:folders).and_return folders
      allow(folders).to receive(:find).with('1').and_return root_folder
      allow(folders).to receive(:find).with('2').and_return folder
    end

    it 'should redirect to folders url if request folder is root folder' do
      get :show, id: 1
      expect(response).to redirect_to folders_url
    end

    it 'should return 302 status code if request folder is root folder' do
      get :show, id: 1
      expect(response).to have_http_status :found
    end

    it 'should render show template if request folder is not root folder' do
      get :show, id: 2
      expect(response).to render_template :show
    end

    it 'should return 200 status code if request folder is not root folder' do
      get :show, id: 2
      expect(response).to have_http_status :ok
    end
  end

  describe '#create' do
    let(:user) { create :user }
    let(:root_folder_id) { user.folders.first.id }

    before(:each) do
      allow(controller).to receive(:current_user).and_return user
    end

    it 'should redirect to new folder with notice message if folder was saved successfully' do
      post :create, folder: { title: 'New folder', root_folder_id: root_folder_id }
      expect(response).to have_http_status :found
      expect(controller).to set_flash[:notice]
    end

    it 'should redirect to new folder with default alert message if folder was not saved successfully' do
      post :create, folder: { title: nil, root_folder_id: root_folder_id }
      expect(response).to have_http_status :found
      expect(controller).to set_flash[:alert]
    end

    it 'should redirect to new folder with alert message from errors if folder was not saved successfully' do
      create :folder, title: 'Test', user: user, root_folder_id: root_folder_id
      post :create, folder: { title: 'Test', root_folder_id: root_folder_id }
      expect(response).to have_http_status :found
      expect(controller).to set_flash[:alert]
    end
  end

  describe '#update' do
    let(:user) { create :user }
    let(:folder) { create :folder, user: user }

    before(:each) do
      allow(controller).to receive(:current_user).and_return user
    end

    it 'should return 200 if folder was saved successfully' do
      put :update, id: folder.id, folder: { title: 'New folder', slug: 'slug' }
      expect(response).to have_http_status :ok
    end

    it 'should return 422 if folder was not saved successfully' do
      put :update, id: folder.id, folder: { title: nil, slug: 'slug' }
      expect(response).to have_http_status :unprocessable_entity
    end
  end

  describe '#destroy' do
    let(:user) { create :user }
    let(:folder) { create :folder, user: user }

    before(:each) do
      allow(controller).to receive(:current_user).and_return user
    end

    it 'should redirect to folders url with notice message if folder was destroyed successfully' do
      delete :destroy, id: folder.id
      expect(response).to redirect_to folders_url
      expect(response).to have_http_status :found
      expect(controller).to set_flash[:notice]
    end
  end

  describe '#set_folder' do
    let(:user) { double :user, folders: folders }
    let(:folders) { double :folders }
    let(:folder) { double :folder }

    before(:each) do
      allow(controller).to receive(:params).and_return id: 1
      allow(folders).to receive(:find).with(1).and_return folder
    end

    it 'should set instance variable @folder' do
      controller.send :set_folder
      expect(controller.instance_variable_get(:@folder)).to eq folder
    end

    it 'should return folder' do
      expect(controller.send(:set_folder)).to eq folder
    end
  end
end
