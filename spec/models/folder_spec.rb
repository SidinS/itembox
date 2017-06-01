require 'rails_helper'

RSpec.describe Folder, type: :model do
  context 'schema' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:root_folder_id).of_type(:integer) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:slug).of_type(:string) }
    it { is_expected.to have_db_column(:deleted_at).of_type(:datetime) }
  end

  context 'constants' do
    it { expect(described_class::MAX_TITLE_LENGTH).to eq 100 }
    it { expect(described_class::MIN_TITLE_LENGTH).to eq 1 }
  end

  context 'references' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to(:root_folder).class_name('Folder') }
    it { is_expected.to have_many(:items).dependent(:destroy) }

    it do
      is_expected.to have_many(:subfolders).class_name('Folder').with_foreign_key(:root_folder_id).dependent(:destroy)
    end
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(1).is_at_most(100) }
  end

  describe '#for_cleanup' do
    it 'should return items where was remove > 30 days ago' do
      Timecop.freeze Time.new(2016).utc do
        create :folder, deleted_at: Time.new(2015, 12, 15).utc
        folder = create :folder, deleted_at: Time.new(2015, 10, 15).utc

        expect(described_class.with_deleted.for_cleanup).to match_array [folder]
      end
    end
  end

  describe '#size' do
    let(:item1) { double :item, size: 10 }
    let(:item2) { double :item, size: 20 }

    it 'should return size of folder' do
      allow(subject).to receive(:items).and_return [item1, item2]
      expect(subject.size).to eq 30
    end
  end

  describe '#check_similar' do
    let(:root_folder) { double :folder }
    let(:subfolders) { double :subfolders }

    before(:each) do
      allow(subject).to receive(:root_folder_id).and_return 1
      allow(Folder).to receive(:find).with(1).and_return root_folder
      allow(root_folder).to receive(:subfolders).and_return subfolders
      allow(subfolders).to receive(:find_by_title).and_return true
      allow(subject).to receive(:errors).and_return base: []
    end

    it 'should return nil if root folder id is equal zero' do
      allow(subject).to receive(:root_folder_id).and_return 0
      expect(subject.send(:check_similar)).to be_nil
    end

    it 'should return nil if subfolder doesnt exist' do
      allow(subfolders).to receive(:find_by_title).and_return false
      expect(subject.send(:check_similar)).to be_nil
    end

    it 'should add error to errors hash' do
      subject.send :check_similar
      expect(subject.errors).
        to eq base: ['This name is already used in this folder. Please choose a different name.']
    end
  end
end
