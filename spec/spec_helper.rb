require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'
  require 'capybara/rails'
  require 'database_cleaner'
  require 'webmock/rspec'
  require 'draper/test/rspec_integration'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  # Capybara.default_host = 'http://help-me-write.dev'

  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = {
    'uid' => '1261762339',
    'provider' => 'twitter',
    'info' => {
      'nickname' => 'btlk_yo',
      'name' => 'Bee Tee',
      'description' => "very nice.",
      'image' => "http://a0.twimg.com/sticky/default_profile_images/default_profile_5_normal.png"
    },
    'credentials' => {
      'token' => "aaaa",
      'secret' => "bbbb"
    }
  }

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    #config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    #config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

    config.include Capybara::DSL
    config.include FactoryGirl::Syntax::Methods

    config.include Devise::TestHelpers, :type => :controller

    config.treat_symbols_as_metadata_keys_with_true_values = true

    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      FactoryGirl.reload
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

  end

end


Spork.each_run do

end