require File.expand_path('../../lib/eet_nu',  __FILE__)

VCR.config do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.stub_with :fakeweb
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end
