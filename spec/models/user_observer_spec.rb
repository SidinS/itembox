require 'rails_helper'

RSpec.describe UserObserver do
  let(:user) { double :user }
  let(:observer) { described_class.instance }

  describe 'listen' do
    it 'should observe User' do
      expect(UserObserver.observed_classes).to include(User)
    end
  end

  describe '#before_create', slow: true do
    let!(:ru) { create(:ru) }
    let!(:en) { create(:en) }
    let!(:user) { create(:user) }

    it 'should create user with default locale' do
      expect(user.locale.id).to eq ru.id
    end
  end

  describe '#after_create', slow: true do
    let!(:user) { create(:user) }

    it 'should create root folder for user' do
      expect(user.folders.count).to eq 1
    end
  end

  describe '#before_destroy', slow: true do
    let!(:user) { create(:user) }
    let!(:folder) { create(:folder, user: user) }

    let!(:item) do
      item = build(:item, user: user)
      item.save!(validate: false)
    end

    it 'should destroy items and folders before destroy user' do
      user.destroy
      expect(Folder.with_deleted.count).to eq 0
      expect(Item.with_deleted.count).to eq 0
    end
  end
end
