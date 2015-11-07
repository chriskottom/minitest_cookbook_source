lib_dir = File.join(File.dirname(__FILE__), "..", "lib")
puts lib_dir
$:.unshift File.expand_path(lib_dir)

require 'colored_thing'
require 'minitest/autorun'
