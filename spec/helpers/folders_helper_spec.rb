require 'rails_helper'

RSpec.describe FoldersHelper, type: :helper do
  context 'constants' do
    it { expect(described_class::ICON_TRASH_CLASS).to eql 'icon-trash' }
  end

  describe '#link_to_destroy_folder' do
    let(:folder) { double :folder }

    it 'should return link to folder' do
      allow(helper).to receive(:t).with('folder.destroy_confirmation').and_return 'message'
      allow(helper).to receive(:t).with('folder.destroy_title').and_return 'title'
      allow(helper).to receive(:folder_path).with(folder).and_return 'folder_path'
      expect(helper.link_to_destroy_folder(folder)).to eq '<a data-confirm="message" class="icon-trash"' \
        ' title="title" rel="nofollow" data-method="delete" href="folder_path"></a>'
    end
  end
end
