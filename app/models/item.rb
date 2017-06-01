class Item < ActiveRecord::Base
  acts_as_paranoid

  mount_uploader :file, FileUploader

  belongs_to :folder
  belongs_to :user

  validates :file, presence: true, file_size: { less_than: 50.megabytes }

  delegate :size, to: :file

  scope :favorites, -> { where(favorite: true) }
  scope :recents, -> { where('created_at > ?', 30.days.ago) }
  scope :for_cleanup, -> { where('deleted_at < ?', 30.days.ago) }
  scope :shared, -> { where.not(share_url: nil) }

  def filename
    @filename ||= file.file.filename
  end

  def favorite!(value = true)
    update_attribute(:favorite, value)
  end

  def share?
    share_url.present?
  end
end
