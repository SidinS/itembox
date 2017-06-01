class AddRemovedToItem < ActiveRecord::Migration
  def change
    add_column :items, :removed, :boolean, default: false
  end
end
