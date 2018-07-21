lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/match_ignoring_whitespace/version'

Gem::Specification.new do |s|
  s.name = 'rspec-match_ignoring_whitespace'
  s.version = RSpec::MatchIgnoringWhitespace::VERSION

  s.summary = 'RSpec matcher to compare strings ignoring whitespace'
  s.description = 'RSpec matcher to compare strings ignoring whitespace'

  s.authors = ['Paul A. Jungwirth']
  s.homepage = 'https://github.com/pjungwir/rspec-match_ignoring_whitespace'
  s.email = ['pj@illuminatedcomputing.com']

  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.executables = []
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,fixtures}/*`.split("\n")

  s.add_dependency 'rspec', '>= 3.2.0'
  s.add_dependency 'levenstein_with_path'
  s.add_dependency 'word_wrap'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rubocop'
end
