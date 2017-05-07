# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'shoulda/matchers'
require 'shoulda_helper'
require 'support/factory_girl'
require 'support/database_cleaner'
require 'support/response_helpers'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::Test::ControllerHelpers, :type => :controller
  config.include Response::JsonHelpers, :type => :controller
end
