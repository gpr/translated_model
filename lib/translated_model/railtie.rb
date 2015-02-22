require 'rails/railtie'

module TranslatedModel
  class Railtie < Rails::Railtie
    config.eager_load_namespaces << TranslatedModel

    config.after_initialize do
      unless TranslatedModel.configured?
        warn '[Translated Model] Translated Model is not configured in the application and will use the default values.'
      end
    end
  end
end