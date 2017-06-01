require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  context 'filters' do
    it { is_expected.to use_before_action :authenticate_user! }
    it { is_expected.to use_before_action :set_locale }
  end

  describe '#set_locale' do
    let(:user) { double :user, locale: locale }
    let(:locale) { double :locale, name: 'ru-RU' }

    it 'should set locale to user locale' do
      allow(controller).to receive(:current_user).and_return user
      controller.send :set_locale
      expect(I18n.locale).to eq user.locale.name.to_sym
    end

    it 'should not set locale to user locale if user is not present' do
      I18n.locale = 'en-US'
      allow(controller).to receive(:current_user).and_return nil
      controller.send :set_locale
      expect(I18n.locale).to eq 'en-US'.to_sym
    end
  end

  describe '#root_folder' do
    let(:user) { double :user, folders: [folder1, folder2] }
    let(:folder1) { double :folder }
    let(:folder2) { double :folder }

    it 'should return root folder for user' do
      allow(controller).to receive(:current_user).and_return user
      expect(controller.send(:root_folder)).to eq folder1
    end
  end

  describe '#current_folder' do
    let(:user) { double :user, folders: folders }
    let(:folders) { double :folders }
    let(:folder1) { double :folder, id: 2 }
    let(:folder2) { double :folder, id: 3 }
    let(:root_folder) { double :folder, id: 1 }

    before(:each) do
      allow(controller).to receive(:current_user).and_return user
    end

    it 'should use id from params to find a folder' do
      allow(controller).to receive(:params).and_return id: 2
      allow(folders).to receive(:find).with(2).and_return folder1
      expect(controller.send(:current_folder)).to eq folder1
    end

    it 'should use folder id from params to find a folder' do
      allow(controller).to receive(:params).and_return folder_id: 3
      allow(folders).to receive(:find).with(3).and_return folder2
      expect(controller.send(:current_folder)).to eq folder2
    end

    it 'should return root folder if params is empty' do
      allow(controller).to receive(:root_folder).and_return root_folder
      expect(controller.send(:current_folder)).to eq root_folder
    end
  end
end
