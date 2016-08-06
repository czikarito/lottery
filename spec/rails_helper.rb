# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'selleo_controller_tests'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include Devise::Test::ControllerHelpers, type: :controller

  config.use_transactional_fixtures = true

  config.extend Selleo::ControllerMacros, type: :controller
  config.include(Selleo::XhrPersistence)

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
