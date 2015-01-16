class AddReferenceToTranslatedModelTranslations < ActiveRecord::Migration
  def change
    add_reference :translated_model_translations, :translated, polymorphic: true
    remove_index :translated_model_translations, :key
  end
end
