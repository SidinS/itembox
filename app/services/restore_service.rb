class RestoreService
  attr_reader :item, :folder

  def initialize(user, item_id)
    @item = user.items.with_deleted.find(item_id)
    @folder = user.folders.with_deleted.find(item.folder_id)
  end

  def restore
    item.restore
    folder.restore
  end
end
