class User < ActiveRecord::Base
  MIN_EMAIL_LENGTH = 5
  MAX_EMAIL_LENGTH = 100
  MAX_PERCENT = 100

  has_many :folders
  has_many :items

  belongs_to :locale

  validates :email, length: MIN_EMAIL_LENGTH..MAX_EMAIL_LENGTH

  devise :database_authenticatable,
    :registerable,
    :trackable,
    :validatable,
    :confirmable,
    :lockable,
    :timeoutable,
    :rememberable

  def free_space
    space - items.to_a.sum(&:size)
  end

  def used_space
    space - free_space
  end

  def used_space_percent
    (used_space.to_f / space.to_f * MAX_PERCENT).round
  end

  def free_space_percent
    MAX_PERCENT - used_space_percent
  end

  def free_space?(item)
    (used_space + item.size) < space
  end
end
