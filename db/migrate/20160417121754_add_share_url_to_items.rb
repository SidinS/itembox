class AddShareUrlToItems < ActiveRecord::Migration
  def change
    add_column :items, :share_url, :string, default: nil, index: true
  end
end
