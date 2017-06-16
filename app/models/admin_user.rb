class AdminUser < ApplicationRecord

  has_secure_password

  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, through: :section_edits

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  FORBIDDEN_USERNAMES = %w[littlebopeep humptydumpty marymary].freeze
  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { within: 8..25 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: EMAIL_REGEX }, confirmation: true

  validate :username_is_allowed
  # validate :no_new_users_on_friday, on: :create

  private

  def username_is_allowed
    return unless FORBIDDEN_USERNAMES.include?(username)
    errors.add(:username, 'has been restricted from use.')
  end

  # def no_new_users_on_friday
  #   return unless Time.now.wday == 5
  #   errors.add(:base, 'No new users on Fridays.')
  # end

end
