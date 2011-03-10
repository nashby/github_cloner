require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

$LOAD_PATH.unshift('lib')

require 'rake'
require 'jeweler'
require 'github_cloner/version'

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "github_cloner"
  gem.homepage = "http://github.com/nashby/github_cloner"
  gem.version = Cloner::Version::STRING
  gem.license = "MIT"
  gem.executables = ["github_cloner"]
  gem.summary = %Q{an easy way to clone all your projects from github}
  gem.description = %Q{an easy way to clone all your projects from github}
  gem.email = "younash@gmail.com"
  gem.authors = ["Vasiliy Ermolovich"]
  gem.files.include Dir.glob('lib/**/*.rb')
  gem.files.exclude 'pkg'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "github_cloner #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
