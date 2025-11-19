# frozen_string_literal: true

require_relative 'lib/elastic_op/version'

Gem::Specification.new do |spec|
  spec.name = 'elastic_op'
  spec.version = ElasticOp::VERSION
  spec.authors = ['Thomas Tych']
  spec.email = ['thomas.tych@gmail.com']

  spec.summary = 'Elastic Operation command'
  spec.description = 'To run specific operation on Elastic'
  spec.homepage = 'https://gitlab.com/ttych/elastic_op.rb'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'
  # spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"
  # spec.metadata["allowed_push_host"] =

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/ .gitlab-ci.yml .rubocop.yml])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bump', '~> 0.10.0'
  spec.add_development_dependency 'byebug', '~> 12.0'
  spec.add_development_dependency 'irb', '~> 1.15', '>= 1.15.2'
  spec.add_development_dependency 'minitest', '~> 5.25', '>= 5.25.5'
  spec.add_development_dependency 'minitest-focus', '~> 1.4'
  spec.add_development_dependency 'rake', '~> 13.3'
  spec.add_development_dependency 'rubocop', '~> 1.81', '>= 1.81.1'
  spec.add_development_dependency 'rubocop-minitest', '~> 0.38', '>= 0.38.2'
  spec.add_development_dependency 'rubocop-rake', '~> 0.7', '>= 0.7.1'
  spec.add_development_dependency 'simplecov', '~> 0.22'

  spec.add_dependency 'elasticsearch'
  spec.add_dependency 'gli', '~> 2.22', '>= 2.22.2'
end
