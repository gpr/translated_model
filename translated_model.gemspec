$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'translated_model/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'translated_model'
  s.version     = TranslatedModel::VERSION
  s.authors     = ['Gregory Romé']
  s.email       = ['gregory.rome@gmail.com']
  s.homepage    = 'https://github.com/gpr/translated_model'
  s.summary     = 'Enable Model translation in database'
  s.description = 'Provide a generic way to add in application translation support'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.0'

  s.add_development_dependency 'sqlite3'
end
