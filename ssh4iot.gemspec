require_relative 'lib/ssh4iot/version'

Gem::Specification.new do |spec|
  spec.name          = "ssh4iot"
  spec.version       = Ssh4iot::VERSION
  spec.authors       = ["Michail Pantelelis"]
  spec.email         = ["mpantel@aegean.gr"]

  spec.summary       = %q{Easy way to configure and register reverse ssh tunnels for iot devices by keysharing over https to manage and enjoy}
  spec.description   = %q{Easy way to configure and register reverse ssh tunnels for iot devices by keysharing over https to manage and enjoy}
  spec.homepage      = "https://github.com/mpantel/ssh4iot"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mpantel/ssh4iot"
  spec.metadata["changelog_uri"] = "https://github.com/mpantel/ssh4iot"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rake', '~> 12.0'
  spec.add_runtime_dependency 'openssl'
  spec.add_runtime_dependency 'net-ssh'
  spec.add_runtime_dependency 'whenever'
  spec.add_runtime_dependency 'sinatra'
  spec.add_runtime_dependency 'jwt'
  spec.add_runtime_dependency 'mongoid'

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'byebug', '~> 3.0'

end
