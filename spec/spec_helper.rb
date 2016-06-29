require File.expand_path('../../lib/hungry',  __FILE__)

require 'fakeweb'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end
