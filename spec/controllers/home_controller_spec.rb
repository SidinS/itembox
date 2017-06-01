require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  include_context 'application controller'

  describe '#index' do
    it 'should redirect to folders path if current user is present' do
      expect(get(:index)).to redirect_to folders_path
    end

    it 'should redirect to folders path if current user is present' do
      allow(controller).to receive(:current_user).and_return nil
      expect(get(:index)).to redirect_to new_user_session_path
    end
  end
end
