class Section < ApplicationRecord
  belongs_to :page
  has_many :section_edits
  has_many :admin_users, through: :section_edits

  scope :sorted, -> { order('position ASC') }

  CONTENT_TYPES = %w[text HTML].freeze

  validates :name, presence: true, length: { maximum: 255 }
  validates_inclusion_of :content_type,
                         in: CONTENT_TYPES,
                         message: "must be one of: #{CONTENT_TYPES.join(', ')}"
  validates_presence_of :content
end
