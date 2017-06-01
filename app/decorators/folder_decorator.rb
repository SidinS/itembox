class FolderDecorator < Draper::Decorator
  delegate_all

  def title
    I18n.t(object.title, scope: 'folder'.freeze, default: object.title)
  end
end
