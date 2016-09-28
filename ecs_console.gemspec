# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ecs_console/version'

Gem::Specification.new do |spec|
  spec.name          = "ecs_console"
  spec.version       = EcsConsole::VERSION
  spec.authors       = ["Ryan Schlesinger"]
  spec.email         = ["ryan@ryanschlesinger.com"]

  spec.summary       = %q{Run a remote console on ECS}
  spec.homepage      = "https://github.com/outstand/ecs_console"
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'thor', '~> 0.19'
  spec.add_runtime_dependency 'tty-command', '>= 0.2.0'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
