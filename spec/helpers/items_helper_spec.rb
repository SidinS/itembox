require 'rails_helper'

RSpec.describe ItemsHelper, type: :helper do
  context 'constants' do
    it { expect(described_class::ICON_TRASH_CLASS).to eql 'icon-trash' }
    it { expect(described_class::FAVORITE_CLASS).to eql 'icon-star' }
    it { expect(described_class::NOT_FAVORITE_CLASS).to eql 'icon-star-empty' }
    it { expect(described_class::NOT_SHARE_CLASS).to eql 'icon-share' }
    it { expect(described_class::SHARE_CLASS).to eql 'icon-check' }
  end

  describe '#link_to_destroy_item' do
    let(:item) { double :item, folder: folder }
    let(:folder) { double :folder }

    it 'should return link to item' do
      allow(helper).to receive(:t).with('item.destroy_confirmation').and_return 'message'
      allow(helper).to receive(:t).with('item.destroy_title').and_return 'title'
      allow(helper).to receive(:folder_item_path).with(folder, item).and_return 'item_path'
      expect(helper.link_to_destroy_item(item)).to eq '<a data-confirm="message" class="icon-trash"' \
        ' title="title" rel="nofollow" data-method="delete" href="item_path"></a>'
    end
  end

  describe '#link_to_favorite' do
    let(:item) { double :item, favorite?: true }

    it 'should return link to remove item from favorites if favorite is true' do
      allow(helper).to receive(:t).with('item.remove_from_favorites_title').and_return 'title'
      allow(helper).to receive(:favorite_path).with(item).and_return 'remove_favorite_path'
      expect(helper.link_to_favorite(item)).to eq '<a class="icon-star"' \
        ' title="title" rel="nofollow" data-method="delete" href="remove_favorite_path"></a>'
    end

    it 'should return link to add item to favorites if favorite is false' do
      allow(item).to receive(:favorite?).and_return false
      allow(helper).to receive(:t).with('item.add_to_favorites_title').and_return 'title'
      allow(helper).to receive(:favorites_path).with(id: item).and_return 'add_favorite_path'
      expect(helper.link_to_favorite(item)).to eq '<a class="icon-star-empty"' \
        ' title="title" rel="nofollow" data-method="post" href="add_favorite_path"></a>'
    end
  end

  describe '#link_to_restore' do
    let(:item) { double :item }

    it 'should return link to item' do
      allow(helper).to receive(:t).with('item.restore_title').and_return 'title'
      allow(helper).to receive(:restore_path).with(item).and_return 'restore_item_path'
      expect(helper.link_to_restore(item)).to eq '<a title="title" rel="nofollow"' \
        ' data-method="put" href="restore_item_path"></a>'
    end
  end

  describe '#link_to_share' do
    let(:item) { double :item, share?: true }

    it 'should return link to remove item from shared if share is true' do
      allow(helper).to receive(:t).with('item.remove_from_shared_title').and_return 'title'
      allow(helper).to receive(:share_path).with(item).and_return 'remove_share_path'
      expect(helper.link_to_share(item)).to eq '<a class="icon-check"' \
        ' title="title" rel="nofollow" data-method="delete" href="remove_share_path"></a>'
    end

    it 'should return link to add item to shared if share is false' do
      allow(item).to receive(:share?).and_return false
      allow(helper).to receive(:t).with('item.add_to_shared_title').and_return 'title'
      allow(helper).to receive(:share_index_path).with(id: item).and_return 'add_to_shared_path'
      expect(helper.link_to_share(item)).to eq '<a class="icon-share"' \
        ' title="title" rel="nofollow" data-method="post" href="add_to_shared_path"></a>'
    end
  end

  describe '#item_actions' do
    let(:item) { double :item }

    it 'should return raw string with all links' do
      allow(helper).to receive(:link_to_destroy_item).with(item).and_return '<alert>link_to_destroy</alert>'
      allow(helper).to receive(:link_to_favorite).with(item).and_return 'link_to_favorite'
      allow(helper).to receive(:link_to_share).with(item).and_return 'link_to_share'
      expect(helper.item_actions(item)).to eq '<alert>link_to_destroy</alert> link_to_favorite link_to_share'
    end
  end
end
