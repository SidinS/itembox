require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'schema' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:file).of_type(:string) }
    it { is_expected.to have_db_column(:folder_id).of_type(:integer) }
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:removed).of_type(:boolean) }
    it { is_expected.to have_db_column(:favorite).of_type(:boolean) }
    it { is_expected.to have_db_column(:deleted_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:share_url).of_type(:string) }
  end

  context 'references' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :folder }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:file) }
  end

  context 'delegated methods' do
    it { is_expected.to delegate_method(:size).to(:file) }
  end

  describe '#favorites' do
    it 'should return only favorites items' do
      folder1 = build :item, favorite: false
      folder1.save!(validate: false)
      folder2 = build :item, favorite: true
      folder2.save!(validate: false)

      expect(described_class.favorites).to match_array [folder2]
    end
  end

  describe '#for_cleanup' do
    it 'should return items where was remove > 30 days ago' do
      Timecop.freeze Time.new(2016).utc do
        folder1 = build :item, deleted_at: Time.new(2015, 12, 15).utc
        folder1.save!(validate: false)
        folder2 = build :item, deleted_at: Time.new(2015, 10, 15).utc
        folder2.save!(validate: false)

        expect(described_class.with_deleted.for_cleanup).to match_array [folder2]
      end
    end
  end

  describe '#recents' do
    it 'should return items where was created < 30 days ago' do
      Timecop.freeze Time.new(2016).utc do
        folder1 = build :item, created_at: Time.new(2015, 12, 15).utc
        folder1.save!(validate: false)
        folder2 = build :item, created_at: Time.new(2015, 10, 15).utc
        folder2.save!(validate: false)

        expect(described_class.recents).to match_array [folder1]
      end
    end
  end

  describe '#shared' do
    it 'should return only favorites items' do
      folder1 = build :item, share_url: nil
      folder1.save!(validate: false)
      folder2 = build :item, share_url: 'url'
      folder2.save!(validate: false)

      expect(described_class.shared).to match_array [folder2]
    end
  end

  describe '#filename' do
    let(:file) { double :file, file: mounted_file }
    let(:mounted_file) { double :file, filename: 'filename' }

    it 'should return filename of file' do
      allow(subject).to receive(:file).and_return file
      expect(subject.filename).to eq 'filename'
    end
  end

  describe '#favorite!' do
    let(:item) { build :item }

    it 'should update attribute' do
      expect(item.favorite?).to be false
      item.favorite!
      expect(item.reload.favorite?).to be true
    end
  end

  describe '#share?' do
    it 'should be true if share url present' do
      allow(subject).to receive(:share_url).and_return 'url'
      expect(subject.share?).to be true
    end

    it 'should be false if share url is not present' do
      expect(subject.share_url?).to be false
    end
  end
end
