shared_context 'application controller' do
  let(:user) { double :user }

  before :each do
    allow(controller).to receive(:current_user).and_return user
    allow(controller).to receive(:authenticate_user!)
    allow(controller).to receive(:set_locale)
  end
end
