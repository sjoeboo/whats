Gem::Specification.new do |s|
  s.name        = 'puppet-whats'
  s.version     = '0.0.2'
  s.date        = '2016-03-15'
  s.summary     = "Whats?"
  s.description = "Whats asks pupetdb about systems for you"
  s.authors     = ["Matthew Nicholson"]
  s.email       = 'matthew.a.nicholson@gmail.com'
  s.files       = ["lib/whats.rb"]
  s.executables << "whats"
  s.homepage    =
    'http://github.com/sjoeboo/whats'
  s.license       = 'MIT'
  s.add_development_dependency "bundler", "~> 1.10"
  s.add_runtime_dependency "terminal-table", "~> 1.5"
  s.add_runtime_dependency "json", "~> 1.8"
end
