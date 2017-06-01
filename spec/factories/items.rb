FactoryGirl.define do
  factory :item, class: Item do
    file Rack::Test::UploadedFile.new File.open(File.join(Rails.root, '/spec/fixtures/carrierwave/IMG_1.png'))
  end
end
