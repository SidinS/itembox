class UserObserver < ActiveRecord::Observer
  def before_create(user)
    user.locale = Locale.find_by(name: 'ru-RU'.freeze)
  end

  def after_create(user)
    user.folders.create! title: 'root_folder'.freeze
  end

  def before_destroy(user)
    user.items.find_each(&:really_destroy!)
    user.folders.find_each(&:really_destroy!)
  end
end
