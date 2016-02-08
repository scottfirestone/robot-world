ENV["RACK_ENV"] ||= "test"

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'tilt/erb'
require 'capybara'
require 'capybara/dsl'


DatabaseCleaner[:sequel, {:connection => Sequel.sqlite("db/robot_world_test.sqlite3")}].strategy = :truncation

module TestHelpers
  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def robot_world
    database = Sequel.sqlite("db/robot_world_test.sqlite3")
    @robot_world ||= RobotWorld.new(database)
  end
end

Capybara.app = RobotWorldApp
Capybara.save_and_open_page_path = 'tmp/capybara'

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
