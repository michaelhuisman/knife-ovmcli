require 'rubygems/package_task'
require 'fileutils'

GEMSPEC = eval(File.read('knife-ovmcli.gemspec'))

spec = Gem::Specification.load(Dir['*.gemspec'].first)
gem = Gem::PackageTask.new(GEMSPEC)
gem.define

desc "Push gem to rubygems.org"
task :push => :gem do
  sh "gem push #{gem.package_dir}/#{gem.gem_file}"
end

desc "Clean old gem build"
task :clean do
  pkg_dir = File.join(File.dirname(__FILE__), 'pkg')
  FileUtils.rm_rf(pkg_dir) if Dir.exists? pkg_dir
end

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:style)

task default: [ :spec, :style ]
