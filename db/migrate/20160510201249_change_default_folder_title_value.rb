class ChangeDefaultFolderTitleValue < ActiveRecord::Migration
  def up
    change_column_default :folders, :title, 'untitled_folder'
  end

  def down
    change_column_default :folders, :title, 'Untitled Folder'
  end
end
