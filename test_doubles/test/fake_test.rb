require 'test_helper'

class User
  attr_accessor :token

  def initialize(token)
    @token = token
  end
end

class FileUpload
  def initialize(user, file, options = {})
    @user = user
    @file = file
    @storage = options[:storage_service]
  end

  def exec
    @storage.store_file(@user, @file)
  end
end

class FakeStorageService
  attr_reader :token

  def store_file(user, file)
    @token = user.token
    @file = file.clone
  end

  def file
    @file.rewind
    @file
  end
end

class FileUploadTest < Minitest::Test
  def test_upload
    user = User.new(token: "AAABBBCCC")
    file = File.new("test/fixtures/files/dummy.txt")
	
    storage = FakeStorageService.new
    upload  = FileUpload.new(user, file, storage_service: storage)
    upload.exec
	
    assert_equal user.token, storage.token
    assert_equal file.read, storage.file.read
  end
end
