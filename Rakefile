require 'rspec/core/rake_task'
require 'fileutils'
require 'coveralls'

def cobertura_attrs
  require 'ox'
  f = File.open 'coverage/javascript/cobertura.xml'
  Ox.parse(f.read).root.attributes
end

def verify_js_coverage(line_expected = 0.9, branch_expected = 0.9)
  attrs = cobertura_attrs
  fail "Line coverage is #{attrs[:'line-rate'].to_f * 100}%, " \
    "that don't meet minimum requirements of #{line_expected * 100}%." if attrs[:'line-rate'].to_f < line_expected

  fail "Branch coverage is #{attrs[:'branch-rate'].to_f * 100}%, " \
    "that don't meet minimum requirements of #{branch_expected * 100}%." if attrs[:'branch-rate'].to_f < branch_expected
end

namespace :spec do
  desc 'Run all spec tests at once.'
  RSpec::Core::RakeTask.new(:all)

  desc 'Run unit spec tests.'
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = [
      'spec/unit'
    ]
  end

  desc 'Run integration spec tests.'
  RSpec::Core::RakeTask.new(:integration) do |t|
    t.pattern = [
      'spec/zzz_integration'
    ]
  end
end

tests = [:'spec:all']

begin
  require 'rubocop/rake_task'
  require 'rubocop'
  RuboCop::RakeTask.new(:rubocop) do |task|
    # don't abort rake on failure
    task.fail_on_error = true
  end

  namespace :rubocop do
    namespace :todo do
      desc 'Cleans a rubocop TODO list'
      task :clean do
        File.write('.rubocop_todo.yml', '')
        Rake::Task[:rubocop].execute
      end

      desc 'Saves actual rubocop state into TODO list'
      task :save do
        rcli = RuboCop::CLI.new
        rcli.run ['--auto-gen-config']
      end
    end
  end
  tests << :rubocop
rescue Gem::LoadError, LoadError
  # do nothing
end

begin
  require 'inch/rake'
  Inch::Rake::Suggest.new :inch, '--pedantic'
  tests << :inch
rescue Gem::LoadError, LoadError
  # do nothing here
end

Coveralls.wear! if ENV['TRAVIS']

desc 'Run lint, and all spec tests.'
task :test => tests

desc 'Build a gem package.'
task :gem do
  sh 'gem build puppet-herald.gemspec'
end

desc 'Builds, and test package'
task :build => [:test, :gem]

task :default => :test
