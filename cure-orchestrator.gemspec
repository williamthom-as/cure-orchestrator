# frozen_string_literal: true

require_relative "lib/cure/orchestrator/version"

Gem::Specification.new do |spec|
  spec.name = "cure-orchestrator"
  spec.version = Cure::Orchestrator::VERSION
  spec.authors = ["william"]
  spec.email = ["me@williamthom.as"]

  spec.summary = "A frontend to manage Cure transforms"
  spec.homepage = "https://github.com/williamthom-as/cure-orchestrator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/williamthom-as/cure-orchestrator"
  spec.metadata["changelog_uri"] = "https://github.com/williamthom-as/cure-orchestrator/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "sinatra", "~> 3.0.6"
  spec.add_dependency "sinatra-contrib", "~> 3.0.6"
  spec.add_dependency "puma", "~> 6.3.0"
end
