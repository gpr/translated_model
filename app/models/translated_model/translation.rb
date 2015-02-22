module TranslatedModel
  class Translation < ActiveRecord::Base
    belongs_to :translated, polymorphic: true

    private

    rails_admin do
      object_label_method :value
    end if TranslatedModel.use_rails_admin
  end
end
