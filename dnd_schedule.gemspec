require_relative 'lib/dnd_schedule/version'

Gem::Specification.new do |spec|
  spec.name          = "dnd_schedule"
  spec.license       = "MIT"
  spec.version       = DndSchedule::VERSION
  spec.authors       = ["Mel Riffe"]
  spec.email         = ["mel@juicyparts.com"]

  spec.summary       = %q{Calculate and display upcoming D&D game sessions.}
  spec.description   = %q{Calculate and display upcoming D&D game sessions.}
  spec.homepage      = "https://melriffe.com/dnd_schedule"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/melriffe/dnd_schedule"
  spec.metadata["changelog_uri"] = "https://github.com/melriffe/dnd_schedule/blob/master/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "https://github.com/melriffe/dnd_schedule/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/dnd_schedule"

  spec.files       = Dir["lib/**/*"]
  spec.bindir      = "exe"
  spec.executables = %w[dnd_schedule]

  spec.extra_rdoc_files = Dir["README.md", "CHANGELOG.md", "LICENSE.txt"]

  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # NOTE: Watch for a new release of TTY, and then change these dependencies.
  spec.add_dependency "tty", "~> 0.10.0"
  spec.add_dependency "bundler", "~> 1.16", "< 2.0"

end
