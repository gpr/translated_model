
require 'translated_model/engine'
require 'translated_model/acts_as_translated_model'

module TranslatedModel

  @@configured = false
  def self.configured? #:nodoc:
    @@configured
  end

  mattr_accessor :use_rails_admin
  @@use_rails_admin = false


  def self.config
    @@configured = true
    yield self
  end

end

require 'translated_model/railtie' if defined?(Rails)