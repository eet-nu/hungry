require 'bundler/gem_tasks'

task :console do
  require 'logger'
  require 'irb'
  require 'irb/completion'
  require_relative './lib/hungry'
  
  Hungry.logger = Logger.new(STDOUT).tap do |logger|
    logger.level = Logger::DEBUG
  end
  
  ARGV.clear
  IRB.start
end
