module FoldersHelper
  ICON_TRASH_CLASS = 'icon-trash'.freeze

  def link_to_destroy_folder(folder)
    link_to ApplicationHelper::BLANK_LINK, folder_path(folder), method: :delete,
                                                                data: { confirm: t('folder.destroy_confirmation') },
                                                                class: ICON_TRASH_CLASS,
                                                                title: t('folder.destroy_title')
  end
end
