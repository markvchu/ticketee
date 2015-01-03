class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true

  def to_s
    "#{email} (#{admin? ? 'Admin' : 'User'})"
  end
end
