require 'rails_helper'

RSpec.describe Locale, type: :model do
  context 'schema' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  context 'references' do
    it { is_expected.to have_many :users }
  end
end
