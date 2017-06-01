module ItemsHelper
  ICON_TRASH_CLASS = 'icon-trash'.freeze
  FAVORITE_CLASS = 'icon-star'.freeze
  NOT_FAVORITE_CLASS = 'icon-star-empty'.freeze
  NOT_SHARE_CLASS = 'icon-share'.freeze
  SHARE_CLASS = 'icon-check'.freeze

  def link_to_destroy_item(item)
    link_to ApplicationHelper::BLANK_LINK, folder_item_path(item.folder, item),
      method: :delete,
      data: { confirm: t('item.destroy_confirmation') },
      class: ICON_TRASH_CLASS,
      title: t('item.destroy_title')
  end

  def link_to_favorite(item)
    if item.favorite?
      link_to ApplicationHelper::BLANK_LINK, favorite_path(item),
        method: :delete,
        class: FAVORITE_CLASS,
        title: t('item.remove_from_favorites_title')
    else
      link_to ApplicationHelper::BLANK_LINK, favorites_path(id: item),
        method: :post,
        class: NOT_FAVORITE_CLASS, title: t('item.add_to_favorites_title')
    end
  end

  def link_to_restore(item)
    link_to ApplicationHelper::BLANK_LINK, restore_path(item), method: :put, title: t('item.restore_title')
  end

  def link_to_share(item)
    if item.share?
      link_to ApplicationHelper::BLANK_LINK, share_path(item),
        method: :delete,
        class: SHARE_CLASS,
        title: t('item.remove_from_shared_title')
    else
      link_to ApplicationHelper::BLANK_LINK,
        share_index_path(id: item),
        method: :post,
        class: NOT_SHARE_CLASS,
        title: t('item.add_to_shared_title')
    end
  end

  def item_actions(item)
    raw "#{link_to_destroy_item(item)} #{link_to_favorite(item)} #{link_to_share(item)}"
  end
end
