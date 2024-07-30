lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'icodi'
  s.version     = '0.1.4'
  s.summary     = 'Deterministic Random SVG Icon Generator'
  s.description = 'Generate repeatable random icons from any string'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.homepage    = 'https://github.com/dannyben/icodi'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 3.1'

  s.add_dependency 'victor', '~> 0.2'

  s.metadata = {
    'bug_tracker_uri'       => 'https://github.com/DannyBen/icodi/issues',
    'source_code_uri'       => 'https://github.com/DannyBen/icodi',
    'changelog_uri'         => 'https://github.com/DannyBen/icodi/blob/master/CHANGELOG.md',
    'rubygems_mfa_required' => 'true',
  }
end
