class User < ActiveRecord::Base
  has_secure_password

  has_many  :projects, foreign_key: "owner_id"
end
