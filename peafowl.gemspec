Gem::Specification.new do |s|
  s.name               = "peafowl"
  s.version            = "0.1.1"
  s.default_executable = "peafowl"

  s.authors = ["Ali Sepehri.Kh"]
  s.summary = %q{Service Objects}
  s.description = %q{Decorate your code like a Peafowl}
  s.email = %q{ali.sepehri.kh@gmail.com}
  s.homepage = %q{http://rubygems.org/gems/peafowl}
  s.license = "MIT"

  s.files = ["Rakefile", "lib/peafowl.rb"]
  s.test_files = s.files.grep(/^spec/)
  s.require_paths = ["lib"]

  s.add_dependency 'interactor', '~> 3.0'
  s.add_dependency 'virtus'
  s.add_dependency 'activemodel', '>= 4', '< 6'
end
