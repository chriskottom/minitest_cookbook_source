class User < ActiveRecord::Base
  has_secure_password

  validates      :name, presence: true, uniqueness: true

  after_destroy  :ensure_a_user_remains

  def self.authenticate(name, password)
    find_by(name: name).try(:authenticate, password)
  end

  private

  def ensure_a_user_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
end
