class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :file
      t.references :folder, index: true
      t.references :user,	index: true

      t.timestamps
    end
  end
end
