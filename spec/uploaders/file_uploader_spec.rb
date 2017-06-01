require 'rails_helper'

RSpec.describe FileUploader do
  subject { described_class.new build(:item) }

  before(:each) do
    subject.store! Rack::Test::UploadedFile.new File.open(File.join(Rails.root, '/spec/fixtures/carrierwave/IMG_1.png'))
  end

  describe '#store_dir' do
    it 'should return file store dir' do
      expect(subject.store_dir.to_s).to eq "#{Rails.root}/uploads/item//"
    end
  end

  describe '#cache_dir' do
    it 'should return file cache dir' do
      expect(subject.cache_dir.to_s).to eq '/tmp/cache/item//'
    end
  end
end
