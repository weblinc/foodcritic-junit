$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "foodcritic/junit"
require 'pry'

def seed_dir
  Pathname.new(File.expand_path('../seed', __FILE__))
end
