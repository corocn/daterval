require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :console do
  require 'pry'
  require 'daterval'

  def reload!
    files = $LOADED_FEATURES.select { |feat| feat =~ /\/daterval\// }
    files.each { |file| load file }
  end

  ARGV.clear
  Pry.start
end
