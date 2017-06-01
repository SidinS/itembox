require 'rails_helper'

RSpec.describe RestoreService do
  context 'integration specs', slow: true do
    let!(:user) { create :user }
    let!(:item) { create :item, folder: folder, user: user }
    let!(:folder) { create :folder, user: user }

    it 'should restore item and folder' do
      item.destroy!
      folder.destroy!

      expect(item.deleted_at).not_to be nil
      expect(folder.deleted_at).not_to be nil

      restore_service = described_class.new(user, item.id)
      restore_service.restore

      expect(item.reload.deleted_at).to be nil
      expect(folder.reload.deleted_at).to be nil
    end
  end

  context 'unit specs' do
    let(:user) { double :user, items: items, folders: folders }
    let(:items) { double :items, with_deleted: items_with_deleted }
    let(:folders) { double :folders, with_deleted: folders_with_deleted }
    let(:items_with_deleted) { double :items }
    let(:folders_with_deleted) { double :folders }
    let(:item) { double :item, folder_id: 3 }
    let(:folder) { double :folder }

    subject { described_class.new(user, 2) }

    before(:each) do
      allow(items_with_deleted).to receive(:find).with(2).and_return item
      allow(folders_with_deleted).to receive(:find).with(3).and_return folder
    end

    context 'readers' do
      it { is_expected.to respond_to :item }
      it { is_expected.to respond_to :folder }
    end

    describe '#restore' do
      before(:each) do
        allow(item).to receive(:restore)
        allow(folder).to receive(:restore)
      end

      after(:each) do
        subject.restore
      end

      it 'should restore item' do
        expect(item).to receive(:restore)
      end

      it 'should restore folder' do
        expect(folder).to receive(:restore)
      end
    end
  end
end
