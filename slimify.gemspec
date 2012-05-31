Gem::Specification.new do |s|
  s.name        = 'slimify'
  s.version     = '0.0.0'
  s.executables << 'slimify'
  s.date        = '2012-05-31'
  s.summary     = "Convert .erb files to .slim files"
  s.description = "Convert from .erb to .haml and them .haml to .erb, with some other tweaks along the way"
  s.authors     = ["Jonathan Slate"]
  s.email       = 'jonathan@ourstage.com'
  s.files       = ["lib/slimify.rb"]
  s.homepage    = 'http://rubygems.org/gems/slimify'
  s.add_dependency('haml')
  s.add_dependency('hpricot')
  s.add_dependency('ruby_parser')
  s.add_dependency('haml2slim')
end