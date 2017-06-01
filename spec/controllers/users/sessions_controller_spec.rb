require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  context 'constants' do
    it { expect(described_class::NEW_ACTION_NAME).to eq 'new' }
    it { expect(described_class::REGISTRATION_CONTROLLER_NAME).to eq 'registration' }
    it { expect(described_class::APPLICATION_CONTROLLER_NAME).to eq 'application' }
  end

  describe '#controller_layout' do
    it 'should be REGISTRATION_CONTROLLER_NAME if action is new' do
      expect(controller.send(:controller_layout, described_class::NEW_ACTION_NAME)).
        to eq described_class::REGISTRATION_CONTROLLER_NAME
    end

    it 'should be REGISTRATION_CONTROLLER_NAME if action is not new' do
      expect(controller.send(:controller_layout, 'show')).
        to eq described_class::APPLICATION_CONTROLLER_NAME
    end
  end
end
