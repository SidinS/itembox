require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  context 'constants' do
    it { expect(described_class::NEW_ACTION_NAME).to eq 'new' }
    it { expect(described_class::CREATE_ACTION_NAME).to eq 'create' }
    it { expect(described_class::REGISTRATION_CONTROLLER_NAME).to eq 'registration' }
    it { expect(described_class::APPLICATION_CONTROLLER_NAME).to eq 'application' }
  end

  context 'filters' do
    it { is_expected.to use_before_action :configure_permitted_parameters }
  end

  describe '#configure_permitted_parameters' do
    let(:sanitizer) { double :sanitizer }
    let(:account_update_parameters) { [] }

    before(:each) do
      allow(controller).to receive(:devise_parameter_sanitizer).and_return sanitizer
      allow(sanitizer).to receive(:for).with(:account_update).and_return account_update_parameters
    end

    it 'should add time zone and locale id to account update parameters' do
      controller.send :configure_permitted_parameters
      expect(account_update_parameters).to match_array %i(time_zone locale_id)
    end
  end

  describe '#controller_layout' do
    it 'should be REGISTRATION_CONTROLLER_NAME if action is new' do
      expect(controller.send(:controller_layout, described_class::NEW_ACTION_NAME)).
        to eq described_class::REGISTRATION_CONTROLLER_NAME
    end

    it 'should be REGISTRATION_CONTROLLER_NAME if action is create' do
      expect(controller.send(:controller_layout, described_class::CREATE_ACTION_NAME)).
        to eq described_class::REGISTRATION_CONTROLLER_NAME
    end

    it 'should be REGISTRATION_CONTROLLER_NAME if action is not create and not new' do
      expect(controller.send(:controller_layout, 'show')).
        to eq described_class::APPLICATION_CONTROLLER_NAME
    end
  end
end
