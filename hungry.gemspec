# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = 'hungry'
  s.version     = '0.1.2'
  s.authors     = ['Tom-Eric Gerritsen']
  s.email       = ['tomeric@eet.nu']
  s.homepage    = 'http://github.com/eet-nu/hungry'
  s.summary     = %q{An interface to the Eet.nu API.}
  s.description = %q{An interface to the Eet.nu API.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  # specify any dependencies here:
  s.add_dependency 'httparty'
end
