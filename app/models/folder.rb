class Folder < ActiveRecord::Base
  acts_as_paranoid

  MAX_TITLE_LENGTH = 100
  MIN_TITLE_LENGTH = 1

  belongs_to :user
  belongs_to :root_folder, class_name: 'Folder'

  has_many :items, dependent: :destroy
  has_many :subfolders, class_name: 'Folder', foreign_key: :root_folder_id, dependent: :destroy

  validate :check_similar
  validates :title, presence: true, length: MIN_TITLE_LENGTH..MAX_TITLE_LENGTH

  extend FriendlyId
  friendly_id :title, use: %i(slugged finders)

  scope :for_cleanup, -> { where('deleted_at < ?', 30.days.ago) }

  def size
    items.to_a.sum(&:size)
  end

  private

  def check_similar
    return if root_folder_id.zero?

    folder = self.class.find(root_folder_id)

    if folder.subfolders.find_by_title(title)
      errors[:base] << I18n.t('folder.validations.similar_error')
    end
  end
end
