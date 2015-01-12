class AddReferenceToTranslatedModelTranslations < ActiveRecord::Migration
  def change
    add_reference :translated_model_translations, :translated, polymorphic: true, null: false
    remove_index :translated_model_translations, :key
    #add_index :translated_model_translations, [:translated_id, :translated_type, :key], unique: true
  end
end
