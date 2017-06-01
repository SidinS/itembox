require 'rails_helper'

RSpec.describe User, type: :model do
  context 'schema' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string) }
    it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
    it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:sign_in_count).of_type(:integer) }
    it { is_expected.to have_db_column(:current_sign_in_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:last_sign_in_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:current_sign_in_ip).of_type(:string) }
    it { is_expected.to have_db_column(:last_sign_in_ip).of_type(:string) }
    it { is_expected.to have_db_column(:confirmation_token).of_type(:string) }
    it { is_expected.to have_db_column(:confirmed_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:confirmation_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:unconfirmed_email).of_type(:string) }
    it { is_expected.to have_db_column(:failed_attempts).of_type(:integer) }
    it { is_expected.to have_db_column(:unlock_token).of_type(:string) }
    it { is_expected.to have_db_column(:locked_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:space).of_type(:integer) }
    it { is_expected.to have_db_column(:time_zone).of_type(:string) }
    it { is_expected.to have_db_column(:locale_id).of_type(:integer) }
  end

  context 'constants' do
    it { expect(described_class::MAX_EMAIL_LENGTH).to eq 100 }
    it { expect(described_class::MIN_EMAIL_LENGTH).to eq 5 }
    it { expect(described_class::MAX_PERCENT).to eq 100 }
  end

  context 'references' do
    it { is_expected.to have_many :folders }
    it { is_expected.to have_many :items }
    it { is_expected.to belong_to :locale }
  end

  context 'validations' do
    it { is_expected.to validate_length_of(:email).is_at_least(5).is_at_most(100) }
  end

  describe '#free_space' do
    let(:item1) { double :item, size: 10 }
    let(:item2) { double :item, size: 20 }

    it 'should return free space for user' do
      allow(subject).to receive(:items).and_return [item1, item2]
      allow(subject).to receive(:space).and_return 500
      expect(subject.free_space).to eq 470
    end
  end

  describe '#used_space' do
    it 'should return used space for user' do
      allow(subject).to receive(:free_space).and_return 470
      allow(subject).to receive(:space).and_return 500
      expect(subject.used_space).to eq 30
    end
  end

  describe '#used_space_percent' do
    it 'should return used space percent for user' do
      allow(subject).to receive(:used_space).and_return 470
      allow(subject).to receive(:space).and_return 500
      expect(subject.used_space_percent).to eq 94.0
    end
  end

  describe '#free_space_percent' do
    it 'should return free space percent for user' do
      allow(subject).to receive(:used_space_percent).and_return 6.0
      expect(subject.free_space_percent).to eq 94.0
    end
  end

  describe '#free_space?' do
    let(:item) { double :item, size: 10 }

    it 'should be true if used space + item size < space' do
      allow(subject).to receive(:used_space).and_return 470
      allow(subject).to receive(:space).and_return 520
      expect(subject.free_space?(item)).to be true
    end

    it 'should be false if used space + item size > space' do
      allow(subject).to receive(:used_space).and_return 470
      allow(subject).to receive(:space).and_return 475
      expect(subject.free_space?(item)).to be false
    end
  end
end
