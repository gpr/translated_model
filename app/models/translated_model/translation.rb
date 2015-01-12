module TranslatedModel
  class Translation < ActiveRecord::Base
    belongs_to :translated, polymorphic: true
  end
end
