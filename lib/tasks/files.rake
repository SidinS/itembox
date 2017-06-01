namespace :files do
  task cleanup: :environment do
    Item.for_cleanup.find_each(&:really_destroy!)
    Folder.for_cleanup.find_each(&:really_destroy!)
  end
end
