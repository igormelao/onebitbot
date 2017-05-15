require_relative '../app.rb'
require 'rspec'
require 'rack/test'
require 'ffaker'

#For all files in this directorie it will be require like above requireds
Dir["./spec/support/**/*.rb"].each  { |file| require f }
Dir["./spec/services/**.*.rb"].each { |file| require f }

set :environment, :test

module RSpecMixin
  include Rack::Test::Methods

  def app
    App
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
  ActiveRecord::Base.logger = nil unless ENV['LOG'] == true
end
