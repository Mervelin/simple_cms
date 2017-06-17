class Page < ApplicationRecord

  acts_as_list scope: :subject

  belongs_to :subject, optional: false

  has_and_belongs_to_many :admin_users

  has_many :sections

  scope :sorted, -> { order('position ASC') }
  scope :visible, -> { where(visible: true) }

  validates :name, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { within: 3..255 }
  validates_uniqueness_of :permalink
end
