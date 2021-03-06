require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'rspec/rails'
require 'webmock/rspec'
require 'paperclip/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.fail_fast = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
  config.color = true
  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Default
  config.include Paperclip::Shoulda::Matchers

  config.before(:each) do
    admin = create(:user, email: 'admin@admin.com', password: 'admin_bro')
  end
end

Capybara.javascript_driver = :webkit
WebMock.disable_net_connect!(allow_localhost: true)
