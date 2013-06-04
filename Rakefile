require 'rubygems'

#
# Tests
#
require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  test.verbose = true
  test.libs << "test"
  test.libs << "lib"
  test.test_files = FileList['test/**/test_*.rb']
end
task :default => :test

#
# Documents
#
require 'rdoc/task'

Rake::RDocTask.new(:rdoc) do |rd|
  rd.rdoc_dir = 'rdoc'
  rd.title = 'gtoc'
  rd.options << '--line-numbers' << '--inline-source' << '--charset=UTF-8'
  rd.rdoc_files.include('MIT-LICENSE')
  rd.rdoc_files.include('lib/**/*.rb')
end
