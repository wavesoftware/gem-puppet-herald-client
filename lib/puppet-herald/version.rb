# A module for Herald
module PuppetHerald
  # Prepare version
  #
  # @param desired [String] a desired version
  # @return [String] a prepared version
  def self.version_prep(desired)
    version = desired
    if desired.match(/[^0-9\.]+/)
      git = `git describe --tags --dirty --always`
      version += '.' + git.gsub('-', '.')
    end
    version.strip
  end

  # Version for Herald Client
  VERSION     = version_prep '1.0.1.pre'
  # Lincense for Herald Client
  LICENSE     = 'Apache-2.0'
  # Project name
  NAME        = 'Puppet Herald Client'
  # Package (gem) for Herald Client
  PACKAGE     = 'puppet-herald-client'
  # A summary info
  SUMMARY     = 'a client for Puppet report processor'
  # A description info
  DESCRIPTION = 'Provides a client for Puppet Herald'
  # A homepage for Herald
  HOMEPAGE    = 'https://github.com/wavesoftware/gem-puppet-herald-client'
end
