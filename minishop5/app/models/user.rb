class User < ActiveRecord::Base
  has_secure_password

  validates      :name, presence: true, uniqueness: true

  def self.authenticate(name, password)
    find_by(name: name).try(:authenticate, password)
  end
end
