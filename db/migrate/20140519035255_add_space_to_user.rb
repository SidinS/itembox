class AddSpaceToUser < ActiveRecord::Migration
  def change
    add_column :users, :space, :integer, default: 524_288_000
  end
end
