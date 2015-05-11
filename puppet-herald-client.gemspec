# -*- encoding: utf-8 -*-

ROOT = Pathname.new(File.expand_path('../', __FILE__))
LIB = Pathname.new('lib/puppet-herald')
ph = ROOT.join(LIB)
require ph.join('version')

Gem::Specification.new do |gem|
  gem.name          = PuppetHerald::PACKAGE
  gem.version       = PuppetHerald::VERSION
  gem.author        = 'Krzysztof Suszynski'
  gem.email         = 'krzysztof.suszynski@wavesoftware.pl'
  gem.license       = PuppetHerald::LICENSE
  gem.homepage      = PuppetHerald::HOMEPAGE
  gem.summary       = PuppetHerald::SUMMARY
  gem.description   = PuppetHerald::DESCRIPTION

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']

  # Dependencies
  gem.required_ruby_version = '>= 1.8.7'

  # Runtime
  # gem.add_runtime_dependency 'package'
end

# vim:ft=ruby
