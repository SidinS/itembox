require 'rails_helper'

RSpec.describe FolderDecorator do
  let(:folder) { build :folder }
  subject { FolderDecorator.decorate(folder) }

  describe '#title' do
    it 'should try to localize title' do
      allow(I18n).to receive(:t).with(folder.title, scope: 'folder', default: folder.title).and_return 'translation'
      expect(subject.title).to eq 'translation'
    end
  end
end
