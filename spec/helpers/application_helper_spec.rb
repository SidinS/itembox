require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  context 'constants' do
    it { expect(described_class::BLANK_LINK).to eql '' }
  end

  describe '#title' do
    it 'should create content for title' do
      expect(helper).to receive(:content_for).with(:title).and_yield { 'new_title' }
      helper.title('new_title')
    end

    it 'should return title' do
      expect(helper.title('new_title')).to eq 'new_title'
    end
  end

  describe '#humanize_date_in_time_zone' do
    let(:user) { double :user, time_zone: 'UTC' }

    it 'should return humanized date time' do
      allow(helper).to receive(:current_user).and_return user
      expect(helper.humanize_date_in_time_zone(Time.new(1993).utc)).to eq 'Thu, 31 Dec 1992 22:00:00'
    end
  end
end
