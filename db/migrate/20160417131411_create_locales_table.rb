class CreateLocalesTable < ActiveRecord::Migration
  class TempLocale < ActiveRecord::Base
    self.table_name = :locales
  end

  class TempUser < ActiveRecord::Base
    self.table_name = :users
  end

  def up
    create_table :locales do |t|
      t.string :title, index: true
      t.string :name, index: true
    end

    add_reference :users, :locale, index: true

    TempLocale.create!(name: 'en-US', title: 'English')
    TempLocale.create!(name: 'ru-RU', title: 'Русский')
    TempLocale.create!(name: 'by-BY', title: 'Беларуская')

    TempUser.update_all(locale_id: TempLocale.find_by(name: 'en-US').id)
  end

  def down
    drop_table :locales
    remove_reference :users, :locale, index: true
  end
end
