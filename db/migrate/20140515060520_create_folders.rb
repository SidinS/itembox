class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string	:title, default: 'Untitled Folder'
      t.references :root_folder, default: 0, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
